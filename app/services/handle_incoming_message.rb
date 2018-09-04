class HandleIncomingMessage
attr_reader :message

  def initialize(message)
    @message = message
  end

  def perform
    begin current_user
    rescue
      current_user = FindOrCreateUser.new.perform(message.sender['id'])
    end

    out_going_message = OutgoingMessage.new(message, current_user)

    intro_message(out_going_message, current_user)

    Rails.logger.debug "The last message is #{message.inspect}"

    interceptor_message(out_going_message, current_user)

    teuteu_message(out_going_message, current_user)
  end

  private

  def intro_message(out_going_message, user)
    if current_user.state.blank?
      out_going_message.deliver(:pas_loue)
      out_going_message.deliver(:main_menu)

      current_user.state = 'main_menu'
      current_user.save
    end
  end

  def interceptor_message(out_going_message, user)
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
  end

  def teuteu_message(out_going_message, user)
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
end