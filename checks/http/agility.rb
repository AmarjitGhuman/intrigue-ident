module Intrigue
module Ident
module Check
class AgilityCMS < Intrigue::Ident::Check::Base

=begin
  def generate_checks(url)
    [
      {
        :type => "fingerprint",
        :category => "application",
        :tags => ["CMS"],
        :vendor => "Agility",
        :product => "AgilityCMS",
        :references => ["https://agilitycms.com/"],
        :version => nil,
        :match_type => :content_body,
        :match_content => /Agility CMS/i,
        :dynamic_version => lambda { |x|  _first_body_capture(x, /Agility CMS (\d+)/i)},
        :match_details => "header match",
        :hide => false,
        :paths => ["#{url}"],
        :inference => true
      }
    ]
  end
=end


end
end
end
end
