FactoryGirl.define do
  sequence :title do |n|
    "Title_#{n}"
  end

  sequence :body do |n|
    "Body_#{n}"
  end

  factory :question do
    title
    body
    user
  end

  factory :invalid_question, class: Question do
    title nil
    body nil
  end
end
