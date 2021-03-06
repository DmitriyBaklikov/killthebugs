FactoryGirl.define do
  sequence :email do |n|
    "test#{n}@test.com"
  end

  sequence :title do |n|
    "code snippet #{n}"
  end

  factory :user do
    email
    password "123123"
    password_confirmation "123123"
  end

  factory :fragment do
    association :author, factory: :user
    code "puts 'Hello world'"
    language "ruby"
    title
  end
end
