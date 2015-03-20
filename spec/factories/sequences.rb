FactoryGirl.define do
  sequence :name do |n|
    "name_#{n}"
  end

  sequence :password do |n|
    "password_#{n}"
  end
end
