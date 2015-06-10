$(document).on('ready page:load', function(){

  $(".body_diagram label").click(function() {
      $('.body_diagram label').removeClass("highlight");
      $(this).addClass("highlight");
  });
  $('.datepicker').datepicker();

  $("body").on("click", "#search_patients", function(ev){
    $(".error").html("");
    if(!$("#end_date").val()){
      $(".error").html("Please insert dates");
      return false;
    }
    else if (!$("#start_date").val()){
      $(".error").html("Please insert dates");
      return false;
    }
  });
});

window.show_modal = function(body, heading){
  $("#ModalDialog .modal-header h4").html("<div>" + heading + "</div>");
  $("#ModalDialog .modal-body").html(body);
  $("#ModalDialog").modal("show");
}
