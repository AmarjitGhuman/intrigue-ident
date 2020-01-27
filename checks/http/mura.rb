module Intrigue
module Ident
module Check
class AlmubdaCMS < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        :type => "fingerprint",
        :category => "application",
        :tags => ["CMS"],
        :vendor => "Mura",
        :product => "Mura",
        :references => [],
        :version => nil,
        :match_type => :content_body,
        :match_content => /Mura CMS ([\d\.]+)/i,
        :dynamic_version => lambda { |x| _first_body_capture(x, /Mura CMS ([\d\.]+)/i)},
        :match_details => "Header match",
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
