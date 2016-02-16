FactoryGirl.define do
  factory :vote_question, class: 'Vote' do
    user

    association :votable, factory: :question

    factory :positive_vote_question do
      value true
    end

    factory :negative_vote_question do
      value false
    end
  end

  factory :vote_answer, class: 'Vote' do
    user
    association :votable, factory: :answer
  end
end