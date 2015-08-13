FactoryGirl.define do
  factory :admin_email_message, :class => 'Admin::EmailMessage' do
    subject "MyString"
headers "MyString"
content "MyText"
mandril_tags "MyString"
template "MyString"
  end

end
