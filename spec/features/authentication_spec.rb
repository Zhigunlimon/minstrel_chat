require_relative 'feature_helper'

feature 'User authentication actions', %q{
        In order to be able to use site like registered user or visitor
        As an user
        I want to be able to sign in, sign out and register
        } do

  given(:user) { create(:user) }

  scenario 'User try to register' do
    visit root_path
    click_on 'Registration'
    fill_in 'Email', with: 'newuser@test.com'
    fill_in 'Password', with: 'newpassword'
    fill_in 'Password confirmation', with: 'newpassword'
    click_on 'Sign up'

    expect(page).to have_content 'You have signed up successfully'
  end

  scenario 'Registered user try to sign in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Unregistered user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'fake@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path
  end

  scenario 'User can sign out' do
    sign_in(user)
    visit root_path
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully'
  end
end