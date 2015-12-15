FactoryGirl.define do

  factory :answer do
    title
    body
    question
    user
  end

  factory :invalid_answer, class: Answer do
    title nil
    body nil
  end
end
