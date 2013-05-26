namespace :csv do

  desc "Import CSV Data"
  task :import => :environment do

    require 'csv'

    csv_file_path = '/home/amitk/Documents/bangalore_v2_books.csv'

    CSV.foreach(csv_file_path, headers: true) do |row|
      row = Book.create!({
        :title => row[0],
        :author => row[1],
        :purchased_at => row[2],
      })
      puts "Success!"
    end
  end
end


