toggle_select_all_bookmarks = function() {
  $('#check_all').on('click', function() {
    var cbxs;
    cbxs = $('input[type="checkbox"]');
    cbxs.prop('checked', !cbxs.prop('checked'));
  });
};

$(document).ready(toggle_select_all_bookmarks);