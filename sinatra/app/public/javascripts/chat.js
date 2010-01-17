jQuery(window).ready(function($) {
    $("#chat-window").hide();

    /** 
     * @returns:
     * @author:
     * @version:
     * @requires:
     */
    $.widget("ui.chat_window", {
      _init: function() {
	  this.recvd_msg_id=0;

	  this.element.dialog({width:this.options.width, title:this.options.title});

	  var self= this;
	  // send message when click in "Enviar" button ...
	  this.element.find("button").click(function(e) {self.send()});
	  // ... and enter is pressed
	  this.element.find("#chat-input").keyup(function(e) {
	      if(e.keyCode == 13) {
		self.send();
	      }
	    });

	  var onChat= function(elem) {
	    var to = elem.getAttribute('to');
	    var from = elem.getAttribute('from');
	    var msgs = elem.getElementsByTagName('body');
	    for(var i=0;i<msgs.length;i++) {
	      self.render_msg(from.split("/")[0],msgs[i].childNodes[0].nodeValue);
	    }
	    return true;
	  };
	  this.options.connection.addHandler(onChat, null, 'message', 'chat', null, null );
	},
	  /** 
	   * @returns:
	   * @author:
	   * @version:
	   * @requires:
	   */
       render_msg: function(from, msg) {
	  $.achtung({message: from+": "+msg, timeout:2});
	  var message_window= this.element.find("#chat-messages");
	  message_window.append("<div class='message' id='msg-"+(++this.recvd_msg_id)+"'><p>"+from+" says...</p><p>"+msg+"</p></div>");
	  message_window.get(0).scrollTop=message_window.get(0).scrollHeight;
	},
	  /** 
	   * @returns:
	   * @author:
	   * @version:
	   * @requires:
	   */
      send: function() {
	  var msg = this.element.find("#chat-input").val();
	  this.element.find("#chat-input").val("");//.get(0).focus();
	  this.element.find("#chat-input").get(0).focus();
	  this.render_msg(this.options.myself.split("/")[0],msg);
	  var body= $build("body");
	  body.t(removeNL(msg));
	  
	  var message = $msg({to: this.options.buddy, from: this.options.myself, type: 'chat'})
	    .cnode(body.tree());
	  
	  // connection is still a global
	  this.options.connection.send(message.tree());
	}
      });     

    $.extend($.ui.chat_window, {
      defaults: {
	connection: null,
	    buddy: null,
	    myself: null
	    }
      });
	
    // Buddy List
    // click on buddy
    $("#chat-friend-list").find(".item-friend").live("click", function() {
	var scope= this;
	var blur_friend_callback= function() { $(scope).removeClass("selected")};
	$("body").unbind("click", blur_friend_callback);
	$("body").click(blur_friend_callback);
	$("#chat-friend-list").find(".item-friend.selected").removeClass("selected");
	$(this).addClass("selected");
      });
    
    // dblclick on buddy
    var chat_windows_open={}; // track open chat sessions/windows
    $("#chat-friend-list").find(".item-friend").live("dblclick", function(e) {
	var buddy= $(this).text();
	// if it's not already open
	if (!chat_windows_open[buddy]) {
	  chat_windows_open[buddy]=buddy;
	  var $chat_window= $("#chat-window").clone();
	  $chat_window.attr("id", "chat-with-"+$(this).text());
	  $("body").append($chat_window);
	  $chat_window.chat_window({width:230,
		title:buddy,
		buddy:buddy+"@poor-kid",
		myself:me,
		connection:connection}); // 'me' and 'connection' are globals
	  $chat_window.bind('dialogclose', function() {chat_windows_open[buddy]=null});
	}
      });
  });
