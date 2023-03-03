document.addEventListener("DOMContentLoaded", function() {
  var hoverables = document.querySelectorAll(".hoverable");

  hoverables.forEach(function(hoverable) {
    var hiddenItems = hoverable.querySelector(".hidden-items");

    hoverable.addEventListener("mouseover", function() {
      hiddenItems.style.display = "block";
    });

    hoverable.addEventListener("mouseout", function() {
      hiddenItems.style.display = "none";
    });
  });
});
// $(document).on('ajax:success', 'form', function(event) {
//   console.log("new")
//   var hoverables = document.querySelectorAll(".succes");
//   hoverables.forEach(function(node) {
//     node.style.display = "block";
//   });
// });

$(document).ready(function() {
  $('#new-project-form').on('submit', function(event) {
    event.preventDefault();
    var form = $(this);
    var url = form.attr('action');
    var method = form.attr('method');
    var data = form.serialize();

    $.ajax({
      url: url,
      type: method,
      data: data,
      dataType: 'json',
      success: function(response) {
        // Display success message
        $('#success-message').text(response.message);
      },
      error: function(response) {
        // Display error message
        $('#error-message').text(response.message);
      }
    });
  });
});
