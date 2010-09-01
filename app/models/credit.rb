class Credit < ActiveRecord::Base
  belongs_to(:user)
  belongs_to(:transaction)
  validates_presence_of(:user_id)
  validates_presence_of(:transaction_id)
  validates_presence_of(:amount)
  
  using_access_control
  
  def ms_credit
    builder = Nokogiri::XML::Builder.new(:encoding=>"UTF-8") do |xml|
      xml.MSCredit(:xmlns=>"MSCredit") {
        xml.Request("ID" => transaction.order_id){
          xml.CCNumber transaction.cc_number
          xml.Amount self.amount
          xml.FacNbr transaction.client.facility_number
          xml.AuthCode transaction.auth_code
          xml.AuthTkt transaction.auth_ticket
          xml.Region ( (Rails.env == "production") ? "P" : "T" )
        }
      }
    end
    
    return_code, return_message, auth_code, auth_ticket = transaction.send_request("inXMLCredit=#{builder.to_xml}", "MSCredit")

    if return_code == "X"
      return false, return_message
    elsif return_code == "D"
      return_message = "credit was denied and will require contact with your AAFES POC" unless return_message.present?
      return false, return_message
    elsif return_code == "A"
      return true
    end
  end
end