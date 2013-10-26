// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$("document").ready(function() {
			$("#posts-div").show();

			$("#members-div").hide();

			$("#group-posts-button").click(function(){
				
				$("#posts-div").show();
				$("#members-div").hide();

				$("#group-posts-button").addClass("active");
				$("#group-members-button").removeClass("active");

				$("#group-tab-nav").addClass("col-sm-7");
				$("#group-tab-nav").removeClass("col-sm-12");				
			});	

			$("#group-members-button").click(function(){
				
				$("#posts-div").hide();
				$("#members-div").show();

				$("#group-posts-button").removeClass("active");
				$("#group-members-button").addClass("active");

				$("#group-tab-nav").addClass("col-sm-12");
				$("#group-tab-nav").removeClass("col-sm-7");				
			});	

		});