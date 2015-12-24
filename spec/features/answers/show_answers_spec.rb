require_relative '../feature_helper'

feature 'Show answers', %q{
        In order to look at questions answers
        As an authenticated user or visitor
        I want to be able to look through questions answers
        } do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question, user: user) }

  scenario 'User look at question answers' do
    answer
    visit question_path(question)

    expect(page).to have_content answer.body
  end
end