@Styx.Initializers.PasswordResets =
  edit: (token) ->
    Langtrainer.LangtrainerApp.showPasswordResetDialog(token)

