FactoryGirl.define do
  factory :service do
    sequence(:name) { |n| "Service #{n}" }
  end

  factory :project do
    sequence(:name) { |n| "Project #{n}" }
  end
end
