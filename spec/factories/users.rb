FactoryBot.define do
  factory :user do
    email { "user@email.com" }
    password { "password" }
    password_confiration { "password" }
  end
end
