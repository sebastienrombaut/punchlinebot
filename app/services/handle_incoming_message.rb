class HandleIncomingMessage
attr_reader :message

  def initialize(message)
    @message = message
  end

  def perform
    current_user = FindOrCreateUser.new.perform(message.sender['id'])

    out_going_message = OutgoingMessage.new(message, current_user)

    intro_message(out_going_message, current_user)

    Rails.logger.debug "The last message is #{message.inspect}"

    interceptor_message(message, out_going_message, current_user)

    teuteu_message(message, out_going_message, current_user)
  end

  private

  def intro_message(out_going_message, user)
    if user.state.blank?
      out_going_message.deliver(:pas_loue)
      out_going_message.deliver(:main_menu)

      user.state = 'main_menu'
      user.save
    end
  end

  def interceptor_message(message, out_going_message, user)
    if (message.text.include?('photo') || message.text.include?('image') || message.text.include?('empereur')) && !user.state.include?('photo')
      out_going_message.deliver(:photo)

      user.state += ' photo'
      user.save

      Rails.logger.debug "User state is #{user.state.inspect}"

      out_going_message.deliver(:main_menu)

    elsif message.text.include?('bye') || message.text.include?('ciao') || message.text.include?('au revoir')
      out_going_message.deliver(:good_bye_messages)

      user.state = ""
      user.save

    elsif (message.text.include?('fermier') || message.text.include?('poulet')) && !user.state.include?('poulet')
      out_going_message.deliver(:poulet)

      user.state += ' poulet'
      user.save

      out_going_message.deliver(:main_menu)
    end
  end

  def teuteu_message(message, out_going_message, user)
    if !user.state.include?('teuteu')
      case message.quick_reply
      when 'go'
        out_going_message.deliver(:go_teuteu)

        user.state += 'teuteu'
        user.save

        out_going_message.deliver(:main_menu)

      when 'no'
        out_going_message.deliver(:no_teuteu)

        user.state += 'teuteu'
        user.save

        out_going_message.deliver(:main_menu)
      end
    end
  end
end