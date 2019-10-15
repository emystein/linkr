// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function toggle_select_all_bookmarks() {
    $('#check_all').on("click", function () {
        var cbxs = $('input[type="checkbox"]');
        cbxs.prop("checked", !cbxs.prop("checked"));
    });
}

$(document).ready(toggle_select_all_bookmarks);