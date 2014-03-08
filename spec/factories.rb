FactoryGirl.define do
  factory :service do
    sequence(:name) { |n| "Service #{n}" }
  end

  factory :project do
    sequence(:name) { |n| "Project #{n}" }
  end

  factory :user do
    sequence(:name) { |n| "user#{n}" }
    password "password"
    password_confirmation { |u| u.password }
    admin false
    association :organization

    factory :admin do
      admin true
    end
  end

  factory :organization do
    sequence(:name) { |n| "Organization ##{n}" }
  end

  factory :status do
    name SecureRandom.hex
  end

  factory :event do
    association :status
    message "explaining"
  end
end
