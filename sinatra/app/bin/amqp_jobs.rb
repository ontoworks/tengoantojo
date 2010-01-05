#!/usr/bin/env ruby

require 'rubygems'
#require 'mq'
require 'restclient'
require 'json'
require 'haml'
require 'minion'

require 'xmpp4r'

require '../lib/google_base.rb'

include Minion
include Jabber

job 'chat_server_bus' do |args|
  # log message to couchdb

  jid= ('santiago@junior-2.local')
  password= 'S4ntiag0'
  cl= Client::new(jid)
  cl.connect
  cl.auth(password)
  
  # send message to XMPP
  to= "admin@junior-2.local"
  subject= "santiago says:"
  body= "#{args[:msg]}#{args['msg']}"
  m= Message::new(to,body).set_type(:normal).set_id('1').set_subject(subject)
  cl.send m
end

#AMQP.start(:host => '192.168.1.1') do
#  amq= MQ.new
#  amq.queue('santiago').subscribe { |msg|
    # valid message is a message with a given JSON representation
    # in this case,
    # from:
    # to:
    # msg: 
#    msg= JSON.parse(msg)
#    item= {}
#    item["title"]= "Chat conversation with #{msg['from']}"
#    item["description"]= "#{msg['msg']}"
#    item["item_type"]= "conversations"
#    item["label"]= "#{msg['from']}-#{msg['to']}"
#    item["item_language"]= "es"
    
#    proxy= GData::Base::Items_Proxy.new(:tpl_dir=> "../views")
#    proxy.post "6197858", item
#  }
#end
