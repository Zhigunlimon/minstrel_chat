FactoryGirl.define do
  factory :answer do
    title "MyString"
    body "MyText"
    question_id 1
  end

  factory :invalid_answer, class: Answer do
    title nil
    body nil
    question_id nil
  end
end
