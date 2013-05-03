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
    message = indicator.current_state.message || "No message"
    content_tag :a, "&nbsp;".html_safe, class: "indicator btn #{color}", "data-content" => message
  end
end
