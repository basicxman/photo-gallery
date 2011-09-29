function numberOfFilesSelected() {
  var num = 0;
  $("#edit-gallery-form .image-field-group input:file").each(function() {
    if ($(this).val())
      ++num;
  });
  return num;
}

function addFileField() {
  if ($num_images_displayed < $num_images_available) {
    var selector = "#edit-gallery-form #new-images div:nth-child(" + (++$num_images_displayed + 1) + ")";
    $(selector).fadeIn();
  } else {
    var base = $(".image-field-group:last");
    var elm  = $('<div class="image-field-group"></div>');
    elm.html(base.html().replace(new RegExp($image_id, "g"), ++$image_id));
    $(elm).insertAfter(base);
    ++$num_images_displayed;
    ++$num_images_available;
  }
}

$(function() {
  $("#add-new-images").click(function() {
    $("#new-images").children("div").slideToggle();
  });

  $("#new-images .image-field-group input:text").each(function() {
    $(this).val("Image title...");
  });

  $("#new-images .image-field-group input:text").live("click", function() {
    if ($(this).val() == "Image title...")
      $(this).val("");
  });

  if ($("#new-images .field_with_errors").length == 0 && $("#new-images").length >= 1) {
    $("#new-images").children("div").hide();
    $("#edit-gallery-form .image-field-group").each(function() { $(this).hide(); });
    $("#edit-gallery-form .image-field-group:first").show();
    $num_images_displayed = 1;
    $num_images_available = $("#edit-gallery-form .image-field-group").length;
    $image_id = Number($("#edit-gallery-form .image-field-group:last input:first").attr("name").match(/\[([0-9]+)\]/)[1]);
    $("#edit-gallery-form .image-field-group input:file").live("change", function() {
      if (numberOfFilesSelected() == $num_images_displayed)
        addFileField();
    });
  }
});
