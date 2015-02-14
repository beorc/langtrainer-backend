require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { Factory.build(:user) }
  subject(:user) { user }

  it { should be_valid }
end
