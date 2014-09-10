function validateDeityForm() {
  
    $('#form_deity').validate({
      debug: true,
      rules: {
        "deity[name]": {
            required: true,
            minlength: 2,
            maxlength: 50
        },
        "deity[description]": "required",
        "deity[temple_id]": "required",
        "deity[trust_id]": "required",
      },
      errorElement: "span",
      errorClass: "help-block",
      messages: {
        "deity[name]": "Please specify Name",
        "deity[description]": "Please specify Description",
        "deity[temple_id]": "Please specify Temple",
        "deity[trust_id]": "Please specify Trust",
      },
      highlight: function(element) {
          $(element).parent().parent().addClass("has-error");
      },
      unhighlight: function(element) {
          $(element).parent().parent().removeClass("has-error");
      },
      invalidHandler: function(event, validator) {
        // 'this' refers to the form
        var errors = validator.numberOfInvalids();
        if (errors) {
          
          // Populating error message
          var errorMessage = errors == 1
            ? 'You missed 1 field. It has been highlighted'
            : 'You missed ' + errors + ' fields. They have been highlighted';
          
          // Removing the form error if it already exists
          $("#div_deity_js_validation_error").remove();
          
          errorHtml = "<div id='div_deity_js_validation_error' class=\"alert alert-danger\" data-alert=\"alert\" style=\"margin-bottom:5px;\">"+ errorMessage +"</div>"
          //$("#div_deity_details").prepend(errorHtml);  
          $("#div_modal_generic div.modal-body-main").prepend(errorHtml);  
          
          // Show error labels
          $("div.error").show();
          
        } else {
          // Hide error labels
          $("div.error").hide();
          // Removing the error message
          $("#div_deity_js_validation_error").remove();
        }
      }
      
    });
    
}