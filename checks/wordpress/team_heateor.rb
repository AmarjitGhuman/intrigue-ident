module Intrigue
module Ident
module Check
    class WordpressPlugins < Intrigue::Ident::Check::Base

      def generate_checks(url)
        [
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Wordpress Plugin", "Social"],
            :vendor =>"Wordpress",
            :product =>"sassy-social-share",
            :match_details =>"plugin",
            :references => [],
            :match_type => :content_body,
            :match_content =>  /wp-content\/plugins\/sassy-social-share\/public\/js\/sassy-social-share-public\.js\?ver=/i,
            :dynamic_version => lambda { |x|
              _first_body_capture(x,/wp-content\/plugins\/sassy-social-share\/public\/js\/sassy-social-share-public.js?ver=([\d\.]+)/ii)
            },
            :paths => ["#{url}"],
            :inference => true # no cves as of 20190310
          }
        ]
      end

    end
  end
  end
  end
