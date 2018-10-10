require 'facebook/messenger'
include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.deliver({
  recipient: {
    id: '45123'
  },
  message: {
    text: 'Human?'
  },
  "persona_id" => "318552875394434"
}, access_token: ENV['ACCESS_TOKEN'])


Bot.on :message do |message|
  HandleIncomingMessage.new(message).perform
end

Bot.on :postback do |postback|
  HandleIncomingPostback.new(postback).perform
end
