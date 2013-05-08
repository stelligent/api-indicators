module PagesHelper
  def status_button indicator
    color =
      case indicator.current_state.status.name
      when "green"
        "btn-success"
      when "yellow"
        "btn-warning"
      when "red"
        "btn-danger"
      else
        ""
      end

    options = {
      :class => "indicator btn #{color}",
      "data-title" => "#{indicator.current_state.created_at.strftime("%H:%M, %b %-d, %Y")}",
      "data-content" => indicator.current_state.message || "No message"
    }

    link_to_if indicator.has_page, "&nbsp;".html_safe, indicator_path(indicator), options do
      content_tag :a, "&nbsp;".html_safe, options
    end
  end

  def api_request_code path, method
    content_tag :code, "#{method.upcase} http://#{request.env['HTTP_HOST']}/api/#{path}"
  end
end
