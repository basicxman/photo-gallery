// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function showLightbox(options) {
  $("#lightbox").fadeIn();
  $("#lightbox-content").css(options || {});
  if (options.width) {
    $("#lightbox-header").css("width", options.width);
    $("#lightbox-header").css("width", "+=80px");
  }
}

function closeLightbox() {
  $("#lightbox").fadeOut();
}

function checkHashTag() {
  if (location.hash == "") {
    closeLightbox();
  } else {
    var anchor = $(".image a[href='" + location.hash.substring(1) + "']");
    if (anchor.length > 0)
      $.rails.fire(anchor, "click");
  }
}

$(function() {
  $("#lightbox").hide();
  $(".lightbox-close").live("click", function() {
    closeLightbox();
  });

  $(window).bind("popstate", function(event) {
    checkHashTag();
  });
});
