require_relative '../feature_helper'

feature 'Edit answers', %q{
        In order to change given answers
        As an author of answer
        I want to be able to edit my answer
        } do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) {create(:answer, question: question, user: user) }

  describe 'Authenticated author' do
    before() do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'sees answer edit link' do
      expect(page).to have_content 'Edit answer'
    end

    scenario 'try to edit his answer', js: true do
      click_on 'Edit answer'
      within '.answers' do
        fill_in 'Your answer', with: 'edited answer body'
        click_on 'Update'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer body'
        expect(page).to_not have_selector 'textarea'
      end
    end
  end
  scenario 'Authenticated user try to edit not his answer' do
    sign_in(another_user)
    visit question_path(question)

    expect(page).to_not have_content 'Edit answer'
  end


  scenario 'Unauthenticated user try to edit answer' do
    visit question_path(question)

    expect(page).to_not have_content 'Edit answer'
  end
end