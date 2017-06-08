@users.each do |user|
  xml.url(id: user.id) do
    xml.loc user_url(user)
    xml.name user.username
    xml.occupation user.occupation
    xml.changefreq("monthly")
    xml.priority "1"
    xml.lastmod user.updated_at.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
  end
end
