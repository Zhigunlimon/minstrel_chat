require_relative '../feature_helper'

feature 'Best answer', %q{
        In order to specify best answer for community
        As an authenticated user and question author
        I want to be able to mark answer as best for question
        } do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) {create(:answer, question: question) }
  given!(:best_answer) {create(:answer, question: question) }

  describe 'Authenticated question author' do
    before() do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'sees best answer link' do
      expect(page).to have_content 'Best answer'
    end

    scenario 'assign best answer', js: true do
      within "#answer-#{best_answer.id}" do
        click_on 'Best answer'
      end

      expect(page).to have_selector ".best-answer#answer-#{best_answer.id}"
    end

    scenario 'change best answer', js: true do
      within "#answer-#{answer.id}" do
        click_on 'Best answer'
      end
      within "#answer-#{best_answer.id}" do
        click_on 'Best answer'
      end

      expect(page).to have_selector ".best-answer#answer-#{best_answer.id}"
      expect(page).to_not have_selector ".best-answer#answer-#{answer.id}"
    end

    scenario 'cancel best answer assignment', js: true do
      within "#answer-#{best_answer.id}" do
        click_on 'Best answer'
        click_on 'Best answer'
      end
      expect(page).to_not have_selector '.best-answer'
    end
  end

  describe 'Authenticated user (not question author)' do
    before() do
      sign_in(another_user)
      visit question_path(question)
    end

    scenario 'not sees best answer link' do
      expect(page).to_not have_content 'Best answer'
    end
  end

  describe 'Unauthenticated user' do
    scenario 'not sees best answer link' do
      visit question_path(question)

      expect(page).to_not have_content 'Best answer'
    end
  end
end