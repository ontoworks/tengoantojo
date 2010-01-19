jQuery(window).ready(function($) {
    $("#chat-window").hide();
    $("#chat-friend-list").hide();

    /** 
     * @widget: Chat Window
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
	},
      /** 
       * @returns:
       * @author:
       * @version:
       * @requires:
       */
      render_msg: function(from, msg) {
	  //$.achtung({message: from+": "+msg, timeout:2});
	  $.jGrowl(msg,{header:from});
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
	
    /** 
     * @widget: Buddy List
     * @returns:
     * @author:
     * @version:
     * @requires:
     */
    $.widget("ui.buddy_list", {
      _init: function() {
	  this.connection= this.options.connection;

	  var self= this;

	  this.chat_windows_open={}; // track open chat sessions/windows
	  this.jid= this.options.user_jid;
	  this.bare_jid= this.jid.split("/")[0];

	  function onRoster(elem) {
	    var query_el= elem.firstChild;
	    var next_item= query_el.firstChild;
	    while (next_item!=null) {
	      if (next_item.tagName=="item") {
		var jid= next_item.getAttribute("jid");
		var buddy= Strophe.getNodeFromJid(jid);
		if ($("#buddy-"+buddy).length==0) {
		  self.render_buddy(jid, "unavailable");
		}
	      }
	      next_item= next_item.nextSibling;
	    }
	    return true;
	  }

	  function onPresence(elem) {
	    var next_elem= elem;
	    while (next_elem!=null) {
	      if (next_elem.tagName=="presence") {
		var from= next_elem.getAttribute('from');
		var jid= from.split("/")[0];
		var buddy= jid.split("@")[0];      
		if (next_elem.getAttribute("type")=="unavailable") {
		  self.render_buddy(jid, "unavailable");
		} else {
		  self.render_buddy(jid, "available");
		}
	      }
	      next_elem= next_elem.nextSibling;
	    }
	    return true;
	  }
	  
	  function onChat(elem) {
	    var to = elem.getAttribute('to');
	    var from = elem.getAttribute('from');
	    var msgs = elem.getElementsByTagName('body');
	    var buddy_jid= from.split("/")[0];
	    var buddy= buddy_jid.split("@")[0];
	    if (!self.chat_windows_open[buddy]) { // if there's not open window for buddy
	      self.open_chat_window(buddy_jid);
	    }
	    var $chat_window= $("#chat-with-"+buddy);
	    for(var i=0;i<msgs.length;i++) {
	      var msg= msgs[i].childNodes[0].nodeValue;
	      if(msg)
		$chat_window.chat_window("render_msg",buddy_jid,msg);
	    }
	    return true;
	  };
	  this.connection.addHandler(onChat, null, 'message', 'chat', null, null );
	  this.connection.addHandler(onPresence, null, 'presence', null, null, null);
	  this.connection.addHandler(onRoster, Strophe.NS.ROSTER, 'iq', null, null, null);
	  
	  // click on buddy
	  this.element.find(".item-friend").live("click", function() {
	      var scope= this;
	      var blur_friend_callback= function() { $(scope).removeClass("selected")};
	      $("body").unbind("click", blur_friend_callback);
	      $("body").click(blur_friend_callback);
	      $("#chat-friend-list").find(".item-friend.selected").removeClass("selected");
	      $(this).addClass("selected");
	    });
	
	  // dblclick on buddy
	  this.element.find(".item-friend").live("dblclick", function(e) {
	      var buddy= $(this).text();
	      self.open_chat_window(buddy+"@poor-kid");
	    });
	},
	open_chat_window: function(buddy_jid) {
	  var buddy= buddy_jid.split("@")[0]
	  // if it's not already open
	  if (!this.chat_windows_open[buddy]) {
	    this.chat_windows_open[buddy]=buddy;
	    var $chat_window= $("#chat-window").clone();
	    $chat_window.attr("id", "chat-with-"+buddy);
	    $("body").append($chat_window);
	    $chat_window.chat_window({width:230,
		  title:buddy,
		  buddy:buddy_jid,
		  myself:this.jid,
		  connection:this.connection});
	    $chat_window.bind('dialogclose', function() {self.chat_windows_open[buddy]=null});
	  }
	},
	render_buddy: function(jid, status) {
	  var buddy= jid.split("@")[0];
	  $("#buddy-"+buddy).remove();
	  //	  alert(this.bare_jid);
	  if (this.bare_jid!=jid) {
	    if (status=="available") {
	      this.element.find(".chat-online-friends").append("<p id=\"buddy-"+buddy+"\" class=\"item-friend available\"><img src=\"/images/icono-on-line.png\"/>"+buddy+"</p>");
	    } else if(status=="unavailable") {
	      this.element.find(".chat-offline-friends").append("<p id=\"buddy-"+buddy+"\" class=\"item-friend unavailable\"><img src=\"/images/icono-offline.png\"/>"+buddy+"</p>");
	    }
	  }
	}
      });  
    $.extend($.ui.buddy_list, {
      defaults: {
	user_jid: null,
	    connection: null
	    }
      });
    
    $("#login").bind("bind", function(e,jid) {
	$("#chat-friend-list").show().buddy_list({user_jid:jid, connection:connection});
      });
  });
