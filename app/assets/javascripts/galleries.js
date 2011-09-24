$(function() {
  if ($("#new-images .field_with_errors").length == 0) {
    $("#new-images").children("div").hide();
  }

  $("#add-new-images").click(function() {
    $("#new-images").children("div").slideToggle();
  });
});
