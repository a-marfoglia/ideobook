module ApplicationHelper
  def site_name
    t(:name)
  end

  def page_title(text)
    if text != ""
      "#{site_name}: #{text} "
    else
      site_name
    end
  end
end
