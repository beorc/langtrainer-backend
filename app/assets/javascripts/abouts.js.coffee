@Styx.Initializers.Abouts =
  show: (data) ->
    Langtrainer.LangtrainerApp.globalBus.on 'application:start', ->
      Langtrainer.LangtrainerApp.globalBus.on 'localeChanged', (slug) ->
        window.location.search = "?locale=#{slug}"

