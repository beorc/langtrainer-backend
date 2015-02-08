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

window.Langtrainer.initView = ->
  $('[data-toggle="tooltip"]').each ->
    options = {}
    placement = $(@).data('placement')
    options.placement = placement if placement

    $(@).tooltip(options)

@Styx.Initializers.Trainings =
  show: (data) ->
    $ ->
      courseSelector = null
      unitSelector = null
      nativeLanguageSelector = null
      languageSelector = null
      stepView = null
      navbarControl = null

      success = (world) ->
        coursesCollection = world.get('coursesCollection')
        courseSelector ?= new Langtrainer.LangtrainerApp.Views.CourseSelector(
          collection: coursesCollection
          model: world.get('course')
        )
        courseSelectorContainer = $('.course-selector-container')
        courseSelector
          .render()
          .$el.detach().appendTo(courseSelectorContainer)

        unitsCollection = world.get('unitsCollection')
        unitSelector ?= new Langtrainer.LangtrainerApp.Views.UnitSelector(
          collection: unitsCollection
          model: world.get('unit')
        )
        unitSelectorContainer = $('.unit-selector-container')
        unitSelector
          .render()
          .$el.detach().appendTo(unitSelectorContainer)

        nativeLanguagesCollection = world.get('nativeLanguagesCollection')
        nativeLanguageSelector ?= new Langtrainer.LangtrainerApp.Views.LanguageSelector(
          collection: nativeLanguagesCollection
          model: world.get('nativeLanguage')
          label: 'native_language'
        )
        nativeLanguageSelectorContainer = $('.native-language-selector-container')
        nativeLanguageSelector
          .render()
          .$el.detach().appendTo(nativeLanguageSelectorContainer)

        languagesCollection = world.get('languagesCollection')
        languageSelector ?= new Langtrainer.LangtrainerApp.Views.LanguageSelector(
          collection: languagesCollection
          model: world.get('language')
          label: 'language'
        )
        languageSelectorContainer = $('.language-selector-container')
        languageSelector
          .render()
          .$el.detach().appendTo(languageSelectorContainer)

        stepView ?= new Langtrainer.LangtrainerApp.Views.StepView(model: world.get('step'))
        stepViewContainer = $('#content')
        stepView.$el.detach().appendTo(stepViewContainer)
        stepView.render()

        navbarControl ?= new Langtrainer.LangtrainerApp.Views.NavbarControl
        navbarControlContainer = $('#lt-nav-control-container')
        navbarControl.$el.detach().appendTo(navbarControlContainer)
        navbarControl.render()

        Langtrainer.initView()
        Langtrainer.LangtrainerApp.globalBus.on 'localeChanged', Langtrainer.initView, @

      error = ->
        alert('Opps... Something went wrong!')

      Langtrainer.LangtrainerApp.run(data, success, error)

      Langtrainer.initYandexMetrika(data.yaMetrikaId, window, 'yandex_metrika_callbacks')
      Langtrainer.initYandexShare()
