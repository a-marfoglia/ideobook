@notifications.each do |notification|
  xml.url(id: notification.id) do
    xml.loc notification_url(notification)
    xml.priority "0.8"
    xml.lastmod notification.updated_at.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
  end
end
