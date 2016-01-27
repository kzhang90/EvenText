$(document).ready(function() {
  return $("#new_bookmark").on("ajax:success", function(e, data) {
    return $("h2.text-center").after("<div>"+"IS THIS WORKING"+"</div>");
  }).on("ajax:error", function(e, xhr, status, error) {
    return $("#new_bookmark").append("<h1 style='color:red;'>ERROR!</h1>");
  });
});

function verifyThat() {
          if($("#keyword-box").val()!="" && $("#city-box").val()!="" && $("#start-box").val() && $("#end-box").val()) {
            return true;
          } else {
            return false;
          }
};