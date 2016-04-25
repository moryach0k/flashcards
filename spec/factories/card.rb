FactoryGirl.define do
  factory :card do
    original_text "Water"
    translated_text "Вода"
    review_date Time.current
    review_stage 1
    wrong_attempts 0

    after(:create) do |card|
      card.update_attributes(review_date: Date.today - 3)
    end
  end
end