var BOSH_SERVICE = '/bosh';
var connection = null;
var me= "";


function removeNL(s){ 
  return s.replace(/[\n\r\t]/g," "); 
}

function xmlInput(elem) {
  $(elem).find("bind").find("jid").each(function() {
      me= $(this).text();
    });
}

function onConnect(status)
{
  if (status == Strophe.Status.CONNECTING) {
    // CONNECTING
  } else if (status == Strophe.Status.CONNFAIL) {
    $('#connect').get(0).value = 'connect';
  } else if (status == Strophe.Status.DISCONNECTING) {
    // DISCONNECTING
  } else if (status == Strophe.Status.DISCONNECTED) {
    // change status to 'Offline' in UI
    $("#chat-status-icon").attr("src","/images/icono-offline.png");
    $("#chat-status-label").text("Desconectado");
    $('#connect').get(0).value = 'connect';
  } else if (status == Strophe.Status.CONNECTED) {
    // send presence
    connection.send($pres({xmlns:Strophe.NS.CLIENT}).tree());

    // request for roster
    var iq_roster= $iq({type:"get"});
    var query_roster=  $build("query", {xmlns:Strophe.NS.ROSTER});
    iq_roster.cnode(query_roster.tree());
    connection.send(iq_roster);

    // add handlers
    connection.addHandler(onMessage, null, 'message', null, null,  null); 
    connection.addHandler(onPresence, null, 'presence', null, null,  null);
    connection.addHandler(onRoster, Strophe.NS.ROSTER, 'iq', null, null,  null);
    
    // change status to 'Online' in UI
    $("#chat-status-icon").attr("src","/images/icono-on-line.png");
    $("#chat-status-label").text("Conectado");
  }
}

function onRoster(elem) {
  var query_el= elem.firstChild;
  var next_item= query_el.firstChild;
  while (next_item!=null) {
    next_item= next_item.nextSibling;
  }
  return true;
}

function onPresence(elem) {
  var next_elem= elem;
  while (next_elem!=null) {
    if (next_elem.tagName=="presence") {
      var from= next_elem.getAttribute('from');
      var buddy= from.split("@")[0];
      
      if (next_elem.getAttribute("type")=="unavailable") {
	$("#buddy-"+buddy).remove();
      } else {
	if (me!=from && $("#buddy-"+buddy).length == 0) {
	  $("#chat-friend-list .chat-online-friends").append("<p id=\"buddy-"+buddy+"\" class=\"item-friend\"><img src=\"/images/icono-on-line.png\"/>"+buddy+"</p>");
	}
      }
    }
    next_elem= next_elem.nextSibling;
  }
  return true;
}

function onMessage(msg) {
  var to = msg.getAttribute('to');
  var from = msg.getAttribute('from');
  var type = msg.getAttribute('type');
  var elems = msg.getElementsByTagName('body');
    
  return true;
}

$(document).ready(function () {
    connection= new Strophe.Connection(BOSH_SERVICE);
    connection.xmlInput= xmlInput;
    
    $('#connect').bind('click', function () {
	var button = $('#connect').get(0);
	if (button.value == 'connect') {
	  button.value = 'disconnect';
	  
	  connection.connect($('#jid').get(0).value,
			     $('#pass').get(0).value,
			     onConnect);
	} else {
	  button.value = 'connect';
	  connection.disconnect();
	}
      });
  });
