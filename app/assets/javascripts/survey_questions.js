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

  $("body").on("change", ".survey_question_type", function(ev){
    if($(this).val() == "Choices"){
      $("#add_survey_question_choices").show();
    }
    else {
      $("#choices").html('');
      $("#add_survey_question_choices").hide();
    }
  });

  $('form').on('click', '.remove_fields', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('.fields').hide();
    return event.preventDefault();
  });

  window.remove_fields = function(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide();
  }

  window.add_fields = function(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $('#choices').append(content.replace(regexp, new_id));
  }
});