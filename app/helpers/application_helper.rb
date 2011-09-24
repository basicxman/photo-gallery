module ApplicationHelper
  def m(content)
    return "" if content.nil?
    RDiscount.new(content, :smart, :filter_styles, :no_image, :no_tables, :autolink, :safelink).to_html.html_safe
  end

  def path(url)
    request.protocol + request.host_with_port + url
  end
end
