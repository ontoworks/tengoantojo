


# user sends a message to friend
post '/:user/friends/:friend' do
  AMQP.start(:host=> '192.168.2.6') do
    amq= MQ.new
    amq.queue('one').publish('message from #{params[:user] to #params{:friend}}')
  end
end
