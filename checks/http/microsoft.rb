module Intrigue
module Ident
module Check
    class Microsoft < Intrigue::Ident::Check::Base

      def generate_checks(url)
        [
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Framework"],
            :vendor => "Microsoft",
            :product =>"ASP.NET Default Application",
            :match_details =>"unique string",
            :version => nil,
            :match_type => :content_title,
            :match_content =>  /Home Page - My ASP.NET Application/i,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Framework"],
            :vendor => "Microsoft",
            :product =>"ASP.NET",
            :version => nil,
            :dynamic_version => lambda{|x| 
              _first_body_capture(x,/ASP.NET Version:\ ([\d\.]*)/i)},
            :match_type => :content_body,
            :match_content =>  /^.*ASP.NET is configured*$/i,
            :match_details =>"ASP.Net Error Message",
            :paths => ["#{url}", "#{url}/doesntexist-123" ], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Framework"],
            :vendor => "Microsoft",
            :product =>"ASP.NET",
            :version => nil,
            :dynamic_version => lambda{ |x| 
              _first_header_capture(x,/^x-aspnet-version:\ ([\d\.]*)/i) },
            :match_type => :content_headers,
            :match_content =>  /^x-aspnet-version:.*$/i,
            :match_details =>"X-AspNet Header",
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Framework"],
            :vendor => "Microsoft",
            :product =>"ASP.NET",
            :match_details =>"Asp.Net Cookie",
            :version => nil,
            :match_type => :content_cookies,
            :match_content =>  /ASPSESSIONID.*$/i,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Framework"],
            :vendor => "Microsoft",
            :product =>"ASP.NET",
            :match_details =>"Asp.Net Default Cookie",
            :version => nil,
            :match_type => :content_cookies,
            :match_content =>  /ASP.NET_SessionId.*$/i,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Framework"],
            :vendor => "Microsoft",
            :product =>"ASP.NET",
            :match_details =>"ASPXAUTH cookie",
            :version => nil,
            :references => [
              "https://www.sitefinity.com/developer-network/forums/developing-with-sitefinity-/claims-auth---aspxauth-cookie-remains"
            ],
            :match_type => :content_cookies,
            :match_content =>  /ASPXAUTH=/i,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Framework"],
            :vendor => "Microsoft",
            :product =>"ASP.NET MVC",
            :match_details =>"ASP.Net MVC Header",
            :version => nil,
            :dynamic_version => lambda{ |x| 
              _first_header_capture(x,/^x-aspnetmvc-version:\s([\d\.]+)/i) },
            :match_type => :content_headers,
            :match_content =>  /x-aspnetmvc-version/i,
            :paths => ["#{url}"], 
            :inference => true
          },
          #{
          #  TODO. Not the same as MVC version
          #  :type => "fingerprint",
          #  :category => "application",
          #  :tags => ["Web Framework"],
          #  :vendor => "Microsoft",
          #  :product =>"ASP.NET Core",
          #  :match_details =>"Asp.Net MVC Header",
          #  :version => nil,
          #  :dynamic_version => lambda{ |x| 
          #    _first_header_capture(x,/^x-aspnetmvc-version:\s([\d\.]+)/i) },
          #  :match_type => :content_headers,
          #  :match_content => /x-aspnetmvc-version/i,
          #  :paths => ["#{url}"], 
          #  :inference => true
          #},
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Framework"],
            :vendor => "Microsoft",
            :product =>"ASP.NET",
            :match_details => "WebResource.axd link in the page",
            :version => nil,
            :match_type => :content_body,
            :match_content =>  /WebResource.axd?d=/i,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Framework"],
            :vendor => "Microsoft",
            :product =>"ASP.NET",
            :match_details =>"unique viewstate string",
            :version => nil,
            :match_type => :content_body,
            :match_content =>  /__VIEWSTATEGENERATOR/i,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Framework"],
            :vendor => "Microsoft",
            :product =>".NET Framework",
            :match_details => "trace.axd version",
            :version => nil,
            :dynamic_version => lambda { |x| 
              _first_body_capture(x,/ASP.NET Version:([\d\.]*)/) 
            },
            :match_type => :content_body,
            :match_content =>  /Microsoft \.NET Framework Version/i,
            :paths => ["#{url}/Trace.axd"], 
            :inference => true
          },
          {
            :type => "fingerprint",
            :category => "service",
            :tags => ["Hosting"],
            :vendor => "Microsoft",
            :product =>"Azure",
            :match_details => "standard 404",
            :version => nil,
            :match_type => :content_title,
            :match_content =>  /^Microsoft Azure Web App - Error 404$/i,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "service",
            :tags => ["Hosting", "Load Balancer"],
            :vendor => "Microsoft",
            :product =>"Azure",
            :match_details => "Proxy service header (x-msedge-ref)",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /^x-msedge-ref:.*/i,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "service",
            :tags => ["Hosting", "Load Balancer"],
            :vendor => "Microsoft",
            :product =>"Azure",
            :match_details =>"Proxy header (x-ms-ref)",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /^x-ms-ref:.*/i,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "service",
            :tags => ["Hosting", "Load Balancer"],
            :vendor => "Microsoft",
            :product =>"Azure",
            :match_details =>"Storage service header",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /^x-ms-request-id:.*/i,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Framework"],
            :vendor => "Microsoft",
            :product =>"ASP.NET",
            :match_details =>"powered by header",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /x-powered-by: ASP.NET/,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["COTS"],
            :vendor => "Microsoft",
            :product =>"Commerce Server",
            :match_details =>"server header",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /commerce-server-software: Microsoft Commerce Server.*/,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Productivity","COTS", "Email"],
            :vendor => "Microsoft",
            :product =>"Exchange Server",
            :references => ["https://support.microsoft.com/en-us/help/4036163/you-can-t-access-owa-or-ecp-after-you-install-exchange-server-2016-cu6"],
            :match_details =>"x-feserver header",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /^x-feserver:.*$/i,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Productivity","COTS", "Email"],
            :vendor => "Microsoft",
            :product =>"Exchange Server",
            :references => [],
            :match_details =>"/owa/ redirect",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /^location:.*\/owa\/$/i,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Productivity","COTS", "Email"],
            :vendor => "Microsoft",
            :product =>"Exchange Server",
            :references => ["https://bit.ly/2k4Yoot"],
            :match_details =>"OWA version -> Exchange server inference (body)",
            :version => nil,
            :match_type => :content_body,
            :match_content =>  /OwaPage\ =\ ASP.auth_logon_aspx/i,
            :dynamic_version => lambda { |x|
              version_string = _first_body_capture(x, /href=\"\/owa\/auth\/(.*)\/themes\/resources\/favicon.ico/)
              owa_to_exchange_version(version_string)[:version]
            },
            :dynamic_update => lambda { |x|
              update_string = _first_body_capture(x, /href=\"\/owa\/auth\/(.*)\/themes\/resources\/favicon.ico/)
              owa_to_exchange_version(update_string)[:update]
            },
            :paths => ["#{url}"], 
            :inference => true # TODO - not specific enough yet
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Productivity","COTS", "Email"],
            :vendor => "Microsoft",
            :product =>"Exchange Server",
            :references => ["https://bit.ly/2k4Yoot"],
            :match_details =>"OWA version -> Exchange server inference (headers)",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /x-owa-version/i,
            :dynamic_version => lambda { |x|
              version_string = _first_body_capture(x, /href=\"\/owa\/auth\/(.*)\/themes\/resources\/favicon.ico/)
              owa_to_exchange_version(version_string)[:version]
            },
            :dynamic_update => lambda { |x|
              update_string = _first_body_capture(x, /href=\"\/owa\/auth\/(.*)\/themes\/resources\/favicon.ico/)
              owa_to_exchange_version(update_string)[:update]
            },
            :paths => ["#{url}"], 
            :inference => true # TODO - not specific enough yet
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Firewall"],
            :vendor => "Microsoft",
            :product =>"Forefront TMG",
            :match_details =>"Microsoft Forefront Threat Management Gateway",
            :version => nil,
            :match_type => :content_cookies,
            :match_content =>  /<title>Microsoft Forefront TMG/,
            :paths => ["#{url}"], 
            :inference => false 
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Firewall"],
            :vendor => "Microsoft",
            :product =>"Forefront TMG",
            :match_details =>"Microsoft Forefront Threat Management Gateway",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /via:\ 1.1\ TMGSRVR/,
            :paths => ["#{url}"], 
            :inference => false 
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Firewall"],
            :vendor => "Microsoft",
            :product =>"ISA Server",
            :version => "2006",
            :match_type => :content_title,
            :match_content =>  /^Microsoft ISA Server 2006$/i,
            :match_details =>"standard title",
            :paths => ["#{url}"], 
            :inference => false 
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Library"],
            :vendor =>"Microsoft",
            :product =>"Frontpage",
            :match_details =>"server header",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /^.*FrontPage\/.*$/i,
            :dynamic_version => lambda { |x|
              _first_header_capture(x,/^.*FrontPage\/([\d\.]*).*$/i)
            },
            :paths => ["#{url}"], 
            :inference => true
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Server"],
            :vendor => "Microsoft",
            :product => "Internet Information Services",
            :match_details =>"server header",
            :version => nil,
            :dynamic_version => lambda { |x|
              _first_header_capture x, /server: Microsoft-IIS\/(.*)/
            },
            :match_type => :content_headers,
            :match_content =>  /server: Microsoft-IIS\//,
            :paths => ["#{url}"], 
            :inference => false # not specific enough
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Server"],
            :vendor => "Microsoft",
            :product => "Internet Information Services",
            :match_details =>"body error messages",
            :version => nil,
            :match_type => :content_body,
            :match_content =>  /401.2 - Unauthorized: Access is denied due to server configuration.<br>Internet Information Services \(IIS\)/,
            :paths => ["#{url}"], 
            :inference => false # not specific enough
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Server"],
            :vendor => "Microsoft",
            :product =>"Internet Information Services",
            :match_details =>"Internet Information Services",
            :version => "8.0",
            :match_type => :content_body,
            :match_content =>  /<img src=\"iis-8.png\"/,
            :paths => ["#{url}"], 
            :inference => false # not specific enough
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Server"],
            :vendor => "Microsoft",
            :product =>"Internet Information Services",
            :match_details =>"Microsoft IIS 8.5",
            :version => "8.5",
            :match_type => :content_body,
            :match_content =>  /<img src=\"iis-85.png\"/,
            :paths => ["#{url}"], 
            :inference => false # not specific enough
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Server"],
            :vendor => "Microsoft",
            :product =>"Internet Information Services",
            :match_details =>"Microsoft-HTTPAPI/2.0 (IIS not configured)",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /server: Microsoft-HTTPAPI\/2.0/i,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :vendor => "Microsoft",
            :product =>"Internet Information Services",
            :match_details =>"Microsoft IIS Unauthorized (403)",
            :tags => ["error_page"],
            :version => nil,
            :match_type => :content_body,
            :hide => true,
            :match_content =>  /Error Code: 403 Forbidden. The server denied the specified Uniform Resource Locator \(URL\)/,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Server"],
            :vendor => "Microsoft",
            :product =>"Internet Information Services",
            :match_details =>"Microsoft IIS Missing Resource (404)",
            :version => nil,
            :match_type => :content_body,
            :hide => true,
            :match_content =>  /HTTP Error 404. The requested resource is not found./,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Server"],
            :vendor => "Microsoft",
            :product =>"Internet Information Services",
            :match_details =>"Microsoft IIS Generic Error - 403",
            :version => nil,
            :match_type => :content_body,
            :hide => true,
            :match_content =>  /403 Forbidden. The server denied the specified Uniform Resource Locator (URL)/,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Server"],
            :vendor => "Microsoft",
            :product =>"Internet Information Services",
            :match_details =>"Microsoft Generic Error - 503",
            :version => nil,
            :match_type => :content_body,
            :hide => true,
            :match_content =>  /HTTP Error 503. The service is unavailable./,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Web Server"],
            :vendor =>"Microsoft",
            :product =>"Kestrel",
            :references => ["https://stackify.com/what-is-kestrel-web-server/"],
            :match_details =>"kestrel in server header",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /server: Kestrel/i,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "service",
            :tags => ["Productivity","Hosted"],
            :vendor =>"Microsoft",
            :product =>"Office 365 API",
            :match_details =>"office 365 api auth cookie",
            :version => nil,
            :match_type => :content_cookies,
            :match_content =>  /x-ms-gateway-slice/i,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "service",
            :tags => ["Productivity","Hosted"],
            :vendor =>"Microsoft",
            :product =>"Office 365",
            :match_details =>"office 365 fronted by okta",
            :version => nil,
            :match_type => :content_body,
            :match_content =>  /ok3static.oktacdn.com\/assets\/img\/logos\/office365/i,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Productivity", "COTS"],
            :vendor => "Microsoft",
            :product =>"Outlook Web Access",
            :match_details =>"Microsoft Outlook Web Access (header)",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /x-owa-version/,
            :dynamic_version => lambda { |x| 
              _first_header_capture(x, /x-owa-version:(.*)/) },
            :paths => ["#{url}"], 
            :inference => true
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Productivity", "COTS"],
            :vendor => "Microsoft",
            :product =>"Outlook Web Access",
            :match_details =>"Microsoft Outlook Web Access (body)",
            :version => nil,
            :match_type => :content_body,
            :match_content =>  /OwaPage\ =\ ASP.auth_logon_aspx/,
            :dynamic_version => lambda { |x| 
              _first_body_capture x, /href=\"\/owa\/auth\/(.*)\/themes\/resources\/favicon.ico/ },
            :paths => ["#{url}"], 
            :inference => true
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Productivity", "COTS"],
            :vendor => "Microsoft",
            :product =>"Outlook Web Access",
            :match_details =>"title",
            :version => nil,
            :match_type => :content_title ,
            :match_content =>  /^Outlook Web App$/,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Productivity", "CMS"],
            :vendor => "Microsoft",
            :product =>"Sharepoint Server",
            :match_details =>"Sharepoint cookie",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /sprequestguid/,
            :dynamic_version => lambda { |x| 
              _first_header_capture(x,/^microsoftsharepointteamservices:(.*)/i) },
            :paths => ["#{url}"], 
            :inference => true
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Productivity", "CMS"],
            :vendor => "Microsoft",
            :product =>"Sharepoint Server",
            :match_details =>"Sharepoint cookie",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /^microsoftsharepointteamservices:.*$/,
            :dynamic_version => lambda { |x| 
              _first_header_capture(x,/^microsoftsharepointteamservices:(.*)/i) },
            :paths => ["#{url}"], 
            :inference => true
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Productivity", "CMS"],
            :vendor => "Microsoft",
            :product =>"Sharepoint Server",
            :match_details =>"Sharepoint cookie",
            :version => nil,
            :match_type => :content_generator,
            :match_content =>  /^Microsoft SharePoint$/,
            :paths => ["#{url}"], 
            :inference => false
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Productivity", "CMS"],
            :vendor => "Microsoft",
            :product =>"Sharepoint Services",
            :match_details =>"header",
            :version => nil,
            :match_type => :content_headers,
            :match_content =>  /microsoftofficewebserver:.*/,
            :dynamic_version => lambda { |x| _first_header_capture(x,/^microsoftofficewebserver:(.*)/i) },
            :paths => ["#{url}"], 
            :inference => true
          },
          {
            :type => "fingerprint",
            :category => "application",
            :tags => ["Productivity", "CMS"],
            :vendor => "Microsoft",
            :product =>"Sharepoint Services",
            :match_details =>"header",
            :version => "3.0",
            :match_type => :content_headers,
            :match_content =>  /microsoftofficewebserver: 5.0_Pub/,
            :paths => ["#{url}"]
          }
        ]
      end

      # https://en.wikipedia.org/wiki/Internet_Information_Services
      def iis_to_os_version(iis_version)
        case 
        when iis_version == "10.0.17763"
          { version: " Windows Server 2019 or Windows 10 October Update" }
        when iis_version == "10.0"
          { version: " Windows Server, version 1709 (Semi-Annual Channel) or Windows 10 Fall Creators Update" }          
        when iis_version == "10.0.14393" # IIS 10.0 version 1607
          { version: "Windows Server 2016 or Windows 10 Anniversary Update" }
        when iis_version == "8.5"
          { version: "Windows Server 2012 R2 or Windows 8.1" }
        when iis_version == "8.0"
          { version: "Windows Server 2012 or Windows 8" }
        when iis_version == "7.5"
          { version: "Windows Server 2008 R2 or Windows 7" }
        when iis_version == "7.0"
          { version: "Windows Server 2008 or Windows Vista" }
        when iis_version == "6.0"
          { version: "Windows Server 2003 or Windows XP Professional x64 Edition" }
        when iis_version == "5.1"
          { version: "Windows XP Professional" }
        when iis_version == "5.0"
          { version: "Windows Server 2000" }
        when iis_version == "4.0"
          { version: "Windows NT 4.0 Option Pack" }
        when iis_version == "3.0"
          { version: "Windows NT 4.0 SP2" }
        when iis_version == "2.0"
          { version: "Windows NT 4.0" }
        when iis_version == "1.0"
          { version: "Windows NT 3.51" }
        end
      out
      end

      def owa_to_exchange_version(owa_version)
        if owa_version == "15.0.516" #.32"
          out = { version: "2013", update: "RTM" }
        elsif owa_version == "15.0.620" #.29"
          out = { version: "2013", update: "Cumulative Update 1" }
        elsif owa_version == "15.0.712" #.24"
          out = { version: "2013", update: "Cumulative Update 2" }
        elsif owa_version == "15.0.775" #.38"
          out = { version: "2013", update: "Cumulative Update 3" }
        elsif owa_version == "15.0.847" #.32"
          out = { version: "2013", update: "Cumulative Update 4" }
        elsif owa_version == "15.0.913" #.22"
          out = { version: "2013", update: "Cumulative Update 5" }
        elsif owa_version == "15.0.995" #.29"
          out = { version: "2013", update: "Cumulative Update 6" }
        elsif owa_version == "15.0.1044" #.25"
          out = { version: "2013", update: "Cumulative Update 7" }
        elsif owa_version == "15.0.1076" #.9"
          out = { version: "2013", update: "Cumulative Update 8" }
        elsif owa_version == "15.0.1104" #.5"
          out = { version: "2013", update: "Cumulative Update 9" }
        elsif owa_version == "15.0.1130" #.7"
          out = { version: "2013", update: "Cumulative Update 10" }
        elsif owa_version == "15.0.1156" #.6"
          out = { version: "2013", update: "Cumulative Update 11" }
        elsif owa_version == "15.0.1178" #.4"
          out = { version: "2013", update: "Cumulative Update 12" }
        elsif owa_version == "15.0.1210" #.3"
          out = { version: "2013", update: "Cumulative Update 13" }
        elsif owa_version == "15.0.1236" #.3"
          out = { version: "2013", update: "Cumulative Update 14" }
        elsif owa_version == "15.0.1263" #.5"
          out = { version: "2013", update: "Cumulative Update 15" }
        elsif owa_version == "15.0.1293" #.2"
          out = { version: "2013", update: "Cumulative Update 16" }
        elsif owa_version == "15.0.1320" #.4"
          out = { version: "2013", update: "Cumulative Update 17" }
        elsif owa_version == "15.0.1347" #.2"
          out = { version: "2013", update: "Cumulative Update 18" }
        elsif owa_version == "15.0.1365" #.1"
          out = { version: "2013", update: "Cumulative Update 19" }
        elsif owa_version == "15.0.1367" #.3"
          out = { version: "2013", update: "Cumulative Update 20" }
        elsif owa_version == "15.0.1395" #.4"
          out = { version: "2013", update: "Cumulative Update 21" }
        elsif owa_version == "15.1.225" #.16"
          out = { version: "2016", update: "Preview" }
        elsif owa_version == "15.1.225" #.42"
          out = { version: "2016", update: "RTM" }
        elsif owa_version == "15.1.396" #.30"
          out = { version: "2016", update: "Cumulative Update 1" }
        elsif owa_version == "15.1.466" #.34"
          out = { version: "2016", update: "Cumulative Update 2" }
        elsif owa_version == "15.1.466" #.34"
          out = { version: "2016", update: "Cumulative Update 3" }
        elsif owa_version == "15.1.669" #.32"
          out = { version: "2016", update: "Cumulative Update 4" }
        elsif owa_version == "15.1.845" #.34"
          out = { version: "2016", update: "Cumulative Update 5" }
        elsif owa_version == "15.1.1034" #.26"
          out = { version: "2016", update: "Cumulative Update 6" }
        elsif owa_version == "15.1.1261" #.35"
          out = { version: "2016", update: "Cumulative Update 7" }
        elsif owa_version == "15.1.1415" #.2"
          out = { version: "2016", update: "Cumulative Update 8" }
        elsif owa_version == "15.1.1466" #.3"
          out = { version: "2016", update: "Cumulative Update 9" }
        elsif owa_version == "15.1.1531" #.3"
          out = { version: "2016", update: "Cumulative Update 10" }
        elsif owa_version == "15.1.1591" #.01"
          out = { version: "2016", update: "Cumulative Update 11" }
        else
          out = { version: "[Unknown]", update: "[Unknown]" }
        end
      end

    end
  end
  end
  end
