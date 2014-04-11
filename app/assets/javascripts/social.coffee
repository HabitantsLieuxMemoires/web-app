window.socialButtonsController =
  init: ->
    Socialite.setup
      facebook:
        lang: 'fr_FR'
        #appId: 123456
        onlike: socialButtonsController.onLike
        onunlink: socialButtonsController.onUnlike
      twitter:
        lang:'fr'
        ontweet: socialButtonsController.onTweet
        onretweet: socialButtonsController.onRetweet
        onfavorite: socialButtonsController.onFavorite
        onfollow: socialButtonsController.onFollow
      googleplus:
        lang: 'fr-FR'
        onstartinteraction: socialButtonsController.onStartInteraction
        onendinteraction: socialButtonsController.onEndInteraction
        callback: socialButtonsController.gplusCallback
    Socialite.load $('#article-control')

# Page (re)loaded ?
$(document).ready ->
  socialButtonsController.init()
$(document).on 'page:load', ->
  socialButtonsController.init()