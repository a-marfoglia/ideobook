@microposts.each do |micropost|
  xml.url(id: micropost.id) do
  xml.loc micropost_url(micropost)
  #xml.title micropost.title
  #xml.content micropost.content
  #xml.category micropost.category_id
  #xml.user_id micropost.user_id
  xml.changefreq("daily")
  xml.priority "1"
  xml.lastmod micropost.updated_at.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
  end
end
