require 'rails_helper'

describe UserMailer do
  let(:sender_email) { 'noreply@langtrainer.com' }

  describe 'activation_needed_email' do
    let(:user) { User.new(email: 'user@test.ru', activation_token: '_1234567_') }
    let(:mail) { UserMailer.activation_needed_email(user) }

    it 'renders the subject' do
      expect(mail.subject).to eql(I18n.t('user_mailer.activation_needed_email.subject'))
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql([sender_email])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include user.activation_token
    end
  end

  describe 'reset_password_email' do
    let(:user) { User.new(email: 'user@test.ru', reset_password_token: '_09876543_') }
    let(:mail) { UserMailer.reset_password_email(user) }

    it 'renders the subject' do
      expect(mail.subject).to eql(I18n.t('user_mailer.reset_password_email.subject'))
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql([sender_email])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include user.reset_password_token
    end
  end
end

