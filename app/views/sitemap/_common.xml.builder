@pages.each do |page|
  xml.url do
    xml.loc page
    xml.priority "1.0"
  end

end
