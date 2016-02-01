require_relative '../feature_helper'

feature 'Delete files from question', %q{
        In order to remove attached files from question
        As an question's author
        I want to be able to delete attached files
        } do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:foreign_question) { create(:question) }
  given!(:attachment) { create(:attachment, attachable: question) }
  given!(:attachment_2) { create(:attachment, attachable: question) }
  given!(:attachment_3) { create(:attachment, attachable: foreign_question) }

  context  'Authenticated user' do
    scenario 'User delete file from his question', js: true do
      sign_in(user)
      visit question_path(question)
      within "#attachment-#{attachment.id}" do
        expect(page).to have_link 'delete file'
        click_link 'delete file'
      end
      expect(page).to_not have_selector "#attachment-#{attachment.id}"
      expect(page).to have_selector "#attachment-#{attachment_2.id}"
    end

    scenario 'User try to delete file from not his question', js: true do
      sign_in(user)
      visit question_path(foreign_question)

      expect(page).to have_link attachment_3.file.identifier
      expect(page).to_not have_link 'delete file'
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