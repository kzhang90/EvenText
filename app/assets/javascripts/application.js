

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

$(document).ready(function() {

    function renderSearchResultPartial(value) {

        var date = new Date(Date.parse(value.time)).toLocaleString();
      $("<div class='searchRes'><div class='jsondata' data-json="+encodeURIComponent(JSON.stringify(value))+"></div><img class='searchImage' alt='image unavailable' src=\""+
        value.image+"\"></img><div class='searchDetails'><div class='searchTitle'>"+value.title+"</div><div class='searchTime'>"+
        date+"</div><div class='searchDes'>"+value.description+"</div><div class='searchUrl'><a href='"+value.url+
        "'>Event Page</a></div><button type='submit' class='searchResBtn btn btn-default'>Save Bookmark</button></div></div>")
      .appendTo("#api-results");
    }

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
// form still default submits

// first click binds the event handler. second click triggers event.

// my problem: this function does not get bound unless i click it whereas i think it's supposed to be bound
// on page load.

// maybe since this function runs after eventbrite search is 
    $("#eventbrite-search").submit(function(event) {
        alert("will this be attached?");
    })
    $("#eventbrite-search").submit(function(event) {
        // first click adds the event listener.
        // second click alerts fired.
        alert("fired!");
        event.preventDefault();
        console.log(event);
        event.stopImmediatePropagation();
        var formData = {
            'keyword': $("#keyword-box").val(),
            'city': $("#city-box").val(),
            'start_date': $("#start-box").val(),
            'end_date': $("#end-box").val()
        };
        if (verifyThat()) {
            $.ajax({
                url: "/search_apis",
                dataType: "json",
                data: formData
            }).done(function(data) {
                $.each(data, function(index, value) {
                    renderSearchResultPartial(value);
                });
            }).fail(function(jqXHR, textStatus, errorThrown) {
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
                });
        } else {
            $("#eventbrite-search").trigger('reset');
            console.log("in else block")
        }
        // this.submit();
        return false;
    });





    $('body').on('click', '.searchResBtn', function() {

        var id = $('#eventbrite-search').data('user_id');
        var fullurl = "/users/"+ id +"/bookmarks";

        // console.log(this);

        var data = JSON.parse(decodeURIComponent($(this).parent().parent().parent().find(".jsondata").data("json")));
        
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
// ,10)