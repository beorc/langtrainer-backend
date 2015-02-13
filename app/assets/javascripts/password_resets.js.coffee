@Styx.Initializers.UsersPasswordResets =
  edit: (data) ->
    Langtrainer.LangtrainerApp.globalBus.on 'application:start', ->
      Langtrainer.LangtrainerApp.showPasswordResetDialog(data.token)
