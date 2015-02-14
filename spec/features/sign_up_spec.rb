require 'rails_helper'

feature "Sign up", :type => :feature do
  scenario 'Allows user to sign up' do
    visit root_path

    #page.save_screenshot('/home/beorc/screen.png')
    #page.driver.debug

    Timeout.timeout(Capybara.default_wait_time) do
      loop until all('a.sign-up-btn', visible: true).present?
    end

    find('a.sign-up-btn').click

    fill_in('email', with: 'test@test.ru')
    fill_in('password', with: '123456')
    fill_in('password_confirmation', with: '123456')

    find('.modal .js-submit').click

    find('#modal-activate .modal-body a.js-submit-btn').click
    expect(find('#modal-activate .modal-body .alert-success')).to be_present

    url  = "/users/activate?token=#{User.last.activation_token}"
    visit url

    expect(find('span.user-email').text).to eq 'test@test.ru'
    expect(find('.alert').text).to include I18n.t('flashes.activated_successfully')
  end
end
