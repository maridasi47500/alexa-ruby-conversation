require 'json'

def lambda_handler(event:, context:)
    # TODO implement
    p("hi evey1", event["request"]["type"])
   
    begin
      
      case event["request"]["type"]
      when "LaunchRequest"
        speak="Salut toi ! Bienvenue! discutons."
      else
        case event["request"]["intent"]["name"]
        when "AMAZON.StopIntent"
            speak="ok ! si tu dois partir maintenant, à bientôt!"
        when "AMAZON.HelpIntent"
            speak="parlons d'emploi, de travail ou de ce que tu veux !!"
        when "AMAZON.CancelIntent"
            speak="ok"
        when "HelloWorldIntent"
            speak="Salut toi !"
        when "name"
            speak="Bienvenue "+event["request"]["intent"]["slots"]["myname"]["value"]+", ravie de faire ta connaissance !"
        when "travail_intent"
            speak="Ravie de te savoir "+event["request"]["intent"]["slots"]["montravail"]["slotValue"]["value"]+" ! Puis je te connaître un peu plus"
        when "chat"
            reponse=event["request"]["intent"]["slots"]["reponse"]["slotValue"]["value"]
            if ["oui","peut-être"].include?(reponse)
              speak="cool ! on peut chatter"
            else
              speak="à une autre fois peut-être!"
            end
        end

      end

    rescue => e
      speak="Désolée , il y a eu une erreur "+e.message
    end
    {
  "version": "1.0",
  "response": {
    "outputSpeech": {
      "type": "SSML",
      "ssml": "<speak>"+speak+"</speak>"
    },
    "reprompt": {
      "outputSpeech": {
        "type": "SSML",
        "ssml": "<speak>J'ai pas compris, comment ?</speak>"
      }
    },
    "shouldEndSession": false
  },
  "userAgent": "ask-node/2.3.0 Node/v8.10.0",
  "sessionAttributes": {}
  }
end

json_conversation_hash={
    "interactionModel": {
        "languageModel": {
            "invocationName": "ma conversation",
            "intents": [
                {
                    "name": "AMAZON.CancelIntent",
                    "samples": []
                },
                {
                    "name": "AMAZON.HelpIntent",
                    "samples": []
                },
                {
                    "name": "AMAZON.StopIntent",
                    "samples": []
                },
                {
                    "name": "HelloWorldIntent",
                    "slots": [],
                    "samples": [
                        "bonjour",
                        "coucou",
                        "salut",
                        "me dire bonjour"
                    ]
                },
                {
                    "name": "AMAZON.NavigateHomeIntent",
                    "samples": []
                },
                {
                    "name": "name",
                    "slots": [
                        {
                            "name": "myname",
                            "type": "AMAZON.FirstName"
                        }
                    ],
                    "samples": [
                        "je m'appelle {myname}"
                    ]
                },
                {
                    "name": "travail_intent",
                    "slots": [
                        {
                            "name": "montravail",
                            "type": "reponsetravail"
                        }
                    ],
                    "samples": [
                        "j'ai {montravail}",
                        "je suis {montravail}"
                    ]
                },
                {
                    "name": "chat",
                    "slots": [
                        {
                            "name": "reponse",
                            "type": "mareponse"
                        }
                    ],
                    "samples": [
                        "{reponse} je veux chatter",
                        "{reponse} on peut chatter",
                        "{reponse}"
                    ]
                }
            ],
            "types": [
                {
                    "name": "mareponse",
                    "values": [
                        {
                            "name": {
                                "value": "pas du tout"
                            }
                        },
                        {
                            "name": {
                                "value": "peut-être"
                            }
                        },
                        {
                            "name": {
                                "value": "non"
                            }
                        },
                        {
                            "name": {
                                "value": "oui"
                            }
                        }
                    ]
                },
                {
                    "name": "reponsetravail",
                    "values": [
                        {
                            "name": {
                                "value": "à la recherche d'un emploi"
                            }
                        },
                        {
                            "name": {
                                "value": "sans emploi"
                            }
                        },
                        {
                            "name": {
                                "value": "un emploi"
                            }
                        },
                        {
                            "name": {
                                "value": "un travail"
                            }
                        }
                    ]
                }
            ]
        }
    }
}
