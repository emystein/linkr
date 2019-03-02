namespace :db do
  desc "Drop, create, migrate, and repopulate with sample data"
  task repopulate: [:reset, :migrate, :sample_data] do
    puts "Done"
  end

  desc "Sample Data"
  task sample_data: :environment do
    #  user = User.create(id: 0, nickname: "emystein", email: "emystein@gmail.com")
    #  user.save
     User.create!({:nickname => "emystein", :email => "emystein@gmail.com", :password => "emystein", :password_confirmation => "emystein" })

     User.all.each do |user|
      puts "Creating bookmarks for user #{user.id} of #{User.last.id}"
      50.times do |n|
        user.bookmarks.create!(url: "URL #{n}", title: "Title #{n}")
      end
     end

     puts "Populated sample data"
  end
end
