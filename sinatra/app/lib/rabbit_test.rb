
require 'rubygems'
require 'mq'

AMQP.start(:host=>'localhost') do
  amq= MQ.new
  amq.queue('santiago').subscribe do |msg|
    p msg
  end
end

require 'rubygems'
require 'mq'

AMQP.start(:host=>'localhost') do
  amq= MQ.new
  amq.queue('santiago').publish("la cuturubrita loca")
  AMQP.stop
end