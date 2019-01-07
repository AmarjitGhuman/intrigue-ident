module Intrigue
module Ident
module Check
  class Juniper < Intrigue::Ident::Check::Base

    def generate_checks(url)
      [
        {
          :type => "fingerprint",
          :category => "application",
          :tags => ["Networking", "VPN"],
          :vendor =>"Juniper",
          :product =>"Junos Pulse Secure Access Service",
          :match_details => "page title",
          :match_type => :content_title,
          :references => [],
          :match_content =>  /^Junos Pulse Secure Access Service$/,
          :version => nil,
          :paths => ["#{url}"]
        },
        {
          :type => "fingerprint",
          :category => "application",
          :tags => ["Networking", "VPN"],
          :vendor =>"Juniper",
          :product =>"Junos Pulse Secure Access Service",
          :match_details => "unique image link",
          :match_type => :content_body,
          :references => [],
          :match_content =>  /<td background="\/dana-na\/imgs\/footerbg.gif">/,
          :version => nil,
          :paths => ["#{url}"]
        },

      ]
    end

  end
end
end
end
