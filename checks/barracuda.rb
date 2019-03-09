module Intrigue
module Ident
module Check
  class Barracuda < Intrigue::Ident::Check::Base

    def generate_checks(url)
      [
        {
          :type => "fingerprint",
          :category => "application",
          :tags => ["WAF"],
          :url => "https://www.barracuda.com/products/webapplicationfirewall",
          :references => [
            "https://github.com/EnableSecurity/wafw00f"
          ],
          :vendor => "Barracuda",
          :product =>"Application Firewall",
          :match_details =>"cookie",
          :version => nil,
          :match_type => :content_cookies,
          :match_content =>  /barra_counter_session=/i,
          :paths => ["#{url}"]
        },
        {
          :type => "fingerprint",
          :category => "application",
          :tags => ["WAF"],
          :url => "https://www.barracuda.com/products/webapplicationfirewall",
          :references => [
            "https://github.com/EnableSecurity/wafw00f"
          ],
          :vendor => "Barracuda",
          :product =>"Application Firewall",
          :match_details =>"cookie",
          :version => nil,
          :match_type => :content_cookies,
          :match_content =>  /BNI__BARRACUDA_LB_COOKIE=/i,
          :paths => ["#{url}"]
        },
        {
          :type => "fingerprint",
          :category => "application",
          :tags => ["WAF"],
          :url => "https://www.barracuda.com/products/webapplicationfirewall",
          :references => [
            "https://github.com/EnableSecurity/wafw00f"
          ],
          :vendor => "Barracuda",
          :product =>"Application Firewall",
          :match_details =>"cookie",
          :version => nil,
          :match_type => :content_cookies,
          :match_content =>  /BNI_persistence=/i,
          :paths => ["#{url}"]
        },
        {
          :type => "fingerprint",
          :category => "application",
          :tags => ["WAF"],
          :url => "https://www.barracuda.com/products/webapplicationfirewall",
          :references => [
            "https://github.com/EnableSecurity/wafw00f"
          ],
          :vendor => "Barracuda",
          :product =>"Application Firewall",
          :match_details =>"cookie",
          :version => nil,
          :match_type => :content_cookies,
          :match_content =>  /BN[IE]S_.*?=/i,
          :paths => ["#{url}"]
        }
      ]
    end
  end
end
end
end
