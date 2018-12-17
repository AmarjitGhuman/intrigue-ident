module Intrigue
module Ident
module Check
    class Bootstrap < Intrigue::Ident::Check::Base

      def generate_checks(url)
        [
          {
            :type => "fingerprint",
            :category => "application",
            :tags => [],
            :vendor => "Bootstrap",
            :product => "Bootstrap",
            :match_details =>"boostrap css",
            :version => nil,
            :match_type => :content_body,
            :match_content =>  /bootstrap.min.css/,
            :paths => ["#{url}"]
          }
        ]
      end

    end
  end
  end
  end
