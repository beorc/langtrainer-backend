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
        )
        nativeLanguageSelector
          .render()
          .$el.appendTo('.native-language-selector-container')

        languagesCollection = world.get('languagesCollection')
        languageSelector = new Langtrainer.LangtrainerApp.Views.LanguageSelector(
          collection: languagesCollection
          model: world.get('language')
        )
        languageSelector
          .render()
          .$el.appendTo('.language-selector-container')

      error = ->
        alert('Something went wrong')

      Langtrainer.LangtrainerApp.run(data, success, error)
