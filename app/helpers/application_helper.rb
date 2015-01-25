module ApplicationHelper
  def body_controller_action_class
    [controller.class.name.underscore.parameterize.dasherize, "action-#{action_name}"].join(' ')
  end

  def bootstrap_class_for flash_type
    { success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info' }[flash_type] || flash_type.to_s
  end
end
