require 'csv'

namespace :csv_load do
  desc "Imports Invoice Item CSV file into an ActiveRecord table"
  task :invoice_items => :environment do
    InvoiceItem.destroy_all
    file = './db/data/invoice_items.csv'
    CSV.foreach(file, :headers => true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:invoice_items)
  end
end
