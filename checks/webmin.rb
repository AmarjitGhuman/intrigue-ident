module Intrigue
module Ident
module Check
  class Webmin < Intrigue::Ident::Check::Base

    def generate_checks(url)
      [
        {
          :type => "application",
          :vendor =>"Webmin",
          :product =>"MiniServ",
          :match_details => "server header",
          :match_type => :content_headers,
          :references => [],
          :match_content => /server: MiniServ/,
          :version => nil,
          :dynamic_version => lambda {|x| _first_header_capture(x,/server: MiniServ\/(.*)/)},
          :paths => ["#{url}"]
        },
        {
          :type => "application",
          :vendor =>"Webmin",
          :product =>"Webmin",
          :match_details => "page title",
          :match_type => :content_body,
          :references => [],
          :match_content => /<title>Login to Webmin/,
          :version => nil,
          :paths => ["#{url}"]
        }
      ]
    end

  end
end
end
end
