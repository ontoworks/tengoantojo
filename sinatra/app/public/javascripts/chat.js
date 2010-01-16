jQuery(window).ready(function($) {
    $("#chat-window").dialog({width:230});
    $("#chat-friend-list").find(".item-friend").live("click", function() {
	var scope= this;
	var blur_friend_callback= function() { $(scope).removeClass("selected")};
	$("body").unbind("click", blur_friend_callback);
	$("body").click(blur_friend_callback);
	$("#chat-friend-list").find(".item-friend.selected").removeClass("selected");
	$(this).addClass("selected");
      });
    
    $("#chat-friend-list").find(".item-friend").live("dblclick", function() {
	var $chat_window= $("#chat-window").clone();
        $chat_window.attr("id", "chat-window-"+$(this).find("p").text());
	$("body").append($chat_window);
	$chat_window.dialog({width:230});
      });
  });
