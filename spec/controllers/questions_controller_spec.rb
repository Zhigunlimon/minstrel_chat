require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe 'GET #index' do
    let(:questions) {create_list(:question, 2)}
    before do
      get :index
    end
    it 'fill array of questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render #index view' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:question) { create(:question) }

    before do
      get :show, id: question
    end

    it 'find question to show' do
      expect(assigns(:question)).to eq question
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user

    before {get :new}

    it 'build new question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user

    context 'successful creation' do
      it 'creates new question' do
        expect {
          post :create, question: attributes_for(:question, user: @user)
        }.to change(@user.questions, :count).by(1)
      end

      it 'redirect to show view' do
        post :create, question: attributes_for(:question, user: @user)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'unsuccessful creation' do
      it 'do not creates new question' do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 'render to new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:question) { create(:question, user: @user) }
    let!(:foreign_question) { create(:question) }

    context 'successful destroy' do
      it 'deletes question' do
        expect { delete :destroy, id: question }.to change(@user.questions, :count).by(-1)
      end
      it 'redirect to question index view' do
        delete :destroy, id: question
        expect(response).to redirect_to questions_path
      end
    end
    context 'unsuccessful destroy' do
      it 'do not deletes question' do
        expect { delete :destroy, id: foreign_question }.to_not change(Question, :count)
      end
      it 'redirect to question index view' do
        delete :destroy, id: foreign_question
        expect(response).to redirect_to questions_path
      end
    end
  end
end