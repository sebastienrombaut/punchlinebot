class IncomingMessages
  def main_menu(user)
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

  def pas_loue_message(user)
    message.typing_on

    message.reply(text: 'PAS LOUÉ')

    sleep(2)

    message.typing_on

    user.state = 'main_menu'
  end

  private

  def buttons_payload(user)
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