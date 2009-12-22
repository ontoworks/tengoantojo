


# user sends a message to friend
get '/:user/friends/:friend' do
  AMQP.start(:host=> 'localhost') do
    amq= MQ.new
    amq.queue('santiago').publish("message from #{params[:user]} to #{params[:friend]}")
  end
  "message from #{params[:user]} to #{params[:friend]}"
end