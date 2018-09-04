require 'facebook/messenger'
include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :message do |message|
  HandleIncomingMessage.new(message).perform
end

Bot.on :postback do |postback|
  current_user = FindOrCreateUser.new.perform(postback.sender['id'])
  out_going_message = OutgoingMessage.new(postback, current_user)

  case postback.payload
  when 'sal'
    out_going_message.deliver(:sal)

    current_user.state += 'sal'
    current_user.save

    out_going_message.deliver(:main_menu)

  when 'tmtc'
    out_going_message.deliver(:tmtc)

    current_user.state += 'tmtc'
    current_user.save

    out_going_message.deliver(:main_menu)

  when 'teuteu'
    if !current_user.state.include?('teuteu')
      out_going_message.deliver(:teuteu)
    else
      out_going_message.deliver(:malin)
    end
  end
end
