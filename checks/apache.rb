module Intrigue
module Ident
module Check
class Apache < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        :type => "application",
        :vendor => "Apache",
        :product =>"Ambari",
        :match_details =>"page title",
        :version => nil,
        :match_type => :content_body,
        :match_content =>  /<title>Ambari<\/title>/i,
        :paths => ["#{url}"]
      },
      {
        :type => "application",
        :vendor => "Apache",
        :product =>"Groovy",
        :match_details =>"Groovy error page",
        :match_type => :content_body,
        :version => nil,
        :match_content =>  /Error processing GroovyPageView:/i,
        :paths => ["#{url}"]
      },
      {
        :type => "application",
        :vendor => "Apache",
        :product =>"HTTP Server",
        :match_details =>"Apache web server - server header - with versions",
        :version => nil,
        :match_type => :content_headers,
        :match_content =>  /server:\ Apache[\s|\/]+[0-9]+/i,
        :dynamic_version => lambda { |x|
          _first_header_capture(x,/[s|S]erver:\s?Apache[\s|\/](.*)$/,["Apache","/","(Ubuntu)"])
        },
        :paths => ["#{url}"]
      },
      {
        :type => "application",
        :vendor => "Apache",
        :product =>"HTTP Server",
        :match_details =>"Apache web server - server header - no version",
        :version => nil,
        :match_type => :content_headers,
        :match_content =>  /server:\ Apache$/i,
        :paths => ["#{url}"]
      },
      {
        :type => "application",
        :vendor => "Apache",
        :product =>"HTTP Server",
        :match_details =>"Apache generic error",
        :version => nil,
        :match_type => :content_body,
        :match_content =>  /The server encountered an internal error or misconfiguration and was unable to complete your request./i,
        :paths => ["#{url}"]
      },
      {
        :type => "application",
        :vendor => "Apache",
        :product =>"Coyote",
        :match_details =>"Apache coyote application server - server header",
        :version => nil,
        :match_type => :content_headers,
        :match_content =>  /server:\ Apache-Coyote/i,
        :dynamic_version_field => "headers",
        :dynamic_version_regex => /server: Apache-Coyote\/(.*)/i,
        :dynamic_version => lambda { |x|
          _first_header_capture(x,/server: Apache-Coyote\/(.*)/i)
        },
        :paths => ["#{url}"]
      },
      {
        :type => "application",
        :vendor => "Apache",
        :product =>"Sling",
        :references => ["https://sling.apache.org/"],
        :match_details =>"Apache Sling™ is a framework for RESTful web-applications based on an extensible content tree. also note that this may be related to apache experience manager",
        :version => nil,
        :match_type => :content_body,
        :match_content =>  /<address>Apache Sling<\/address>/i,
        :paths => ["#{url}"]
      },
      {
        :type => "application",
        :vendor => "Apache",
        :product => "Tomcat",
        :match_details =>"Tomcat Application Server",
        :match_type => :content_body,
        :version => 6,
        :match_content =>  /<title>Tomcat 6 Welcome Page/,
        :paths => ["#{url}"]
      },

      {
        :type => "application",
        :vendor => "Apache",
        :product => "Tomcat",
        :match_details =>"Tomcat Application Server",
        :match_type => :content_body,
        :version => nil,
        :match_content =>  /<title>Apache Tomcat/,
        :dynamic_version_field => "title",
        :dynamic_version_regex => /Apache Tomcat\/(.*?) - Error report/i,
        :dynamic_version => lambda{ |x|
          _first_body_capture(x, /<title>(.*)<\/title>/,["Apache Tomcat/"," - Error report"])
        },
        :paths => ["#{url}"]
      }
    ]
  end
end
end
end
end
