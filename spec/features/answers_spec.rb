require 'rails_helper'

feature 'Answers', %q{
        In order to look at questions answers and give answers for community
        As an authenticated user or visitor
        I want to be able to look through questions answers list and answer questions
        } do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question, user: user) }
  given(:answer2) { create(:answer, question: question) }

  scenario 'Authenticated user answers question' do
    sign_in(user)

    visit question_path(question)
    click_on 'Answer question'
    fill_in 'Title', with: 'New Answer title'
    fill_in 'Body', with: 'New Answer body'
    click_on 'Create answer'

    expect(page).to have_content 'Your answer successfully created.'
    expect(page).to have_content 'New Answer title'
    expect(page).to have_content 'New Answer body'
  end

  scenario 'Unauthenticated user answers question' do
    visit question_path(question)
    click_on 'Answer question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
  scenario 'User look at question answers' do
    question.answers.create!(title: 'Title1', body: 'Body1', user: user)
    visit question_path(question)

    expect(page).to have_content 'Title1'
    expect(page).to have_content 'Body1'
  end

  scenario 'User try to delete his answer' do
    sign_in(user)

    answer
    visit question_path(question)
    click_on 'Delete answer'
    save_and_open_page

    expect(page).to have_content 'Your answer was successfully deleted.'
    expect(page).to_not have_content answer.title
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