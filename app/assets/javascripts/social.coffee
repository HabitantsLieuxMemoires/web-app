window.socialControllers =
  initialized:false,
  facebook:
    settings:
      appId: '654760637922290' ## 654760637922290 = HLM Devel
    init: ->
      ## Load SDK
      $.getScript '//connect.facebook.net/fr_FR/all.js', ->
        FB.init socialControllers.facebook.settings
      ## Bind click on FB share button
      $('.shareFacebook').click ->
        socialControllers.facebook.shareAction $(this)
        return false
      debug "social::FB Initialized"
    shareAction: (elt) ->
      obj=
        method: 'feed'
        link: elt.data "url"
        picture: elt.data "image"
        name: elt.data "title"
        description: elt.data "text"
      FB.ui obj, (response)->
        socialControllers.shareCallback "facebook",response

  twitter:
    shareWindow:null,
    init: ->
      ## Load SDK
      $.getScript 'http://platform.twitter.com/widgets.js', ->
        # Twitter SDK do not provide a proper
        # 'tweet' event. Instead we'll catch
        # 'message' event triggered by the popup window.
        $(window).bind "message", (event) ->
          event = event.originalEvent
          if event.source == socialControllers.shareWindow && event.data != "__ready__"
            socialControllers.shareCallback "twitter", jQuery.parseJSON(event.data)
      ## Bind click on Twitter share button
      $('.shareTwitter').click ->
        socialControllers.twitter.shareAction $(this)
        return false
      debug "social::TW Initialized"
    shareAction: (elt) ->
      url = "https://twitter.com/intent/tweet?" + $.param({
        url: elt.data "url",
        text: elt.data "title"
      });
      socialControllers.shareWindow = window.open url, "", "toolbar=0, status=0, width=650, height=360"

  google:
    init: ->
      debug "social::G+ Not ready"

  ### This callback will receive callback result for :
    Twitter: Callback is allways success
    Facebook: Respense is empty in case of failure
  ###
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