require 'rails_helper'

feature 'Questions', %q{
        In order to look at questions and receive answer from community
        As an authenticated user or visitor
        I want to be able to look through questions list and ask question
        } do

  given(:user) { create(:user) }
  given(:question1) { create(:question) }
  given(:question2) { create(:question) }
  given(:question3) { create(:question, user: user) }


  scenario 'Visitor looks at questions list' do
    question1
    question2
    visit questions_path

    expect(page).to have_content question1.title
    expect(page).to have_content question2.title
  end

  scenario 'Visitor looks at question' do
    question1
    visit questions_path
    click_on 'Show question'


    expect(page).to have_content question1.title
    expect(page).to have_content question1.body
  end

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test body text'
    click_on 'Create question'

    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Unauthenticated user creates question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  scenario 'User try to delete his question' do
    sign_in(user)

    question3
    visit questions_path
    click_on 'Show question'
    click_on 'Delete question'

    expect(page).to have_content 'Your question was successfully deleted.'
  end

  scenario 'User try to delete not his question' do
    sign_in(user)

    question1
    visit questions_path
    click_on 'Show question'
    click_on 'Delete question'

    expect(page).to have_content 'Your question was not deleted.'
  end
end