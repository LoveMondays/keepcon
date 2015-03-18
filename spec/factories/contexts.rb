FactoryGirl.define do
  factory :context, class: Keepcon::Context do
    name
    password

    initialize_with { new(attributes) }
  end
end
