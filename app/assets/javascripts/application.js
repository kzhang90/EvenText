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
          if($("#keyword-box").val()!=="" && 
            $("#city-box").val()!=="" && 
            $("#start-box").val() && 
            $("#end-box").val()) {
            return true;
          } else {
            return false;
          }
}

function renderSearchResultPartial(value) {
// if any value.title match @bookmarks 
// this is how we are displaying the data
    console.log("render search result partial");
  $("<div class='searchRes'><div class='jsondata' data-json="+encodeURIComponent(JSON.stringify(value))+"></div><img class='searchImage' alt='image unavailable' src=\""+
    value.image+"\"></img><div class='searchDetails'><div class='searchTitle'>"+value.title+"</div><div class='searchTime'>"+value.time.to_time.strftime('%A, %B %d at %I %p')+"<div class='searchDes'>"+
    value.description+"</div><div class='searchUrl'><a href='"+value.url+"'>Event Page</a></div><button type='submit' class='searchResBtn btn btn-default'>Save Bookmark</button></div></div>").appendTo("#api-results");
}
$(document).ready(function() {
    $("#search-button").click(function(event) {
        event.preventDefault();
        console.log("search button clicked");

        if (verifyThat()) {
            console.log("verifyThat true");
            $.ajax({
                url: "/search_apis",
                dataType: "json",
                data: {
                    keyword: $("#keyword-box").val(),
                    city: $("#city-box").val(),
                    start_date: $("#start-box").val(),
                    end_date: $("#end-box").val()
                },
                // data is in JSON
                success: function(data) {
                    $.each(data, function(index,
                        value) {
                        renderSearchResultPartial(value);
                    });
                },
                error: function(msg) {
                    console.log(msg);
                }
            });
        }
        else {
            console.log("verifyThat is FALSE");
            $("#eventbrite-search").trigger('reset');
        }
    });
    $('body').on('click', '.searchResBtn', function() {
        console.log("clicked!")
        var id = $('#eventbrite-search').data('user_id');
        var fullurl = "/users/"+ id +"/bookmarks";
        var data = JSON.parse(decodeURIComponent($(this).parent().parent().children().attr("data-json")));
        $.ajax({
            url: fullurl,
            dataType: "json",
            type: "POST",
            data: {
                bookmark: data
            }
        });
        $(this).text("Bookmark Saved").css("background-color", "#00cc00");
    });
});