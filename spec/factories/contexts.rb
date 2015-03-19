FactoryGirl.define do
  factory :context, class: Keepcon::Context do
    user
    password

    initialize_with { new(attributes) }
  end
end
