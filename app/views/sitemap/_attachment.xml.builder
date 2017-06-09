@microposts.each do |micropost|
  xml.url(id: micropost.id) do
  xml.loc micropost.attachment.path
  end
end
