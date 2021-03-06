module Intrigue
module Ident
module Check
class Segment < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        :type => "fingerprint",
        :category => "service",
        :tags => ["Javascript", "SaaS", "APM"],
        :vendor =>"Segment",
        :product =>"Segment",
        :match_details =>"segment js",
        :version => nil,
        :match_type => :content_body,
        :match_content =>  /cdn.segment.com\/analytics.js/i,
        :paths => ["#{url}"],
        :inference => false
      }
    ]
  end

end
end
end
end
