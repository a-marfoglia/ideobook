class SitemapController < ApplicationController
   respond_to :xml
  def index
    @microposts = Micropost.all
    @users = User.all
    @notifications = Notification.all
    #@categories = Category.all
    @pages = [root_url,microposts_url,microposts_url+"/new", notifications_url,
              terms_url, root_url+"users/sign_in",root_url+"users/sign_up",
              root_url+"users/password/new",root_url+"users/confirmation/new"]
    respond_to do |format|
      format.xml
    end
  end
end
