# app/views/sitemap/_common.xml.builder

base_url = "http://#{request.host_with_port}/"

# pages = ['about.html', 'contacts.html' ]

@pages.each do |page|
  xml.url do
    xml.loc page
    xml.priority "1.0"
  end

end
