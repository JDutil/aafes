HoptoadNotifier.configure do |config|
  config.api_key = {:project => 'aafes', # the identifier you specified for your project in Redmine
                    :tracker => 'Bug',                           # the name of your Tracker of choice in Redmine
                    :api_key => 'hhyRvBZGtQpjzxrhqTv0',            # the key you generated before in Redmine (NOT YOUR HOPTOAD API KEY!)
                    #:category => '',                  # the name of a ticket category (optional.)
                    :assigned_to => 'jdutil',           # the login of a user the ticket should get assigned to by default (optional.)
                    :priority => 4                 # the default priority (use a number, not a name. optional.)
           }.to_yaml
  config.host = 'redmine.jdutil.com'               # the hostname your Redmine runs at
  config.port = 80                         # the port your Redmine runs at    
end