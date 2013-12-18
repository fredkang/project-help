
//Script that enables infinite scroll
jQuery(function() {
	//Hide the actual pagination links
	$(".pagination").hide();
	
	//Link for getScript breaks without this
	$.ajaxSetup({
    	cache: true
	});
	
	return $(window).scroll(function() {
    	if ($(window).scrollTop() > $(document).height() - $(window).height() - 100 
    		&& $('.pagination .next_page').attr('href')!=null) {
      		return $.getScript($('.pagination .next_page').attr('href'));
    	}
  	});
});


// $("document").ready(function() {
// 			alert("hi");
// 			$("#post-div").show();

// 			$("#members-div").hide();

// 			$("#group-posts-button").click(function(){
// 				$("#post-div").show();
// 				$("#members-div").hide();

// 				$("#group-posts-button").attr("class", "active")
// 				$("#group-members-button").attr("class", " ")				
// 			});	

// 			$("#members-posts-button").click(function(){
// 				$("#post-div").hide();
// 				$("#members-div").show();

// 				$("#group-posts-button").attr("class", " ")
// 				$("#group-members-button").attr("class", "active")				
// 			});	

// 		});