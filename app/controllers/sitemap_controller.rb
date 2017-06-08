class SitemapController < ApplicationController
   respond_to :xml
  def index
    #@microposts = Micropost.all
    @users = User.all
    @categories = Category.all
  end
end
