Langtrainer.initializeUsersPasswordResets = (data) ->
    Langtrainer.LangtrainerApp.globalBus.on 'application:start', ->
      Langtrainer.LangtrainerApp.showPasswordResetDialog(data.token)

$ ->
  if $('.password-resets-controller.action-edit').length > 0
    Langtrainer.initializeUsersPasswordResets(gon)
