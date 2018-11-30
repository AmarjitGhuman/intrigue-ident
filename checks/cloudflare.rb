module Intrigue
module Ident
module Check
    class Cloudflare < Intrigue::Ident::Check::Base

      def generate_checks(url)
        [
          {
            :type => "fingerprint",
            :category => "service",
            :tags => ["CDN"],
            :vendor => "Cloudflare",
            :product => "Cloudflare",
            :version => nil,
            :match_type => :content_cookies,
            :match_content =>  /__cfduid/i,
            :match_details =>"Cloudflare Accelerated Page",
            :paths => ["#{url}"]
          },
          {
            :type => "fingerprint",
            :category => "service",
            :tags => ["CDN"],
            :vendor => "Cloudflare",
            :product => "Cloudflare",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /cfray:/i,
            :match_details =>"header",
            :paths => ["#{url}"]
          },
          {
            :type => "fingerprint",
            :category => "service",
            :tags => ["CDN"],
            :vendor => "Cloudflare",
            :product => "Cloudflare",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /cloudflare-nginx/i,
            :match_details =>"cloudflare nginx header",
            :paths => ["#{url}"]
          },
          {
            :type => "fingerprint",
            :category => "service",
            :tags => ["CDN"],
            :vendor => "Cloudflare",
            :product => "Cloudflare",
            :version => nil,
            :match_type => :content_body,
            :match_content => /<title>Direct IP access not allowed \| Cloudflare/,
            :match_details =>"Cloudflare - Direct IP Access",
            :hide => true,
            :paths => ["#{url}"]
          },
          {
            :type => "fingerprint",
            :category => "service",
            :tags => ["CDN"],
            :vendor => "Cloudflare",
            :product => "Cloudflare",
            :match_details =>"Cloudflare Error",
            :version => "",
            :match_type => :content_body,
            :match_content =>  /cferror_details/,
            :hide => true,
            :paths => ["#{url}"]
          },
          {
            :type => "fingerprint",
            :category => "service",
            :tags => ["CDN"],
            :vendor => "Cloudflare",
            :product => "Cloudflare",
            :match_details =>"Cloudfront Error - Direct IP Access",
            :version => nil,
            :match_type => :content_body,
            :match_content =>  /403\ Forbidden<\/h1><\/center>\n<hr><center>cloudflare<\/center>/im,
            :hide => true,
            :paths => ["#{url}"]
          }
        ]
      end

    end
  end
  end
  end
