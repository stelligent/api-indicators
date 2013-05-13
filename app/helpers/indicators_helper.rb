module IndicatorsHelper
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

  def history_row event
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

    content_tag :tr,
      content_tag(:td,
        content_tag(:i, event.created_at)
      ) +
      content_tag(:td, event.message || "No message"),
      class: color
  end
end
