require_relative '../feature_helper'

feature 'Delete questions', %q{
        In order to remove my questions
        As an authenticated user
        I want to be able to delete questions
        } do

  given(:user) { create(:user) }
  given(:question1) { create(:question, user: user) }
  given(:question2) { create(:question) }

  scenario 'User try to delete his question' do
    sign_in(user)

    question1
    visit questions_path
    click_on 'Show question'
    click_on 'Delete question'

    expect(page).to have_content 'Your question was successfully deleted.'
  end

  scenario 'User try to delete not his question' do
    sign_in(user)

    question2
    visit questions_path
    click_on 'Show question'

    expect(page).to_not have_content 'Delete question'
  end
end