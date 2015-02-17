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
    $ ->
      courseSelector = null
      unitSelector = null
      nativeLanguageSelector = null
      languageSelector = null
      stepView = null
      navbarControl = null

      stepViewContainer = $('#step-view').first()

      success = (world) ->
        courseSelectorContainer = $('.course-selector-container').first()
        if courseSelectorContainer?
          coursesCollection = world.get('coursesCollection')
          courseSelector ?= new Langtrainer.LangtrainerApp.Views.CourseSelector(
            collection: coursesCollection
            model: Langtrainer.LangtrainerApp.currentUser.getCurrentCourse()
          )
          courseSelector
            .render()
            .$el.detach().appendTo(courseSelectorContainer)

        unitSelectorContainer = $('.unit-selector-container').first()
        if unitSelectorContainer?
          unitsCollection = world.get('unitsCollection')
          unitSelector ?= new Langtrainer.LangtrainerApp.Views.UnitSelector(
            collection: Langtrainer.LangtrainerApp.currentUser.getCurrentCourse().get('unitsCollection')
            model: Langtrainer.LangtrainerApp.currentUser.getCurrentCourse().getCurrentUnit()
          )
          unitSelector
            .render()
            .$el.detach().appendTo(unitSelectorContainer)

        nativeLanguageSelectorContainer = $('.native-language-selector-container').first()
        if nativeLanguageSelectorContainer?
          nativeLanguagesCollection = world.get('nativeLanguagesCollection')
          nativeLanguageSelector ?= new Langtrainer.LangtrainerApp.Views.NativeLanguageSelector(
            collection: nativeLanguagesCollection
            model: world.get('nativeLanguage')
            label: 'native_language'
          )
          nativeLanguageSelector
            .render()
            .$el.detach().appendTo(nativeLanguageSelectorContainer)

        languageSelectorContainer = $('.language-selector-container').first()
        if languageSelectorContainer?
          languagesCollection = world.get('languagesCollection')
          languageSelector ?= new Langtrainer.LangtrainerApp.Views.ForeignLanguageSelector(
            collection: languagesCollection
            model: world.get('language')
            label: 'language'
          )
          languageSelector
            .render()
            .$el.detach().appendTo(languageSelectorContainer)

        if stepViewContainer?
          stepView ?= new Langtrainer.LangtrainerApp.Views.StepView(model: Langtrainer.LangtrainerApp.currentUser.getCurrentCourse().getCurrentUnit().getCurrentStep())
          stepView.$el.detach().appendTo(stepViewContainer)
          stepView.render()

        navbarControlContainer = $('#lt-nav-control-container').first()
        if navbarControlContainer?
          navbarControl ?= new Langtrainer.LangtrainerApp.Views.NavbarControl
          navbarControl.$el.detach().appendTo(navbarControlContainer)
          navbarControl.render()

        Langtrainer.initView()
        Langtrainer.LangtrainerApp.globalBus.on 'localeChanged', Langtrainer.initView, @

      error = ->
        alert(LangtrainerI18n.t('error'))

      if stepViewContainer?
        Langtrainer.LangtrainerApp.run(data, success, error)
      else
        success()

      Langtrainer.initYandexMetrika(data.yaMetrikaId, window, 'yandex_metrika_callbacks')
      Langtrainer.initYandexShare()
