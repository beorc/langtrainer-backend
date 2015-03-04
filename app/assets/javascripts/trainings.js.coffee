courseSelector = null
unitSelector = null
languageSelector = null
stepView = null

Langtrainer.initializeTrainings = (data) ->
  return if $('.trainings-controller.action-show').length is 0
  success = (world) ->
    courseSelectorContainer = $('.course-selector-container').first()
    if courseSelectorContainer? && courseSelectorContainer.length > 0
      coursesCollection = world.get('coursesCollection')
      courseSelector ?= new Langtrainer.LangtrainerApp.Views.CourseSelector(
        collection: coursesCollection
        model: Langtrainer.LangtrainerApp.currentUser.getCurrentCourse()
      )
      courseSelector
        .render()
        .$el.detach().appendTo(courseSelectorContainer)

    unitSelectorContainer = $('.unit-selector-container').first()
    if unitSelectorContainer? && unitSelectorContainer.length > 0
      unitsCollection = world.get('unitsCollection')
      unitSelector ?= new Langtrainer.LangtrainerApp.Views.UnitSelector(
        collection: Langtrainer.LangtrainerApp.currentUser.getCurrentCourse().get('unitsCollection')
        model: Langtrainer.LangtrainerApp.currentUser.getCurrentCourse().getCurrentUnit()
      )
      unitSelector
        .render()
        .$el.detach().appendTo(unitSelectorContainer)

    languageSelectorContainer = $('.language-selector-container').first()
    if languageSelectorContainer? && languageSelectorContainer.length > 0
      languagesCollection = world.getForeignLanguages(Langtrainer.LangtrainerApp.currentUser.getCurrentNativeLanguage().get('slug'))
      languageSelector ?= new Langtrainer.LangtrainerApp.Views.ForeignLanguageSelector(
        collection: languagesCollection
        model: Langtrainer.LangtrainerApp.currentUser.getCurrentForeignLanguage()
        label: 'foreign_language'
      )
      languageSelector
        .render()
        .$el.detach().appendTo(languageSelectorContainer)

    stepViewContainer = $('#step-view').first()
    if stepViewContainer? && stepViewContainer.length > 0
      stepView ?= new Langtrainer.LangtrainerApp.Views.StepView(model: Langtrainer.LangtrainerApp.currentUser.getCurrentCourse().getCurrentUnit().getCurrentStep())
      stepView.$el.detach().appendTo(stepViewContainer.empty())
      stepView.render()

    Langtrainer.initView()

  error = ->
    alert(LangtrainerI18n.t('error'))

  if Langtrainer.LangtrainerApp.world.has('token')
    success(Langtrainer.LangtrainerApp.world)
  else
    Langtrainer.LangtrainerApp.trainingBus.on 'step:rendered', (model) ->
      $('.lt-question span.with-translation').each ->
        $(@).tooltip(placement: 'bottom')

    Langtrainer.LangtrainerApp.runTraining()
    Langtrainer.LangtrainerApp.world.fetch(success: success, error: error)

$(document).on "ready page:load", -> Langtrainer.initializeTrainings(gon.common)
