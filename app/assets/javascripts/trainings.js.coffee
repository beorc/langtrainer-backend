@Styx.Initializers.Trainings =
  show: (data) ->
    $ ->
      success = ->
        world = Langtrainer.LangtrainerApp.world

        coursesCollection = world.get('coursesCollection')
        courseSelector = new Langtrainer.LangtrainerApp.Views.CourseSelector(
          collection: coursesCollection
          model: world.get('course')
        )
        courseSelector
          .render()
          .$el.appendTo('.course-selector-container')

        unitsCollection = world.get('course').get('unitsCollection')
        unitSelector = new Langtrainer.LangtrainerApp.Views.UnitSelector(
          collection: unitsCollection
          model: world.get('unit')
        )
        unitSelector
          .render()
          .$el.appendTo('.unit-selector-container')

      error = ->
        alert('Something went wrong')

      Langtrainer.LangtrainerApp.run(data, success, error)
