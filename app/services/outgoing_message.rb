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

  def pas_loue
    message.typing_on

    message.reply(text: 'PAS LOUÉ')

    sleep(2)

    message.typing_on

    message.reply(text: 'J\'te propose un petit jeu mamene, essaye de trouver la faille pour intégrer la team du sal !')

    sleep(2)

    user.state = 'main_menu'
  end

  def main_menu
    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'T\'es là mamene, si si ! Qu\'est ce qu\'il te faut pour t\'ambiancer ?',
          "persona_id"=> "318552875394434",
          buttons: buttons_payload(user)

        }
      }
    )
  end

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

  def photo
    message.reply(
      attachment: {
        type: 'image',
        payload: {
          url: 'https://cdn-s-www.lalsace.fr/images/23ca079d-9727-4c69-96e8-0b5d49c75544/BES_06/illustration-lorenzo-salad-tomat-onion_1-1522766737.jpg'
        }
      }
    )
    sleep(2)

    message.reply(text: 'oé je suis champion du monde ma gueule')

    sleep(5)
  end

  def poulet
    message.reply(text: 'tu l\'aimes celui là mamene ?')

    message.typing_on

    sleep(2)

    message.reply(
      attachment: {
        type: 'image',
        payload: {
          url: 'http://courses.carrefour.fr/static/wlpdatas/display/000/141/765/1417659.jpg'
        }
      }
    )

    sleep(5)
  end

  def go_teuteu
    message.reply(
      attachment: {
        type: 'image',
        payload: {
          url: 'https://i.ytimg.com/vi/EjpJYaOQ7MY/hqdefault.jpg'
        }
      }
    )
    sleep(5)
  end

  def no_teuteu
    message.reply(text: 'tu dis ça, parce que j\'ai tiré ta meuf ?')

    message.typing_on
    sleep(2)

    message.reply(text: 'sans rancune mamene')

    sleep(5)
  end

  def malin
    message.reply(text: 't\'es un petit malin mamene, allez je te recrute dans la team du sal')

    message.typing_on
    sleep(2)

    message.reply(text: 'A nous les petites beurettes ! 💃')
  end

  def sal
    message.reply(
      attachment: {
        type: 'image',
        payload: {
          url: 'https://media.giphy.com/media/ADL6Vi425PXUc/giphy.gif'
        }
      }
    )

    sleep(3)

    message.typing_on

    message.reply(text: 'Cherche pas mamene, c\'est la mienne celle là' )

    sleep(5)
  end

  def tmtc
    message.typing_on

    message.reply(text: 'Parce que c\'est toi, je vais te balancer une vanne de N°10')

    message.reply(text: 'Tu vois la petite beurette, visualise la bien ..!')

    sleep(4)

    message.typing_on

    message.reply(text: 'bon tu lui demandes si elle veut un tour de magie, OKLM')

    sleep(2)

    message.typing_on

    message.reply(text: 'Forcément, ça répond oui et là tu lui lâches :')

    sleep(2)

    message.typing_on

    message.reply(text: '"ok j\'te baise et je disparais"')

    message.reply(text: 'TMTC que TMTK mamene')

    sleep(5)
  end

  def teuteu
    message.reply(
      text: 'Faut suivre l\'empereur pour ça mamene!',
      quick_replies: [
        {
          content_type: 'text',
          title: 'Montre moi la voie 👍',
          payload: 'go',
        },
        {
          content_type: 'text',
          title: 'Oublie ! 👎',
          payload: 'no',
        },
      ]
    )
  end

  def good_bye_messages
    message.reply(text: 'Tu vas retrouver de la beurette mamene !')
    message.reply(text: 'Tu le sais mamene')
  end
end