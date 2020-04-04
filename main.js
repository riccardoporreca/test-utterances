/* Responsive gallery container width for certain classes */
$(document).ready(function () {
  $('.gallery-embed-script, .gallery-embed-html').addClass('main-container container-fluid');
});

$(document).ready(function () {
$(".utterances-frame").on("load", function() {
  let head = $(".utterances-frame").contents().find("head");
  let css = '<style>.timeline-header {display: none;}</style>';
  $(head).append(css);
});
});
