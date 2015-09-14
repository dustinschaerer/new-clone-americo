namespace :db do
  task populate_prospects: :environment do

    501.times do
      Prospect.create(
        name: FFaker::Name.name,
        email: FFaker::Internet.email,
        validated: false,
        active: true,
        created_at: Time.now,
        subscribed: true,
      )
    end

  end
end
