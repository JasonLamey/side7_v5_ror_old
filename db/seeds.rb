require 'open-uri'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed user_types
["Basic", "Premiere", "Ultimate"].each do |type|
  UserType.find_or_create_by_user_type type
end

# Seed user_statuses
["Pending", "Active", "Suspended", "Disabled"].each do |status|
  UserStatus.find_or_create_by_user_status status
end

# Seed countries
Country.delete_all
open("http://openconcept.ca/sites/openconcept.ca/files/country_code_drupal_0.txt") do |countries|
  countries.read.each_line do |country|
    code, name = country.chomp.split("|")
    Country.create!(:name => name, :code => code)
  end
end

# Seed date_visibilities
["Full", "Hide Year", "Hidden"].each do |date_vis|
  DateVisibility.find_or_create_by_visibility date_vis
end

