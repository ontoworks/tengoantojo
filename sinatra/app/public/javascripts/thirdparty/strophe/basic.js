var BOSH_SERVICE = '/bosh/chat'
var connection = null;
//var sent_msg_id= 0;
var recvd_msg_id= 0;
var friend= "";
var me= "";


function removeNL(s){ 
  return s.replace(/[\n\r\t]/g," "); 
}

function log(msg) 
{
    $('#log').append('<div>-</div>').append(document.createTextNode(msg));
    //$('#log').append('<br/>');
}

function rawInput(data)
{
    //log('RECV: ' + data);
  data= '<?xml version="1.0" encoding="utf-8" ?>'+data;
  //log('RECV: '+data+"<<");

  $(data).find("message").each(function() {
    
    var msg= $(this).text();
    //log('RECV: ' + msg);
  });
    //log('RECV: ' +Strophe.serialize(data));
}

function xmlInput(elem)
{
  $(elem).find("bind").find("jid").each(function() {
    me= $(this).text();
  });

  $(elem).find("message").each(function() {
    var msg= $(this).text();
    var _from= $(this).attr("from");
    var from= _from.split("/");
    var user= from[0];
    friend= _from;
    var resource= from[1];

    if(msg!="") {
      $("#chat-messages").append("<div class='message' id='msg-"+(++recvd_msg_id)+"'><p>"+user+" says...</p><p>"+msg+"</p></div>");
    }
  });
}

function rawOutput(data)
{
    //log('SENT: ' + data);
}

function onConnect(status)
{
    if (status == Strophe.Status.CONNECTING) {
	//log('Strophe is connecting.');
    } else if (status == Strophe.Status.CONNFAIL) {
	//log('Strophe failed to connect.');
	$('#connect').get(0).value = 'connect';
    } else if (status == Strophe.Status.DISCONNECTING) {
	//log('Strophe is disconnecting.');
    } else if (status == Strophe.Status.DISCONNECTED) {
	//log('Strophe is disconnected.');
	$("#chat-status-icon").attr("src","/images/icono-offline.png")
	$("#chat-status-label").text("Desconectado");
	$('#connect').get(0).value = 'connect';
    } else if (status == Strophe.Status.CONNECTED) {
	//log('Strophe is connected.');
	connection.send($pres().tree());
	connection.addHandler(onMessage, null, 'message', null, null,  null); 
	$("#chat-status-icon").attr("src","/images/icono-on-line.png")
	$("#chat-status-label").text("Conectado");
	//connection.disconnect();
    }
}

function onMessage(msg) {
    var to = msg.getAttribute('to');
    var from = msg.getAttribute('from');
    var type = msg.getAttribute('type');
    var elems = msg.getElementsByTagName('body');

    if (type == "chat" && elems.length > 0) {
	var body = elems[0];

	log('ECHOBOT: I got a message from ' + from + ': ' + 
	    Strophe.getText(body));
    
	var reply = $msg({to: from, from: to, type: 'chat'})
            .cnode(Strophe.copyElement(body));
	connection.send(reply.tree());

	log('ECHOBOT: I sent ' + from + ': ' + Strophe.getText(body));
    }

    // we must return true to keep the handler alive.  
    // returning false would remove it after it finishes.
    return true;
}

function send_msg() {
        var msg = $("#chat-input").val();
	var message= $msg({to:friend, 
			      from:me, 
			      type:"chat", 
			      "xml:lang":"es"})

	var body= $build("body");
	body.t(removeNL(msg));

	var reply = $msg({to: friend, from: me, type: 'chat'})
            .cnode(body.tree());


//	var data= message.cnode(body.tree());
	connection.send(reply.tree());
	connection.flush();
      //}
    }

$(document).ready(function () {
    connection = new Strophe.Connection(BOSH_SERVICE);
    connection.rawInput = rawInput;
    connection.rawOutput = rawOutput;
    connection.xmlInput= xmlInput;

    //$('#chat-input').keyup(function(e) {
    //  if(e.keyCode == 13) {
  $("#chat-window button").click(send_msg);

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