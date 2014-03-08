module IndicatorsHelper
  def status_button(indicator)
    color =
      case indicator.current_state.status.name
      when "green"
        "btn-success"
      when "yellow"
        "btn-warning"
      when "red"
        "btn-danger"
      end

    options = {
      class: ["indicator", "btn", color].compact.join(" "),
      data: {
        title: "#{indicator.current_state.created_at.strftime("%H:%M, %b %-d, %Y")}",
        content: indicator.current_state.message || "No message"
      }
    }

    link_to "&nbsp;".html_safe, indicator_path(indicator), options
  end

  def history_row(event)
    color =
      case event.status.name
      when "green"
        "success"
      when "yellow"
        "warning"
      when "red"
        "error"
      else
        ""
      end

    content_tag :tr, class: color do
      content_tag(:td, content_tag(:i, event.created_at)) + content_tag(:td, event.message || "No message")
    end
  end
end
