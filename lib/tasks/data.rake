require 'csv'
namespace :import do
  desc 'import oceania data from csv'
  task oceania: :environment do |e| 
    counter = 0;
    CSV.foreach("oceania.csv") do |row|
      year, value, continent_id = row    
      data_p = DataPoint.create(year: year, value: value, continent_id: 1)
      counter += 1 if data_p.persisted?
    end
  puts "Imported #{counter} oceania"
  end
end

namespace :import do 
  desc 'import south america data from csv'
  task southamerica: :environment do |e|
    counter = 0;
    CSV.foreach("southamerica.csv") do |row|
      year, value, continent_id = row
      data_p = DataPoint.create(year: year, value: value, continent_id: 2)
      counter += 1 if data_p.persisted?
    end
    puts "imported #{counter} south america"
  end
end


namespace :import do 
  desc 'import north america data from csv'
  task northamerica: :environment do |e|
    counter = 0;
    CSV.foreach("northamerica.csv") do |row|
      year, value, continent_id = row
      data_p = DataPoint.create(year: year, value: value, continent_id: 3)
      counter += 1 if data_p.persisted?
    end
    puts "imported #{counter} - north america"
  end
end



namespace :import do 
  desc 'import europe  data from csv'
  task europe: :environment do |e|
    counter = 0;
    CSV.foreach("europe.csv") do |row|
      year, value, continent_id = row
      data_p = DataPoint.create(year: year, value: value, continent_id: 4)
      counter += 1 if data_p.persisted?
    end
    puts "imported #{counter} - europe"
  end
end



namespace :import do 
  desc 'import asia  data from csv'
  task asia: :environment do |e|
    counter = 0;
    CSV.foreach("asia.csv") do |row|
      year, value, continent_id = row
      data_p = DataPoint.create(year: year, value: value, continent_id: 5)
      counter += 1 if data_p.persisted?
    end
    puts "imported #{counter} data points - asia"
  end
end


namespace :import do 
  desc 'import africadata from csv'
  task africa: :environment do |e|
    counter = 0;
    CSV.foreach("africa.csv") do |row|
      year, value, continent_id = row
      data_p = DataPoint.create(year: year, value: value, continent_id: 6)
      counter += 1 if data_p.persisted?
    end
    puts "imported #{counter} data points - africa"
  end
end


namespace :import do 
  desc 'import southern hemisphere data from csv'
  task southern: :environment do |e|
    counter = 0;
    CSV.foreach("southern.csv") do |row|
      year, value, continent_id = row
      data_p = DataPoint.create(year: year, value: value, continent_id: 7)
      counter += 1 if data_p.persisted?
    end
    puts "imported #{counter} data points - southern hemisphere"
  end
end


namespace :import do 
  desc 'import northern hemisphere data from csv'
  task northern: :environment do |e|
    counter = 0;
    CSV.foreach("northern.csv") do |row|
      year, value, continent_id = row
      data_p = DataPoint.create(year: year, value: value, continent_id: 8)
      counter += 1 if data_p.persisted?
    end
    puts "imported #{counter} data points - northern hemisphere"
  end
end

namespace :import do 
  desc 'import global data from csv'
  task global: :environment do |e|
    counter = 0;
    CSV.foreach("global.csv") do |row|
      year, value, continent_id = row
      data_p = DataPoint.create(year: year, value: value, continent_id: 9)
      counter += 1 if data_p.persisted?
    end
    puts "imported #{counter} data points - global"
  end
end
