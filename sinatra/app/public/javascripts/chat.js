jsSocket.swf = '/javascripts/thirdparty/jssocket/flash/jsSocket.swf';

jQuery(window).ready(function($) {
    //    jsSocket.swf = '/javascripts/thirdparty/jssocket/flash/jsSocket.swf';
    //    jsSocket.swf = '/javascripts/thirdoparty/jssocket/flash/jsSocket.swf';

    /*    var socket = jsSocket();
    socket.connect('localhost', 1234);
    socket.send('hello world');*/
      
    var socket= jsSocket({port:1234});
    socket.onData= function(data) {
      if (data)
	$("#chat-window").append("<p>"+data+"</p>");
    };
    socket.onStatus = function(type, val) {
      $("#chat-window").append("<p>"+type+"</p>");

      switch(type){
      case 'connecting':   // connecting to the server
      break
      
      case 'connected':    // connected
      break
      
      case 'disconnected': // disconnected
      break
      
      case 'waiting':      // waiting to reconnect in val seconds
      break
      
      case 'failed':       // attempted max reconnects
      break
      }
    };
    
    $("button").click(function() {
	var input= $("#chat-input").val();
	socket.send(input);
	/*	$.post("/carolina/friends/pablo", {msg: input}, function() {
	    alert("mensaje enviado");
	    });*/
      });
  });
