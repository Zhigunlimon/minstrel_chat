require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { create(:question) }
  let(:different_question) { create(:question) }
  # let!(:answer) { create(:answer, question: question) }
  let!(:best_answer) { create(:answer, question: question, best_answer: true) }
  let!(:different_answer) { create(:answer, question: question) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }
  it { should have_many(:answers).dependent(:delete_all) }
  it { should belong_to(:user) }
  it { should have_many(:attachments) }
  it { should accept_nested_attributes_for :attachments }

  describe 'best_answer' do
    it 'returns best answer for question if it exists' do
      expect(question.best_answer).to eq best_answer
    end
    it 'returns nil if best answer for question not exists' do
      expect(different_question.best_answer).to eq nil
    end
  end

  describe 'best_answer=' do
    it 'set best answer if no best answer was before' do
      best_answer.update_attribute(:best_answer, false)
      best_answer.reload
      question.best_answer = best_answer

      expect(question.best_answer).to eq best_answer
    end
    it 'set best answer if different best answer received' do
      question.best_answer = different_answer

      expect(question.best_answer).to eq different_answer
    end

    it 'set best answer to nil if same best answer received' do
      question.best_answer = best_answer

      expect(question.best_answer).to eq nil
    end
  end
end
