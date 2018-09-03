require 'facebook/messenger'
include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :message do |message|
  begin current_user
  rescue
    current_user = User.find_or_create_by(facebook_id: message.sender['id'])
  end

  if current_user.state.blank?
    pas_loue_message(message, current_user)
    main_menu(message, current_user)
    current_user.state = 'main_menu'
    current_user.save
  else
    main_menu(message, current_user)
  end

  Rails.logger.debug "The last message is #{message.inspect}"

  if (message.text.include?('photo') || message.text.include?('image') || message.text.include?('empereur')) && !current_user.state.include?('photo')
    message.reply(
      attachment: {
        type: 'image',
        payload: {
          url: 'https://cdn-s-www.lalsace.fr/images/23ca079d-9727-4c69-96e8-0b5d49c75544/BES_06/illustration-lorenzo-salad-tomat-onion_1-1522766737.jpg'
        }
      }
    )

    sleep(5)
    current_user.state += ' photo'
    current_user.save

    Rails.logger.debug "User state is #{current_user.state.inspect}"

    main_menu(message, current_user)

  elsif message.text.include?('bye') || message.text.include?('ciao') || message.text.include?('au revoir')
    message.reply(text: 'Tu vas retrouver de la beurette mamene !')
    message.reply(text: 'Tu le sais mamene')

    current_user.state = ""
    current_user.save

  elsif (message.text.include?('fermier') || message.text.include?('poulet')) && !current_user.state.include?('poulet')
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
    current_user.state += ' poulet'
    current_user.save

    main_menu(message, current_user)
  end
end

Bot.on :postback do |postback|
  current_user = User.find_by(facebook_id: postback.sender['id'])

  case postback.payload
  when 'sal'
    postback.reply(
      attachment: {
        type: 'image',
        payload: {
          url: 'https://media.giphy.com/media/ADL6Vi425PXUc/giphy.gif'
        }
      }
    )

  sleep(3)

  postback.typing_on

  postback.reply(text: 'Cherche pas mamene, c\'est la mienne celle là' )

  sleep(5)

  current_user.state += 'sal'
  current_user.save

  main_menu(postback, current_user)

  when 'tmtc'
    postback.typing_on

    postback.reply(text: 'Parce que c\'est toi, je vais te balancer une vanne de N°10')

    postback.reply(text: 'Tu vois la petite beurette, visualise la bien ..!')

    sleep(4)

    postback.typing_on

    postback.reply(text: 'bon tu lui demandes si elle veut un tour de magie, OKLM')

    sleep(2)

    postback.typing_on

    postback.reply(text: 'Forcément, ça répond oui et là tu lui lâches :')

    sleep(2)

    postback.typing_on

    postback.reply(text: '"ok j\'te baise et je disparais"')

    postback.reply(text: 'TMTC mamene')

    sleep(5)

    current_user.state += 'tmtc'
    current_user.save

    main_menu(postback, current_user)

  when 'teuteu'
    # postback.reply(
    #   attachment: {
    #     type: 'template',
    #     payload: {
    #       template_type: 'button',
    #       text: 'Faut suivre l\'empereur pour ça mamene!',
    #       buttons: [
    #         { type: 'postback', title: 'Montre moi la voie 👍', payload: 'go' },
    #         { type: 'postback', title: 'Oublie ! 👎', payload: 'no' },
    #       ]
    #     }
    #   }
    # )

    postback.reply(
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

  when 'go'
    postback.reply(
      attachment: {
        type: 'image',
        payload: {
          url: 'https://i.ytimg.com/vi/EjpJYaOQ7MY/hqdefault.jpg'
        }
      }
    )

    sleep(5)

    current_user.state += 'teuteu'
    current_user.save

    main_menu(postback, current_user)

  when 'no'
    postback.reply(text: 'tu dis ça, parce que j\'ai tiré ta meuf ?')

    postback.typing_on
    sleep(2)

    postback.reply(text: 'sans rancune mamene')

    sleep(5)

    current_user.state += 'teuteu'
    current_user.save

    main_menu(postback, current_user)
  end
end

def main_menu(kind, user)
  kind.reply(
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

def pas_loue_message(message, user)
  message.typing_on

  message.reply(text: 'PAS LOUÉ')

  sleep(2)

  message.typing_on

  user.state = 'main_menu'
end
