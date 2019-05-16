module Intrigue
module Ident
module Check
    class WordpressW3TotalCache < Intrigue::Ident::Check::Base

      def generate_checks(url)
        [
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Wordpress Plugin"],
            :vendor =>"Wordpress",
            :product =>"W3 Total Cache",
            :match_details =>"powered by header",
            :references => [],
            :match_type => :content_headers,
            :match_content =>  /x-powered-by: W3 Total Cache\/.*/i,
            :dynamic_version => lambda { |x|
              _first_header_capture(x,/x-powered-by: W3 Total Cache\/(.*)/i)
            },
            :paths => ["#{url}"],
            :inference => false
          }
        ]
      end

    end
  end
  end
  end
