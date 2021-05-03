require "rake"

Module MigrationHelpers 
  def schema
    File.open("db/schema.rb").read
  end

  def migrate
    Rake.application["db:migrate"].invoke
    Rake.application["db:migrate"].reenable
  end

  def rollback
    Rake.application["db:rollback"].invoke
    Rake.application["db:rollback"].reenable
  end

  def load
    file, path = Rake.application.find_rakefile_location
    Rake.load_rakefile("#{path}/#{file}")
  end
end

# example specs: 
# describe "Migrations" do
#   before do 
#     load
#   end

#   it "Does not affect the commited schema file" do
#     expect{ migrate }.to not_change{ schema }
#   end

#   it "can rollback recent migraitons" do
#     3.times{ rollback }
#   end
# end