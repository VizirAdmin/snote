// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
   // Enable in-place-edit when document is loaded
$(document).ready(function(){

  $(".in-place-edit").children().inPlaceEdit({
    submit : submit_handler,
    cancel : cancel_handler
  });            
});

