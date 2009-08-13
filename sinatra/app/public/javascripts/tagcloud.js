$(document).ready(function(){	
    // create a style switch button
    var switcher = $('<a href="javascript:void(0)" class="btn">Change appearance</a>').toggle(function(){
	$("#tags ul").hide().addClass("alt").fadeIn("fast");
      },
      function(){
	$("#tags ul").hide().removeClass("alt").fadeIn("fast");
      });

    $('#tags').append(switcher);
    
    // create a sort by alphabet button
    var sortabc = $('<a href="javascript:void(0)" class="btn">Sort alphabetically</a>').toggle(function(){
	$("#tags ul li").tsort({order:"asc"});
      },	
      function(){
	$("#tags ul li").tsort({order:"desc"});
      });
    $('#tags').append(sortabc);		
	
	// create a sort by alphabet button	
    var sortstrength = $('<a href="javascript:void(0)" class="btn">Sort by strength</a>').toggle(function(){
	$("#tags ul li").tsort({order:"desc",attr:"class"});
      },	
      function(){
	$("#tags ul li").tsort({order:"asc",attr:"class"});
      }		
      );
    $('#tags').append(sortstrength);			
    
  });
