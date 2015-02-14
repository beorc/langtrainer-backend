class Api::Users::UsersController < Api::ApplicationController
  def update
    user = current_user

    if user.update(user_params)
      render json: user, status: :ok
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :token,
      :current_course_slug,
      :language_slug,
      :native_language_slug,
      :question_help_enabled
    )
  end
end
