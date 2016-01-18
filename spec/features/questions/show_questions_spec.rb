require_relative '../feature_helper'

feature 'Show questions', %q{
        In order to look at questions
        As an authenticated user or visitor
        I want to be able to look through questions list
        } do

  given(:user) { create(:user) }
  given(:question1) { create(:question) }
  given(:question2) { create(:question, user: user) }


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
end