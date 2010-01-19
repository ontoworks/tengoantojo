var BOSH_SERVICE = '/bosh';
var connection = null;
var me= "";


function removeNL(s){ 
  return s.replace(/[\n\r\t]/g," "); 
}

function xmlInput(elem) {
  $(elem).find("bind").find("jid").each(function() {
      me= $(this).text();
      $("#login").trigger(jQuery.Event("bind"), me);
    });
}

function onConnect(status) {
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
    
    // change status to 'Online' in UI
    $("#chat-status-icon").attr("src","/images/icono-on-line.png");
    $("#chat-status-label").text("Conectado");
  }
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
