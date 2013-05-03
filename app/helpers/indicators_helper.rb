module IndicatorsHelper
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
      content_tag(:td, "<i>#{event.created_at}</i>".html_safe) +
      content_tag(:td, event.message || "No message"),
      class: color
  end
end
