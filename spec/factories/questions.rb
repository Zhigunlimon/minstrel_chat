FactoryGirl.define do
  sequence :title do |n|
    "Question_#{n}"
  end

  factory :question do
    title
    body "MyText"
    user
  end

  factory :invalid_question, class: Question do
    title nil
    body nil
  end
end
