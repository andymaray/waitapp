$(function () {
  $("body").on("click", "a[data-target=#ModalDialog]", function(ev) {
    var instructions, opts, spinner, target, title;
    opts = {
      lines: 10,
      length: 13,
      width: 9,
      radius: 20,
      color: "#000",
      speed: 1,
      trail: 60,
      shadow: true
    };
    target = document.getElementsByTagName('body')[0];
    spinner = new Spinner(opts);
    spinner.spin(target);
    ev.preventDefault();
    target = $(this).attr("data-remote");
    title = $(this).attr("modal-title");
    // instructions = $(this).attr("modal-instructions");
    $("#ModalDialog .modal-header h4").html("<div>" + title + "</div>");
    $("#ModalDialog .modal-body").load(target, function() {
      $(".spinner").hide(); // Hide the spinner
      $("#ModalDialog").modal("show");
      return
    });
  });  
});