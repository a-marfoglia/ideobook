class StaticPagesController < ApplicationController
  def home
  end
  def terms
   render template: "static_pages/terms"
  end
end
