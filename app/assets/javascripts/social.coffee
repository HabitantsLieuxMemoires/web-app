window.socialControllers =
  initialized:false,
  facebook:
    settings:
      appId: '654760637922290' ## 654760637922290 = HLM Devel
    init: ->
      ## Load SDK
      $.getScript('//connect.facebook.net/fr_FR/all.js', ->
        FB.init socialControllers.facebook.settings
      )
      ## Bind click on FB share button
      $('.shareFacebook').click ->
        socialControllers.facebook.share $(this)
      debug "social::FB Initialized"
    share: (elt) ->
      obj=
        method: 'feed'
        link: elt.data "url"
        picture: elt.data "image"
        name: elt.data "title"
        description: elt.data "text"
      FB.ui obj, (response)->
        socialControllers.shareCallback "facebook",response

  twitter:
    init: ->
      debug "social::TW INIT"

  google:
    init: ->
      debug "social::G+ INIT"

  shareCallback: (service, response) ->
      if response?
        debug "Shared successfully on "+service+", response="
        debug response
      else
        debug "Share cancelled for "+service
  init: ->
    if socialControllers.initialized == false
      socialControllers.initialized = true
      socialControllers.facebook.init()
      socialControllers.twitter.init()
      socialControllers.google.init()
      console.log "social::Init done"

# Page (re)loaded ?
$(document).ready ->
  socialControllers.init()
$(document).on 'page:load', ->
  socialControllers.init()