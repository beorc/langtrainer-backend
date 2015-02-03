window.Langtrainer.initYandexMetrika = (id, w, c) ->
  if id
    (w[c] = w[c] || []).push () ->
      try
        w[id] = new Ya.Metrika { id: id, enableAll: true, trackHash: true, webvisor: true, trackLinks: true }
      catch error
    $.getScript 'http://mc.yandex.ru/metrika/watch.js'

window.Langtrainer.initYandexShare = ->
  $.getScript "//yandex.st/share/share.js", () ->
    # Конструирование текста, который будет вставлен в тело lj-поста
    ljDescription = () ->
      container = $('<p></p>')

      aTag = $("<a></a>").attr('href', window.location.href)
      footLink = aTag.clone().
        text($('title').text()).
        wrap('<p>').parent()

      description = $('.lj-description p:first').clone()
      if description.length == 0
        text = $('meta[name="description"]').attr('content')
        description = $("<p>#{text}</p>")
      if description
        container.append(description)

      container.append(footLink)

      imgUrl = $('.lj-image').attr 'src'
      if imgUrl && imgUrl.length > 0
        imgContainer = aTag.clone()
        $('<img></img>').
          attr('src', imgUrl).
          attr('title', $('title')).
          appendTo imgContainer
        container.prepend imgContainer

      container.html()

    options =
      element: 'yashare'
      l10n: Langtrainer.LangtrainerApp.currentUser.getCurrentNativeLanguage().get('slug')
      elementStyle:
        type: 'button'
        quickServices: ['twitter', 'facebook', 'vkontakte', 'odnoklassniki']
      title: 'Share',
      image: $('meta[property="og:image"]').attr('content'),
      description: $('meta[name="description"]').attr('content'),
      serviceSpecific:
        lj:
          description: ljDescription()

    new Ya.share options

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

        navbarControl = new Langtrainer.LangtrainerApp.Views.NavbarControl
        navbarControl.$el.appendTo('#lt-nav-control-container')
        navbarControl.render()

        $('[data-toggle="tooltip"]').each ->
          options = {}
          placement = $(@).data('placement')
          options.placement = placement if placement

          $(@).tooltip(options)

        Langtrainer.initYandexMetrika(data.yaMetrikaId, window, 'yandex_metrika_callbacks')
        Langtrainer.initYandexShare()

      error = ->
        alert('Opps... Something went wrong!')

      Langtrainer.LangtrainerApp.run(data, success, error)

