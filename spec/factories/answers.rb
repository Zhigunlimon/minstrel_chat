FactoryGirl.define do
  factory :answer do
    title "MyString"
    body "MyText"
    question
  end

  factory :invalid_answer, class: Answer do
    title nil
    body nil
  end
end
