module Intrigue
module Ident
module Check
class DiscourseCMS < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        :type => "fingerprint",
        :category => "application",
        :tags => ["CMS"],
        :vendor => "Discourse",
        :product => "Discourse",
        :references => ["https://www.discourse.org/"],
        :version => nil,
        :match_type => :content_body,
        :match_content => /Discourse (\d....)/,
        :dynamic_version => lambda { |x| _first_body_capture(x, /Discourse (\d....)/)},
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
