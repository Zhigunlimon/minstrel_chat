require_relative '../feature_helper'

feature 'Delete answers', %q{
        In order to remove answers
        As an authenticated user
        I want to be able to delete answers
        } do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question, user: user) }
  given(:answer2) { create(:answer, question: question) }

  scenario 'User try to delete his answer' do
    sign_in(user)

    answer
    visit question_path(question)
    click_on 'Delete answer'

    expect(page).to have_content 'Your answer was successfully deleted.'
    expect(page).to_not have_content answer.body
  end

  scenario 'User try to delete not his answer' do
    sign_in(user)

    question
    answer2
    visit question_path(question)

    expect(page).to_not have_content 'Delete answer'
  end
end