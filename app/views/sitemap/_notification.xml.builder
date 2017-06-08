@notifications.each do |notification|
  xml.url(id: notification.id) do
    xml.loc notification_url(notification)
    xml.notice_type notification.notice_type
    xml.to notification.user_id
    xml.from notification.subscribed_user_id
    xml.priority "0.8"
    xml.lastmod notification.updated_at.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
  end
end
