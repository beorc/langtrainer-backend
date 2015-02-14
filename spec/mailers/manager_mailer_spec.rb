require 'rails_helper'

describe ManagerMailer do
  let(:sender_email) { 'noreply@langtrainer.com' }
  let(:manager_email) { 'admin@test.ru' }
  let(:feedback) { Feedback.new(email: 'user@test.ru', message: 'Test message') }

  describe 'feedback' do
    let(:mail) { ManagerMailer.feedback(manager_email, feedback) }

    it 'renders the subject' do
      expect(mail.subject).to eql('New feedback message')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([manager_email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql([sender_email])
    end

    it 'renders the body' do
      verify(format: :html) { mail.body.encoded }
    end
  end
end

