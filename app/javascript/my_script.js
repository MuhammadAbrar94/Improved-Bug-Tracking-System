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