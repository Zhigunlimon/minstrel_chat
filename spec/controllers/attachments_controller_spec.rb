require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:question) { create(:question, user: @user) }
  let(:attachment) { create(:attachment, attachable: question) }
  let(:foreign_question) { create(:question) }
  let(:foreign_attachment) { create(:attachment, attachable: foreign_question) }

  describe 'DELETE #destroy' do
    context 'Not authenticated user' do
      it 'try  delete file from question' do
        foreign_attachment
        expect { delete :destroy, id: attachment, format: :js }.to_not change(Attachment, :count)
      end
    end

    sign_in_user
    context 'Authenticated user' do
      it 'try deletes file from not his question' do
        foreign_attachment
        expect { delete :destroy, id: foreign_attachment, format: :js }.to_not change(Attachment, :count)
      end
      it 'deletes file from his question' do
        attachment
        expect { delete :destroy, id: attachment, format: :js }.to change(Attachment, :count).by -1
      end
      it 'render destroy view' do
        delete :destroy, id: attachment, format: :js
        expect(response).to render_template :destroy
      end
    end
  end
end