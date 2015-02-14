require 'rails_helper'

feature "Sign in", :type => :feature do
  context 'given activated user' do
    let (:user) { Factory.create(:user) }

    before(:each) { user.activate! }

    scenario 'Allows user to sign in' do
      visit root_path

      #page.save_screenshot('/home/beorc/screen.png')
      #page.driver.debug

      Timeout.timeout(Capybara.default_wait_time) do
        loop until all('a.sign-in-btn', visible: true).present?
      end

      find('a.sign-in-btn').click

      fill_in('email', with: user.email)
      fill_in('password', with: '123456')

      find('.modal .js-submit').click

      expect(find('#dialog-sign-in .modal-body .step-b', visible: true)).to be_present
      find('.modal .js-close').click

      expect(find('span.user-email').text).to eq 'test@test.ru'
    end
  end

  context 'given not activated user' do
    let (:user) { Factory.create(:user) }

    scenario 'Allows user to sign in' do
      visit root_path

      #page.save_screenshot('/home/beorc/screen.png')
      #page.driver.debug

      Timeout.timeout(Capybara.default_wait_time) do
        loop until all('a.sign-in-btn', visible: true).present?
      end

      find('a.sign-in-btn').click

      fill_in('email', with: user.email)
      fill_in('password', with: '123456')

      find('.modal .js-submit').click

      find('#modal-activate .modal-body a.js-submit-btn').click
      expect(find('#modal-activate .modal-body .alert-success')).to be_present

      url  = "/users/activate?token=#{user.activation_token}"
      visit url

      expect(find('span.user-email').text).to eq 'test@test.ru'
      expect(find('.alert').text).to include I18n.t('flashes.activated_successfully')
    end
  end
end
