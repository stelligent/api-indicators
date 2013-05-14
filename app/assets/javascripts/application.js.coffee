#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require_tree .

$(document).ready ->
  # Popovers for root page
  $(".indicator").popover
    trigger: "hover"
    placement: "bottom"

  # Makes parents in description tables gray on docs page
  $(".docs table tr").children("td:contains('.')").each ->
    array = $(this).text().split "."
    property = array.pop()
    $(this).text ""
    $(this).append "<span class='quiet'>" + array.join(".") + ".</span>" + property
