module ApplicationHelper
  def link_to(body, url, html_options = {}) 
    super body, url_options, html_options.merge(:class=>'link')
  end
  def link_to(body, url_options = {}, html_options = {}) 
    super body, url_options, html_options.merge(:class=>'link')
  end
end
