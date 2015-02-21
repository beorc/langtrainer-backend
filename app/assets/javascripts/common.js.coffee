window.Langtrainer.initView = ->
  $('[data-toggle="tooltip"]').each ->
    options = {}
    placement = $(@).data('placement')
    options.placement = placement if placement

    $(@).tooltip(options)

window.Langtrainer.initYandexMetrika = (id, w, c) ->
  if id
    (w[c] = w[c] || []).push () ->
      try
        w[id] = new Ya.Metrika { id: id, enableAll: true, trackHash: true, webvisor: true, trackLinks: true }
      catch error
    $.getScript 'http://mc.yandex.ru/metrika/watch.js'

window.Langtrainer.initYandexShare = ->
  $.getScript "//yandex.st/share/share.js", () ->
    options =
      element: 'yashare'
      link: 'http://training.langtrainer.com'
      l10n: Langtrainer.LangtrainerApp.locale()
      elementStyle:
        type: 'button'
        quickServices: ['twitter', 'facebook', 'vkontakte', 'odnoklassniki']
      description: $('meta[name="description"]').attr('content')

    new Ya.share options

@Styx.Initializers.Common =
  initialize: (data)->
    nativeLanguageSelector = null
    navbarControl = null

    Langtrainer.LangtrainerApp.globalBus.on 'localeChanged', (slug) ->
      Turbolinks.visit window.location.pathname + "?locale=#{slug}"

    $(document).on("page:fetch", -> $('.lt-loading-indicator').show())
    $(document).on("page:receive", -> $('.lt-loading-indicator').hide())

    Langtrainer.LangtrainerApp.runGlobal(data)

    Langtrainer.initYandexMetrika(data.yaMetrikaId, window, 'yandex_metrika_callbacks')
    $ ->
      currentNativeLanguage = Langtrainer.LangtrainerApp.currentUser.getCurrentNativeLanguage()

      nativeLanguageSelectorContainer = $('.native-language-selector-container').first()
      if nativeLanguageSelectorContainer? && nativeLanguageSelectorContainer.length > 0
        nativeLanguagesCollection = Langtrainer.LangtrainerApp.world.get('languagesCollection')
        nativeLanguageSelector ?= new Langtrainer.LangtrainerApp.Views.NativeLanguageSelector(
          collection: nativeLanguagesCollection
          model: currentNativeLanguage
          label: 'native_language'
        )
        nativeLanguageSelector
          .render()
          .$el.detach().appendTo(nativeLanguageSelectorContainer)

      navbarControlContainer = $('#lt-nav-control-container').first()
      if navbarControlContainer? && navbarControlContainer.length > 0
        navbarControl ?= new Langtrainer.LangtrainerApp.Views.NavbarControl
        navbarControl.$el.detach().appendTo(navbarControlContainer)
        navbarControl.render()

      Langtrainer.initView()
      Langtrainer.initYandexShare()
