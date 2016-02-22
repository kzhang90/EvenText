// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require angular/angular
//= require bootstrap-datepicker
//= require_tree .
function verifyThat() {
          if($("#keyword-box").val()!="" && 
            $("#city-box").val()!="" && 
            $("#start-box").val() && 
            $("#end-box").val()) {
            return true;
          } else {
            return false;
          }
}
function renderSearchResultPartial(value) {
// if any value.title match @bookmarks 
  $("<div class='searchRes'><div class='jsondata' data-json="+encodeURIComponent(JSON.stringify(value))+"></div><div class='searchTitle'>"+
    value.title+"</div><img class='searchImage' alt='image unavailable' src=\""+
    value.image+"\"></img><div class='searchDes'>"+
    value.description+"</div><div class='searchTime'>"+
    value.time+
    "</div><button type='submit' class='searchResBtn btn btn-default'>Save Bookmark</button></div>").appendTo("#api-results");
}
$(document).ready(function() {
    $("#searchButton").click(function(event) {
        event.preventDefault();
        if (verifyThat()) {
            $.ajax({
                url: "/search_apis",
                dataType: "json",
                data: {
                    keyword: $("#keyword-box").val(),
                    city: $("#city-box").val(),
                    start_date: $("#start-box").val(),
                    end_date: $("#end-box").val()
                },
                success: function(data) {
                    $.each(data, function(index,
                        value) {
                        renderSearchResultPartial
                            (value);
                    });
                }
            });
        }
    });
    // if var id 
    $('body').on('click', '.searchRes', function() {
        var id = $('#eventbrite-search').data('user_id');
        var fullurl = "/users/"+ id +"/bookmarks";
        var data = JSON.parse(decodeURIComponent($(this).children("div").attr("data-json")));
        $.ajax({
            url: fullurl,
            dataType: "json",
            type: "POST",
            data: {
                bookmark: data
            }
        });
        $(this).children("button").text("Bookmark Saved");
    });
});