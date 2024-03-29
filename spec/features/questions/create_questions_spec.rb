require_relative '../feature_helper'

feature 'Create questions', %q{
        In order to receive answer from community
        As an authenticated user
        I want to be able to ask question
        } do

  given(:user) { create(:user) }

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test body text'
    click_on 'Create question'

    expect(page).to have_content 'Your question successfully created.'
    expect(page).to have_content 'Test question'
    expect(page).to have_content 'Test body text'
  end

  scenario 'Unauthenticated user creates question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end
end