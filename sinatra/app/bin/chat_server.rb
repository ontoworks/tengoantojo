#!/usr/bin/env ruby

require 'rubygems'
require 'eventmachine'
#require 'xmpp4r'
require 'xmpp4r-simple'

__DIR__ = File.dirname File.expand_path(__FILE__)

EM.run {
  class My_Client
    def initialize(server)
      jid= ('santiago@junior-2.local')
      password= 'S4ntiag0'
#      socket= Jabber::Simple.new(jid,password)
#      server.socket=socket
      EM::PeriodicTimer.new(2) do
#        socket.received_messages do |msg|
#          puts "Received message:#{"msg"}"
#        end
      end
#      socket
    end
  end


  class Chat_Server < EM::Connection
    attr_accessor :socket

    def self.start host, port
      puts ">> Chat Server started on #{host}:#{port}"
      EM.start_server host, port, self
    end
    
    def post_init
      unless @socket
        puts ">> Connecting to XMPP server"
        client= My_Client.new(self)
        # @socket= client.run
        puts ">> Connected to XMPP server"
      end
      
      @buf = BufferedTokenizer.new("\0")
      @ip = Socket.unpack_sockaddr_in(get_peername).last rescue '0.0.0.0'
      puts ">> Chat Server got connection from #{@ip}"
    end
    
    def unbind
      @timer.cancel if @timer
      puts ">> Chat Server got disconnect from #{@ip}"
    end
    
    def receive_data data
      if data.strip == "<policy-file-request/>"
        send %[
          <?xml version="1.0"?>
          <!DOCTYPE cross-domain-policy SYSTEM "http://www.macromedia.com/xml/dtds/cross-domain-policy.dtd">
          <cross-domain-policy>
            <allow-access-from domain="*" to-ports="*" />
          </cross-domain-policy>
        ]
        close_connection_after_writing
        return
      end

      # send message to XMPP
      to= "admin@junior-2.local"
      subject= "santiago says:"
      body= "#{data}"
#      m= Message::new(to,body).set_type(:normal).set_id('1').set_subject(subject)
#      @cl.send m
      deliver(to,body)
      send body
      # get messages from xmpp
      # timer here
    end

    def send data
      send_data "#{data}"
    end

    def deliver(to,data)
      jid= 'santiago@junior-2.local'
      password= 'S4ntiag0'
#      @socket= Jabber::Simple.new(@jid,@password)      
#      @socket.deliver(to,data)
    end
  end
  
  Chat_Server.start  'localhost', 1234
}
