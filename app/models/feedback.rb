class Feedback < ActiveRecord::Base
  validates :email, :message, presence: true
end
