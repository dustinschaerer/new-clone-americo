FactoryGirl.define do
  factory :admin_user do
    email "ken@americo-inc.com"
    encrypted_password 'secretpassword'
    password 'kenpassword'
  end

end
