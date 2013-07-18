function validateTodoForm() {
  
    $('#form_todo').validate({
      debug: true,
      rules: {
        "todo[title]": {
            required: true,
            minlength: 2,
            maxlength: 120
        },
        "todo[details]": {
            required: true,
            minlength: 2,
            maxlength: 160
        }
      },
      messages: {
        "todo[title]": "Please specify Title",
        "todo[details]": "Please specify Details",
      },
      highlight: function(element) {
          $(element).parent().addClass("danger");
      },
      unhighlight: function(element) {
          $(element).parent().removeClass("danger");
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
          $("#div_todo_js_validation_error").remove();
          
          errorHtml = "<div id='div_todo_js_validation_error' class=\"alert danger\" data-alert=\"alert\" style=\"margin-bottom:5px;\">"+ errorMessage +"</div>"
          $("#div_todo_details").prepend(errorHtml);  
          
          // Show error labels
          $("div.error").show();
          
        } else {
          // Hide error labels
          $("div.error").hide();
          // Removing the error message
          $("#div_todo_js_validation_error").remove();
        }
      },
      submitHandler: function(form) {
        // Submit the form via HTTP request
        // form.submit();
        
        // Submit the form via XMLHTTP request (Ajax)
        $(form).ajaxSubmit({
          url: $("#form_todo input[name=faction]").val(),
          type: $("#form_todo input[name=fmethod]").val(),
          dataType: 'script'
        });
      }
      
    });
    
}
