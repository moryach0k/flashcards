FactoryGirl.define do
  factory :user do
    email "user@email.com"
    password "qwerty"
    password_confirmation "qwerty"
  end
end
