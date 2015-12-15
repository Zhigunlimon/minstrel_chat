require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question, user: @user) }

  describe 'GET #new' do
    sign_in_user
    before {get :new, question_id: question}

    it 'build new answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user

    context 'successful creation' do
      it 'creates new answer' do
        expect {
          post :create, question_id: question, answer: attributes_for(:answer)
        }.to change(question.answers, :count).by(1)
      end

      it 'new answer belongs to current user' do
        expect {
          post :create, question_id: question, answer: attributes_for(:answer)
        }.to change(@user.answers, :count).by(1)
      end

      it 'redirect to question show view' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'unsuccessful creation' do
      it 'do not creates new answer' do
        expect {
          post :create, question_id: question, answer: attributes_for(:invalid_answer)
        }.to_not change(Answer, :count)
      end

      it 'render to new view' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer)
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:answer) { create(:answer, question: question, user: @user) }
    let!(:foreign_answer) { create(:answer, question: question) }

    context 'successful destroy' do
      it 'deletes answer' do
        expect {
          delete :destroy, question_id: question, id: answer
        }.to change(question.answers, :count).by(-1)
      end

      it 'redirect to show question view' do
        delete :destroy, question_id: question, id: answer
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'unsuccessful destroy' do
      it 'do not deletes answer' do
        expect {
          delete :destroy, question_id: question, id: foreign_answer
        }.to_not change(Answer, :count)
      end

      it 'redirect to show question view' do
        delete :destroy, question_id: question, id: foreign_answer
        expect(response).to redirect_to question_path(question)
      end
    end
  end
end