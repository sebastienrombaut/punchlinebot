class OutgoingMessage
attr_reader :message,
  :user

  def initialize(message, user)
    @user = user
    @message = message
  end

  def deliver(method)
    send(method)
  end

  private

  def main_menu
    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'T\'es là mamene, si si ! Qu\'est ce qu\'il te faut pour t\'ambiancer ?',
          buttons: buttons_payload(user)
        }
      }
    )
  end

  def pas_loue
    message.typing_on

    message.reply(text: 'PAS LOUÉ')

    sleep(2)

    message.typing_on

    user.state = 'main_menu'
  end

  def good_bye_messages
    message.reply(text: 'Tu vas retrouver de la beurette mamene !')
    message.reply(text: 'Tu le sais mamene')
  end

  def buttons_payload
    if user.state.include?('teuteu')
      [
        { type: 'postback', title: 'Du Saaaal 💩', payload: 'sal' },
        { type: 'postback', title: 'TMTC ⚡️', payload: 'tmtc' },
      ]
    else
      [
        { type: 'postback', title: 'Du Saaaal 💩', payload: 'sal' },
        { type: 'postback', title: 'TMTC ⚡️', payload: 'tmtc' },
        { type: 'postback', title: 'Du bon teuteu 🌿', payload: 'teuteu' },
      ]
    end
  end
end