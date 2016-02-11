$(document).ready(
  function() {
    return $("#new-bookmark").on("ajax:success", function(e, data) {
      return $("h2.text-center").after("<div>"+data+"</div>");
    }).on("ajax:error", function(e, xhr, status, error) {
      return $("#new_bookmark").append("<h1 style='color:red;'>ERROR!</h1>");
    });
  }


);