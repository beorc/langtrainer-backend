class Api::FeedbackController < Api::ApplicationController
  def create
    @feedback = Feedback.create(feedback_params)

    if @feedback.persisted?
      begin
        ManagerMailer.feedback(ENV['MANAGER_EMAILS'], @feedback).deliver!
      rescue Mandrill::Error => e
        Rollbar.error(e)
      end
      render json: {}, status: :created
    else
      render json: { errors: @feedback.errors }, status: :unprocessable_entity
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit([:email, :message])
  end
end
