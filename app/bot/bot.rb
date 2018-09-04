require 'facebook/messenger'
include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :message do |message|
  begin current_user
  rescue
    current_user = FindOrCreateUser.new.perform(message.sender['id'])
  end

  out_going_message = OutgoingMessage.new(message, current_user)

  if current_user.state.blank?
    out_going_message.deliver(:pas_loue)
    out_going_message.deliver(:main_menu)

    current_user.state = 'main_menu'
    current_user.save
  end

  Rails.logger.debug "The last message is #{message.inspect}"

  if (message.text.include?('photo') || message.text.include?('image') || message.text.include?('empereur')) && !current_user.state.include?('photo')
    out_going_message.deliver(:photo)

    current_user.state += ' photo'
    current_user.save

    Rails.logger.debug "User state is #{current_user.state.inspect}"

    out_going_message.deliver(:main_menu)

  elsif message.text.include?('bye') || message.text.include?('ciao') || message.text.include?('au revoir')
    out_going_message.deliver(:good_bye_messages)

    current_user.state = ""
    current_user.save

  elsif (message.text.include?('fermier') || message.text.include?('poulet')) && !current_user.state.include?('poulet')
    out_going_message.deliver(:poulet)

    current_user.state += ' poulet'
    current_user.save

    out_going_message.deliver(:main_menu)
  end

  if !current_user.state.include?('teuteu')
    case message.quick_reply
    when 'go'
      out_going_message.deliver(:go_teuteu)

      current_user.state += 'teuteu'
      current_user.save

      out_going_message.deliver(:main_menu)

    when 'no'
      out_going_message.deliver(:no_teuteu)

      current_user.state += 'teuteu'
      current_user.save

      out_going_message.deliver(:main_menu)
    end
  end
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
    out_going_message.deliver(:teuteu)
  end
end
