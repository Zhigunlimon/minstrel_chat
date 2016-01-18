require_relative '../feature_helper'

feature 'Delete answers', %q{
        In order to remove answers
        As an authenticated user
        I want to be able to delete answers
        } do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  describe 'Authenticated user' do
    scenario 'sees answer delete link' do
      sign_in(user)
      visit question_path(question)

      expect(page).to have_content 'Delete answer'
    end

    scenario 'try to delete his answer', js: true do
      sign_in(user)
      visit question_path(question)

      click_on 'Delete answer'

      expect(page).to_not have_content answer.body
    end

    scenario 'try to delete not his answer' do
      sign_in(another_user)
      visit question_path(question)

      expect(page).to_not have_content 'Delete answer'
    end
  end
end