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
  #message.reply(text: 'PAS LOUÉ')
  #message.reply(text: 'T\'es là mamene')
  message.typing_on

  message.reply(
    text: 'T\'es là mamene \n Qu\'est ce qu\'il te faut pour t\'ambiancer ?',
    quick_replies: [
      {
        content_type: 'text',
        title: 'Du Saaaal 💩',
        payload: 'sal'
      },
      {
        content_type: 'text',
        title: 'TMTC ⚡️',
        payload: 'tmtc'
      },
      {
        content_type: 'text',
        title: 'Du bon teuteu 🌿',
        payload: 'teuteu'
      }
    ]
  )
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
    postback.reply(
      attachment: {
        type: 'video',
        payload: {
          url: 'https://www.youtube.com/watch?v=EjpJYaOQ7MY'
        }
      }
    )
  when postback.payload == 'teuteu'
    payload = 'Faut suivre l\'empereur pour ça mamene!'
  end

  postback.reply(
    text: payload
  )
end
