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
end
