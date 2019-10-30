# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

toggle_select_all_bookmarks = ->
  $('#check_all').on 'click', ->
    cbxs = $('input[type="checkbox"]')
    cbxs.prop 'checked', !cbxs.prop('checked')
    return
  return

$(document).ready(toggle_select_all_bookmarks);