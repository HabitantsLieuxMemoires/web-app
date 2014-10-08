window.socialControllers =
  initialized:false,
  facebook:
    settings:
      appId: '1398812933674558' # Production
      # appId: '1400887326800452' # Testing
    init: ->
      ## Load SDK
      $.getScript '//connect.facebook.net/fr_FR/all.js', ->
        FB.init socialControllers.facebook.settings
      ## Bind click on FB share button
      $('.shareFacebook').click (e)-> 
        e.stopPropagation()
        e.preventDefault()
        elt = $(@)
        socialControllers.facebook.shareAction(elt)
        return false
      debug "social::FB Initialized"
    shareAction: (elt) ->
      obj=
        method: 'feed'
        link: elt.data "url"
        name: elt.data "title"
        caption: elt.data "title"
        description: elt.data "text"
        picture: elt.data "image"
      FB.ui obj, (response)->
        socialControllers.shareCallback "facebook",response

  twitter:
    shareWindow:null,
    init: ->
      ## Load SDK
      $.getScript 'http://platform.twitter.com/widgets.js', ->
        # Case 1 : Custom button
        # Twitter SDK do not provide a proper
        # 'tweet' event. Instead we'll catch
        # 'message' event triggered by the popup window.
        $(window).bind "message", (event) ->
          event = event.originalEvent
          if socialControllers.shareWindow? && event.source == socialControllers.shareWindow && event.data != "__ready__"
            socialControllers.shareCallback "twitter", jQuery.parseJSON(event.data)
        # Case 2 : Default button
        twttr.events.bind 'tweet', (event) ->
            socialControllers.shareCallback "twitter", event
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
      jQuery.getScript '//apis.google.com/js/plusone.js'
      debug "social::G+ Initialized"
    callback: (href, state) ->
      socialControllers.shareCallback("googleplus", state = "on" ? state : "")

  ### This callback will receive callback result for :
    Twitter: Callback is always success
    Facebook and Google: Response is empty in case of failure/cancel
  ###
  shareCallback: (service, response) ->
      if response?
        debug "Shared successfully on "+service+", response="
        debug response

        # Incrementing share counter
        articleURL = $('.article-data').data('uri')
        if articleURL
          $.ajax articleURL + '/share',
            type: 'GET',
            dataType: 'json',
            success: (data, textStatus, jqXHR) ->
              debug "Share counter incremented to " + data
              GoogleAnalytics.trackEvent 'Contenus populaires', 'Votes', articleURL
      else
        debug "Share cancelled for "+service

  init: ->
    if socialControllers.initialized == false
      socialControllers.initialized = true
      socialControllers.facebook.init()
      socialControllers.twitter.init()
      socialControllers.google.init()
      debug "social::Init done"

window.gTestCB= (json)->
  debug json

$(document).ready ->
  if $('.social-buttons').length
    socialControllers.init()
