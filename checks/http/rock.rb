module Intrigue
module Ident
module Check
class Rock < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        :type => "fingerprint",
        :category => "application",
        :tags => ["CMS"],
        :vendor => "Rock",
        :product => "RockCMS",
        :references => ["https://www.roadiz.io/"],
        :version => nil,
        :match_type => :content_body,
        :match_content => /rock v([\d\.]+)/i,
        :dynamic_version => lambda { |x| _first_body_capture(x, /rock v([\d\.]+)/i)},
        :match_details => "header match",
        :hide => false,
        :paths => ["#{url}"],
        :inference => true
      }
    ]
  end

end
end
end
end
