$(document).on('ready page:load', function(){

    $(".body_diagram label").click(function() {
        $('.body_diagram label').removeClass("highlight");
        $(this).addClass("highlight");
    });
    $('.datepicker').datepicker();
});
