class HandleIncomingPostback
attr_reader :postback

  def initialize(postback)
    @postback = postback
  end

  def perform
    current_user = FindOrCreateUser.new.perform(postback.sender['id'])
    out_going_message = OutgoingMessage.new(postback, current_user)

    case postback.payload
    when 'sal'
      sal_case(out_going_message, current_user)

    when 'tmtc'
      tmtc_case(out_going_message, current_user)

    when 'teuteu'
      teuteu_case(out_going_message, current_user)
    end
  end

  private

  def sal_case(out_going_message, user)
    out_going_message.deliver(:sal)

    user.state += 'sal'
    user.save

    out_going_message.deliver(:main_menu)
  end

  def tmtc_case(out_going_message, user)
    out_going_message.deliver(:tmtc)

    user.state += 'tmtc'
    user.save

    out_going_message.deliver(:main_menu)
  end

  def teuteu_case(out_going_message, user)
    if !user.state.include?('teuteu')
      out_going_message.deliver(:teuteu)
    else
      out_going_message.deliver(:malin)
    end
  end
end