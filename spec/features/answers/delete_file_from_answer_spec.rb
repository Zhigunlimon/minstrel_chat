require_relative '../feature_helper'

feature 'Delete files from answer', %q{
        In order to remove attached files from answer
        As an answer's author
        I want to be able to delete attached files
        } do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer, question: question, user: user) }
  given(:foreign_answer) { create(:answer, question: question) }
  given!(:attachment) { create(:attachment, attachable: answer) }
  given!(:attachment_2) { create(:attachment, attachable: answer) }
  given!(:attachment_3) { create(:attachment, attachable: foreign_answer) }

  context  'Authenticated user' do
    scenario 'User delete file from his answer', js: true do
      sign_in(user)
      visit question_path(question)
      within "#attachment-#{attachment.id}" do
        expect(page).to have_link 'delete file'
        click_link 'delete file'
      end
      expect(page).to_not have_selector "#attachment-#{attachment.id}"
      expect(page).to have_selector "#attachment-#{attachment_2.id}"
    end

    scenario 'User try to delete file from not his answer', js: true do
      sign_in(user)
      visit question_path(question)
      within "#answer-#{foreign_answer.id}" do
        expect(page).to have_link attachment_3.file.identifier
        expect(page).to_not have_link 'delete file'
      end
    end
  end

  context 'Non authenticated user' do
    scenario 'Do not sees link of file delete', js: true do
      visit question_path(question)

      expect(page).to have_link  attachment.file.identifier
      expect(page).to_not have_link 'delete file'
    end
  end
end