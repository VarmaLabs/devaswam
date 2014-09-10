function validateAdminForm() {

    $('#form_admin').validate({
      debug: true,
      rules: {
        "admin[name]": {
            required: true,
            minlength: 2,
            maxlength: 50
        },
        "admin[username]": {
            required: true,
            minlength: 2,
            maxlength: 50
        },
        "admin[status]": {
            required: true,
            minlength: 2,
            maxlength: 50
        },
        "admin[email]": {
            required: true,
            email: true
        },
        "admin[trust_id]": "required",
      },
      errorElement: "span",
      errorClass: "help-block",
      messages: {
        "admin[name]": "Please enter the Name of the admin",
        "admin[username]": "Please specify a Username",
        "admin[email]": {
            required: "We need your email address to contact you",
            email: "Your email address must be in the format of name@domain.com"
        },
        "admin[address]": "Address is mandatory",
        "admin[trust_id]": "Please select a Trust to which this admin belongs to.",
        "admin[password]": "Password is mandatory. should have atleast 1 Character (a to z (both upper and lower case)), 1 Number (1 to 9) and 1 Special Character from (!,@,$,&,*,_)",
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
          $("#div_admin_js_validation_error").remove();

          errorHtml = "<div id='div_admin_js_validation_error' class=\"alert alert-danger\" data-alert=\"alert\" style=\"margin-bottom:5px;\">"+ errorMessage +"</div>"
          //$("#div_admin_details").prepend(errorHtml);
          $("#div_modal_generic div.modal-body-main").prepend(errorHtml);

          // Show error labels
          $("div.error").show();

        } else {
          // Hide error labels
          $("div.error").hide();
          // Removing the error message
          $("#div_admin_js_validation_error").remove();
        }
      }

    });

}
