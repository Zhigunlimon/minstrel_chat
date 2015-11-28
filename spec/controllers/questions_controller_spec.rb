require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }
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
    before {get :new}

    it 'build new question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'successful creation' do
      it 'creates new question' do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'redirect to show view' do
        post :create, question: attributes_for(:question)
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
end
