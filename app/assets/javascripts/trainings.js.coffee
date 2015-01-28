@Styx.Initializers.Trainings =
  show: (data) ->
    $ ->
      success = ->
        courseSelector = new Langtrainer.LangtrainerApp.Views.CourseSelector(model: Langtrainer.LangtrainerApp.world)
        courseSelector
          .render()
          .$el.appendTo('.course-selector-container')

      error = ->
        alert('Something went wrong')

      Langtrainer.LangtrainerApp.run(data, success, error)
