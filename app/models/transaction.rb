class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :client
  has_many :approvals, :dependent => :destroy
  has_many :credits, :dependent => :destroy
  has_many :settlements, :dependent => :destroy
  validates_presence_of :user_id
  validates_presence_of :client_id
  validates_presence_of(:cc_number)
  validates_presence_of(:amount)
  validates_presence_of(:auth_code)
  validates_presence_of(:auth_ticket)
  #validates_presence_of(:order_id)
  
  using_access_control
  
  def settled_amount
    total = 0
    settlements.each{ |s| total += s.amount }
    total
  end
  
  def credited_amount
    total = 0
    credits.each{ |s| total += s.amount }
    total
  end
  
  def ms_approval
    builder = Nokogiri::XML::Builder.new(:encoding=>"UTF-8") do |xml|
      xml.MSApproval(:xmlns=>"MSApproval") {
        xml.Request("ID" => self.order_id){
          xml.CCNumber self.cc_number
          xml.Amount self.amount
          xml.FacNbr client.facility_number
          xml.Region ( (Rails.env == "production") ? "P" : "T" )
        }
      }
    end
    
    return_code, return_message, auth_code, auth_ticket = send_request("inXMLApproval=#{builder.to_xml}", "MSApproval")

    if return_code == "X"
      return false, return_message
    elsif return_code == "D"
      return_message = "credit was denied and will require contact with your AAFES POC" unless return_message.present?
      return false, return_message
    elsif return_code == "A"
      self.auth_code = auth_code
      self.auth_ticket = auth_ticket
      logger.debug(self.inspect)
      return true
    end
  end
  
  def send_request(request_xml, action)
    headers = {
      "Content-Type" => "application/x-www-form-urlencoded",
      "Content-Length" => request_xml.length.to_s
    }
  
    uri = URI.parse("https://shop.aafes.com")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  
    response = http.post("/val/MilStarVendor.asmx/#{action}", request_xml, headers)
  
    doc = Nokogiri::XML(response.body)
    
    logger.debug("REQUEST XML:")
    logger.debug(request_xml)
    logger.debug("RESPONSE XML:")
    logger.debug(doc.children.first.children.text)
    
    start = Nokogiri::XML(doc.children.first.children.text)
    return_code = start.css('ReturnCode').text
    return_message = start.css('ReturnMessage').text
    auth_code = start.css('AuthCode').text
    auth_ticket = start.css('AuthTkt').text
  
    return return_code, return_message, auth_code, auth_ticket
  end
  
end