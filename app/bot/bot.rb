require 'facebook/messenger'
include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

# Bot.deliver({
#   recipient: {
#     id: '45123'
#   },
#   message: {
#     text: 'T\'es là mamene'
#   },
#   message_type: Facebook::Messenger::Bot::MessagingType::MESSAGE_TAG,
#   tag: Facebook::Messenger::Bot::Tag::NON_PROMOTIONAL_SUBSCRIPTION
# })

Bot.on :message do |message|
  message.typing_on

  message.reply(text: 'PAS LOUÉ')

  message.typing_on

  message.reply(
    attachment: {
      type: 'template',
      payload: {
        template_type: 'button',
        text: 'T\'es là mamene, si si ! Qu\'est ce qu\'il te faut pour t\'ambiancer ?',
        buttons: [
          { type: 'postback', title: 'Du Saaaal 💩', payload: 'sal' },
          { type: 'postback', title: 'TMTC ⚡️', payload: 'tmtc' },
          { type: 'postback', title: 'Du bon teuteu 🌿', payload: 'teuteu' },
        ]
      }
    }
  )

  # message.reply(
  #   text: 'T\'es là mamene, si si ! Qu\'est ce qu\'il te faut pour t\'ambiancer ?',
  #   quick_replies: [
  #     {
  #       content_type: 'text',
  #       title: 'Du Saaaal 💩',
  #       payload: 'sal'
  #     },
  #     {
  #       content_type: 'text',
  #       title: 'TMTC ⚡️',
  #       payload: 'tmtc'
  #     },
  #     {
  #       content_type: 'text',
  #       title: 'Du bon teuteu 🌿',
  #       payload: 'teuteu'
  #     }
  #   ]
  # )
  if message.text.include?('photo') || message.text.include?('image')
    message.reply(
      attachment: {
        type: 'image',
        payload: {
          url: 'https://cdn-s-www.lalsace.fr/images/23ca079d-9727-4c69-96e8-0b5d49c75544/BES_06/illustration-lorenzo-salad-tomat-onion_1-1522766737.jpg'
        }
      }
    )
  elsif message.text.include?('bye')
    message.reply(text: 'Tu vas retrouver de la beurette mamene !')
    message.reply(text: 'Tu le sais mamene')
  end
end

Bot.on :postback do |postback|
  case postback.payload
  when 'sal'
    postback.reply(
      attachment: {
        type: 'image',
        payload: {
          url: 'https://gph.is/2bjzBvW'
        }
      }
    )
  when 'tmtc'
    message.typing_on

    postback.reply(text: 'Parce que c\'est toi, je vais te balancer une vanne de N°10')

    message.typing_on

    postback.reply(text: 'Tu vois la petite beurette, visualise la bien ..!')

    sleep(2)

    postback.reply(text: 'bon tu lui demandes si elle veut un tour de magie, OKLM')

    message.typing_on

    postback.reply(text: 'Forcément, ça répond oui et là tu lui lâches, "ok j\'te baise et je disparais"')

    message.typing_on

    postback.reply(text: 'TMTC mamene')

  when postback.payload == 'teuteu'
    postback.reply(text: 'Faut suivre l\'empereur pour ça mamene!')

    postback.reply(
      attachment: {
        type: 'video',
        payload: {
          url: 'https://www.youtube.com/watch?v=EjpJYaOQ7MY'
        }
      }
    )
  end
end
