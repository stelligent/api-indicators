#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require_tree .

$(document).ready ->
  $(".indicator").popover
    trigger: "hover"
    placement: "bottom"
