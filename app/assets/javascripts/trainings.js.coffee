@Styx.Initializers.Trainings =
  show: (data) ->
    $ ->
      success = (world) ->
        coursesCollection = world.get('coursesCollection')
        courseSelector = new Langtrainer.LangtrainerApp.Views.CourseSelector(
          collection: coursesCollection
          model: world.get('course')
        )
        courseSelector
          .render()
          .$el.appendTo('.course-selector-container')

        unitsCollection = world.get('unitsCollection')
        unitSelector = new Langtrainer.LangtrainerApp.Views.UnitSelector(
          collection: unitsCollection
          model: world.get('unit')
        )
        unitSelector
          .render()
          .$el.appendTo('.unit-selector-container')

        nativeLanguagesCollection = world.get('nativeLanguagesCollection')
        nativeLanguageSelector = new Langtrainer.LangtrainerApp.Views.LanguageSelector(
          collection: nativeLanguagesCollection
          model: world.get('nativeLanguage')
          label: 'Native language'
        )
        nativeLanguageSelector
          .render()
          .$el.appendTo('.native-language-selector-container')

        languagesCollection = world.get('languagesCollection')
        languageSelector = new Langtrainer.LangtrainerApp.Views.LanguageSelector(
          collection: languagesCollection
          model: world.get('language')
          label: 'Language'
        )
        languageSelector
          .render()
          .$el.appendTo('.language-selector-container')

        stepView = new Langtrainer.LangtrainerApp.Views.StepView(model: world.get('step'))
        stepView.$el.appendTo('#content')
        stepView.render()

        $('[data-toggle="tooltip"]').each ->
          options = {}
          placement = $(@).data('placement')
          options.placement = placement if placement

          $(@).tooltip(options)

        initYandexMetrika = (w, c) ->
          if data.yaMetrikaId
            (w[c] = w[c] || []).push () ->
              try
                w[data.yaMetrikaId] = new Ya.Metrika { id: data.yaMetrikaId, enableAll: true, trackHash: true, webvisor: true, trackLinks: true }
              catch error
            $.getScript 'http://mc.yandex.ru/metrika/watch.js'

        initYandexMetrika(window, 'yandex_metrika_callbacks')

      error = ->
        alert('Opps... Something went wrong!')

      Langtrainer.LangtrainerApp.run(data, success, error)

