module Intrigue
module Ident
module Check
    class Opscode < Intrigue::Ident::Check::Base

      def generate_checks(url)
        [
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["COTS","Development"],
            :vendor => "Opscode",
            :product =>"Chef",
            :match_details =>"Chef Server",
            :version => nil,
            :match_type => :content_body,
            :match_content =>  /<title>Chef Server<\/title>/,
            :dynamic_version => lambda{|x| _first_body_capture(x,/Version\ (.*)\ &mdash;/) },
            :paths => ["#{url}"]
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["COTS","Development"],
            :vendor => "Opscode",
            :product =>"Chef",
            :match_details =>"Chef Server",
            :version => nil,
            :match_type => :content_cookies,
            :match_content =>  /chef-manage/i,
            :paths => ["#{url}"]
          }
        ]
      end

    end
  end
  end
  end
