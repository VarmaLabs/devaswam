function validateTrustForm() {

    $('#form_trust').validate({
      debug: true,
      rules: {
        "trust[name]": {
            required: true,
            minlength: 2,
            maxlength: 50
        },
        "trust[address]": {
            required: true,
            minlength: 2,
            maxlength: 200
        },
      },
      errorElement: "span",
      errorClass: "help-block",
      messages: {
        "trust[name]": "Please enter the name of the trust (ട്രസ്റ്റിന്റെ പേര് പൂരിപ്പിക്കുക)",
        "trust[address]": "Please enter the address (ട്രസ്റ്റിന്റെ മേൽവിലാസം പൂരിപ്പിക്കുക)",
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
            ? 'You missed 1 field. It has been highlighted. (ചുവപ്പ് നിറത്തിൽ രേഖപ്പെടുത്തിയവ ഒന്ന് കൂടി പരിശോധിക്കുവാൻ അഭ്യർത്ഥിക്കുന്നു)'
            : 'You missed ' + errors + ' fields. Please review the highlighted fields. (ചുവപ്പ് നിറത്തിൽ രേഖപ്പെടുത്തിയവ ഒന്ന് കൂടി പരിശോധിക്കുവാൻ അഭ്യർത്ഥിക്കുന്നു)';

          // Removing the form error if it already exists
          $("#div_trust_js_validation_error").remove();

          errorHtml = "<div id='div_trust_js_validation_error' class=\"alert alert-danger\" data-alert=\"alert\" style=\"margin-bottom:5px;\">"+ errorMessage +"</div>"
          //$("#div_trust_details").prepend(errorHtml);
          $("#div_modal_generic div.modal-body-main").prepend(errorHtml);

          // Show error labels
          $("div.error").show();

        } else {
          // Hide error labels
          $("div.error").hide();
          // Removing the error message
          $("#div_trust_js_validation_error").remove();
        }
      }

    });

}
