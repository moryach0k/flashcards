FactoryGirl.define do

  factory :card do
    original_text "Water"
    translated_text "Вода"
    review_date Date.today

    after(:create) do |card|
      card.update_attributes(review_date: Date.today - 3)
    end
  end

end