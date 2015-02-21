Langtrainer.initializeUsersPasswordResets = (data) ->
  Langtrainer.LangtrainerApp.showPasswordResetDialog(data.token)
  Langtrainer.LangtrainerApp.globalBus.once 'user:passwordChanged', ->
    Turbolinks.visit '/'

$ ->
  if $('.users-password-resets-controller.action-edit').length > 0
    Langtrainer.initializeUsersPasswordResets(gon)
