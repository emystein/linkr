RSpec.configure do |config|
	config.before(:suite) do
	  DatabaseCleaner.clean_with(:truncation, :except => %w[tag_count_by_dates])
	end
  
	config.before(:each) do
	  DatabaseCleaner.strategy = :transaction
	end
  
	# config.before(:each, :js => true) do
	#   DatabaseCleaner.strategy = :truncation
	# end
  
	config.before(:each) do
	  DatabaseCleaner.start
	end
  
	config.after(:each) do
	  DatabaseCleaner.clean
	end
end