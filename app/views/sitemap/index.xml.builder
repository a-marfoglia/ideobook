xml.instruct! :xml, :version => "1.0"

xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.pages do
    xml.home do
      xml.loc root_url
      xml.changefreq("hourly")
      xml.priority "1.0"
    end
    xml.microposts  do
      xml.loc microposts_url
      xml.changefreq("monthly")
      xml.priority "1.0"
    end
    xml.newmicropost  do
      xml.loc microposts_url+"/new"
      xml.changefreq("hourly")
      xml.priority "1.0"
    end
    xml.notifications  do
      xml.loc notifications_url
      xml.changefreq("hourly")
      xml.priority "1.0"
    end
    xml.terms  do
      xml.loc terms_url
      xml.changefreq("year")
      xml.priority "1.0"
    end
    xml.sign_in  do
      xml.loc root_url+"users/sign_in"
      xml.changefreq("year")
      xml.priority "1.0"
    end
    xml.sign_up  do
      xml.loc root_url+"users/sign_up"
      xml.changefreq("year")
      xml.priority "1.0"
    end
    xml.forgot_password  do
      xml.loc root_url+"users/password/new"
      xml.changefreq("year")
      xml.priority "1.0"
    end
    xml.email_confirmation  do
      xml.loc root_url+"users/confirmation/new"
      xml.changefreq("year")
      xml.priority "1.0"
    end
  end
  @users.each do |user|
      xml.user_list do
        xml.user(id: user.id) do
          xml.loc user_url(user)
          xml.name user.username
          xml.occupation user.occupation
          xml.changefreq("monthly")
          xml.priority "0.8"
          xml.lastmod user.updated_at.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")

          xml.micropost_list do
            user.microposts.each do |micropost|
              xml.micropost(id: micropost.id) do
              xml.loc micropost_url(micropost)
              xml.title micropost.title
              xml.content micropost.content
              xml.category micropost.category_id
              xml.changefreq("daily")
              xml.priority "0.8"
              xml.lastmod micropost.updated_at.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")

              xml.comment_list do
                micropost.comments.each do |comment|
                  xml.comment(id: comment.id) do
                    xml.loc micropost_url(micropost)
                    xml.content comment.content
                    xml.priority "0.8"
                    xml.lastmod comment.updated_at.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
                  end
                end
              end

            end
          end
        end

        xml.notification_list do
          user.notifications.each do |notification|
            xml.notification(id: notification.id) do
              xml.loc notification_url(notification)
              xml.notice_type notification.notice_type
              xml.from notification.subscribed_user_id
              xml.priority "0.8"
              xml.lastmod notification.updated_at.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
            end
          end
        end

      end
    end
  end

  xml.category_list  do
    @categories.each do |category|
      xml.category(id: category.id) do
        xml.name category.name
        xml.priority "0.8"
        xml.lastmod category.updated_at.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
      end
    end
  end

end
