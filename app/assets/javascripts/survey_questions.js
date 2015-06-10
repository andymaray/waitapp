$(document).on('ready page:load', function(){
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
    $("#ModalDialog .modal-header h4").html("<div>" + title + "</div>");
    $("#ModalDialog .modal-body").load(target, function() {
      $(".spinner").hide(); // Hide the spinner
      $("#ModalDialog").modal("show");
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


  $("body").on("click", "#search_question", function(ev){
    $(".error").html("");
    if(!$("#presentation_filter").val()){
      $(".error").html("Please select Filter");
      return false;
    }
  });

  window.add_translate_fields = function(index) {
    html = "<div class='fields'>"+
      "<input name='translate_question_" + index + "_choices[]'"+
      "id='translate_question_" + index + "_choices_' value=''"+
      "class='form-control' type='text'></div>";
    $("#translate_choices").append(html);
  }

  window.add_fields = function(ev) {
    html = "<div class='fields'>"+
      "<input name='question_choices[]'' id='question_choices_' value=''"+
      "class='form-control' type='text'></div>";
    $("#choices").append(html);
  }
});