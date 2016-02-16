require_relative '../feature_helper'

feature 'Vote for question', %q{
        In order to give vote for question
        As an authenticated user and not question author
        I want to be able to vote for question
        } do

  given(:user) { create(:user) }
  given(:question_author) { create(:user) }
  given!(:question) { create(:question, user: question_author) }
  given(:positive_vote) { create(:vote_question, :positive, question: question, user: user) }
  given(:negative_vote) { create(:vote_question, :negative, question: question, user: user) }

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'sees vote block' do
      expect(page).to have_selector '.vote_block'
    end

    scenario 'voting positive' do#, js: true do
      within '.vote_block' do
        click_on 'Like'

        expect(page).to have_content 'Rate 1'
      end
    end

    scenario 'voting negative' do#, js: true do
      within '.vote_block' do
        click_on 'Dislike'

        expect(page).to have_content 'Rate -1'
      end
    end

    scenario 'cancel his vote' do #, js: true do
      positive_vote
      within '.vote_block' do
        expect(page).to have_content 'Rate 1'
        click_on 'Like'

        expect(page).to have_content 'Rate 0'
      end
    end

    scenario 'change vote from positive to negative'
    scenario 'change vote from negative to positive'

  end

  describe 'Authenticated question author' do
    before do
      sign_in(question_author)
      visit question_path(question)
    end

    scenario 'not sees votes block' do
      expect(page).to_not have_selector '.vote_block'
    end
  end

  describe 'Unauthenticated user' do
    scenario 'not sees votes block' do
      visit question_path(question)

      expect(page).to_not have_selector '.vote_block'
    end
  end

  describe 'Authenticated question author' do

  end
end