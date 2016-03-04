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
//= require turbolinks
//= require_tree .

//= require highcharts/highcharts
//= require highcharts/highcharts-more
//= require highcharts/highstock

$( document ).ready(function() { 
    var $audio = document.getElementById("audio");
    console.log( "js loaded" );
    setTimeout(function(){
       $('.message').css("visibility", "visible").addClass('magictime spaceInLeft');
    }, 37000);
    $('.earth').on("click", function() {
        $(this).addClass('magictime holeOut');
        $audio.pause();
       $('.earth').fadeOut(800);
        $('p').css("color: black");

        setTimeout(function(){
        $('body').css("background-image", "");
        $('body').css("background-color", "white");

          setTimeout(function() {
            $('.heading').show().addClass('magictime tinRightIn');
          }, 1000)

          setTimeout(function() {
            $('.sub_heading').show().addClass('magictime tinRightIn');
          }, 2000)

          setTimeout(function() {
            $('.sub_sub_heading').show().addClass('magictime tinRightIn');
            $('.PrimaryNav').css('visibility','visible').hide().fadeIn('slow').addClass('magictime tinRightIn');
          }, 3000)
          $('.message').css("visibility", "hidden"); 
        }, 1000);
  }); // ends earth click function
  
  $('.world_selector').on('click', function() {

    $('.heading').fadeOut();
    $('.sub_heading').fadeOut();
    $('.sub_sub_heading').fadeOut();
    $('#container').fadeOut();
    $('.state_select').fadeOut();
    $('#state_map').fadeOut();
    $('.continent_svg').fadeIn();
    $('#continent_map').fadeIn();
    //$('.continent_buttons').fadeIn();
    //$('#graph').fadeIn();

  });
  $('.usa_selector').on('click', function() {
  
    $('.heading').fadeOut();
    $('#container').fadeOut();
    $('.sub_heading').fadeOut();
    $('.sub_sub_heading').fadeOut();
    //$('#graph').fadeOut(); 
    $('.state_select').css('fill', '#008c9e')
    //$('.continent_buttons').fadeOut();
    $('.continent_svg').fadeOut();
    $('#continent_map').fadeOut();
    $('.state_select').fadeIn();
    $('#state_map').fadeIn();
   });
   $(document).on({
     ajaxStart: function() { $('body').addClass("loading");    },
     ajaxStop: function() { $('body').removeClass("loading"); }    
   });
  $state = $('.state') // state ajax data call on click
  $('.state_select').on("click", function() { stateNumber = $(this).attr('id')
	  console.log(stateNumber);
	  $('.state_select').css("fill"," #008c9e");
	  $(this).css("fill", "red");
	  var $values = [];
	   $.ajax({
		method: 'GET',
		url: "http://www.ncdc.noaa.gov/cag/time-series/us/" + stateNumber + "/00/tavg/ytd/12/1895-2016.json?base_prd=true&firstbaseyear=1901&lastbaseyear=2000",
		success: function(data) {
			data = JSON.parse(data)
			mo_data = data.data
			stateName = data.description.title.split(",")[0]

			Object.keys(data.data).sort().forEach(function(i){
			  for (var prop in mo_data) {
			      if (prop === i) {
				 $values.push(parseFloat(mo_data[prop]["anomaly"]))
				 console.log("year: " + i + " value: " + mo_data[prop]["anomaly"]);
			      }
			  }
			})

			firstYear = Object.keys(data.data).sort()[0]
			var $years = [];
			for (var i = firstYear.slice(0,4); i < 2016; i++){
			    $years.push(i);
			 }
			$(function () {
			    $('#container').show();
			    $('#container').highcharts({
				title: {
				    text: 'Temperature Anomolies from the 20th Century Average',
				    x: -20 //center
				},
				subtitle: {
				    text: 'Source: ncdc.noaa.com',
				    x: -20
				},
				xAxis: {
				    categories: $years,
				    labels: {step: 5}
				},
				yAxis: {
				    title: {
					text: 'Temperature (°C)'
				    },
				    plotLines: [{
					value: 0,
					width: 1,
					color: '#808080'
				    }]
				},
				tooltip: {
				    valueSuffix: '°C'
				},
				legend: {
				    layout: 'vertical',
				    align: 'right',
				    verticalAlign: 'middle',
				    borderWidth: 0
				},
				series: [{
				    name: stateName,
				    data: $values,
				    color: 'red',
				    negativeColor: '#008c9e'
				}]
			    }); // ends container highcharts function
			}); // ends graphing funciton
	         } // ends success function


	}); // ends ajax call
  }); // ends on onclick funciton for states
  $('.continent_svg').on('click', function() {
     
    var continent = $(this).attr('id') 
    $('.continent_svg').css("fill", "green");
    $(this).css("fill", "red");

     $years = [];
     $values = [];
      console.log(continent)
      $.ajax({
        method: 'GET',
        url: "http://www.ncdc.noaa.gov/cag/time-series/global/" + continent + "/land/ytd/12/1880-2016.xml?trend=true&trend_base=10&firsttrendyear=1910&lasttrendyear=2015",
        success: function(data) {
               var year;
               var value;
                $(data).find("data").each(function(){
                  $(this).find("year").each(function() {
                   year = $(this).text();
                   year = parseInt(year)
                  });
                  $(this).find("value").each(function() {
                    value = $(this).text();
                    value = parseFloat(value);
                  });
                  $years.push(year);
                  $values.push(value);
                });
               console.log($values)
               
		$(function () {
                    continent = continent.charAt(0).toUpperCase() + continent.slice(1);
                    if (continent.split('')[0] === "N" || continent.split('')[0] === "S"){
                       continent = continent.slice(0,5) + " " + continent.slice(5);
                    }
		    $('#container').show();
		    $('#container').highcharts({
			title: {
			    text: 'Temperature Anomolies from the 20th Century Average',
			    x: -20 //center
			},
			subtitle: {
			    text: 'Source: ncdc.noaa.com',
			    x: -20
			},
			xAxis: {
			    categories: $years,
			    labels: {step: 5}
			},
			yAxis: {
			    title: {
				text: 'Temperature (°C)'
			    },
			    plotLines: [{
				value: 0,
				width: 1,
				color: '#808080'
			    }]
			},
			tooltip: {
			    valueSuffix: '°C'
			},
			legend: {
			    layout: 'vertical',
			    align: 'right',
			    verticalAlign: 'middle',
			    borderWidth: 0
			},
			series: [{
			    name: continent,
			    data: $values,
			    color: 'red',
			    negativeColor: '#008c9e'
			}]
		    }); // ends container highcharts function
		}); // ends graphing funciton
         } // ends success call
       }); // ends ajax call
  }); // ends continent svg click function
}); // ends document.ready

