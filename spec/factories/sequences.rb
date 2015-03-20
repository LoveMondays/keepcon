FactoryGirl.define do
  sequence :user do |n|
    "user_#{n}"
  end

  sequence :password do |n|
    "password_#{n}"
  end
end
