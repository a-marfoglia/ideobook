module ApplicationHelper
  def site_name
    t(:name)
  end
  
  def page_title(text)
    if text != ""
      "#{text} | #{site_name}"
    else
      site_name
    end
  end
end
