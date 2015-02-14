require 'rails_helper'

feature "Password reset", :type => :feature do
  let (:user) { Factory.create(:user) }

  scenario 'Allows user to reset password' do
    visit root_path

    #page.save_screenshot('/home/beorc/screen.png')
    #page.driver.debug

    Timeout.timeout(Capybara.default_wait_time) do
      loop until all('a.sign-in-btn', visible: true).present?
    end

    find('a.sign-in-btn').click

    find('.modal .password-reset-request-btn').click

    fill_in('email', with: user.email)

    find('#modal-password-reset-request .modal-footer .js-submit').click
    expect(find('#modal-password-reset-request .step-b', visible: true)).to be_present

    page.save_screenshot('/home/beorc/screen.png')
    find('#modal-password-reset-request .js-resend-email-btn').click
    expect(find('#modal-password-reset-request .modal-body .alert-success')).to be_present

    url  = edit_users_password_reset_path(user.reload.reset_password_token)
    visit url

    expect(find('#modal-password-reset', visible: true)).to be_present

    fill_in('password', with: '123456')
    fill_in('password_confirmation', with: '123456')

    find('#modal-password-reset .step-a .js-submit').click
    expect(find('#modal-password-reset .step-b', visible: true)).to be_present

    find('#modal-password-reset .step-b .js-close').click
  end
end
