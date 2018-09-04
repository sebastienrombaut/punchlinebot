require 'facebook/messenger'
include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :message do |message|
  HandleIncomingMessage.new(message).perform
end

Bot.on :postback do |postback|
  HandleIncomingMessage.new(postback).perform
end
