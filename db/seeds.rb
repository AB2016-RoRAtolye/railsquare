# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Venue.find_or_create_by(name: "Rıfat Bey Konağı", address: "Hasan efendi mh.1905 sok no:10 Aydın")
Venue.find_or_create_by(name: "Akbayoğlu Lokantasi", address: "güzel hisar .mah 7 eylül cad no,113 Aydın")
Venue.find_or_create_by(name: "Yenipazarlı Kazım Usta", address: "Güzelhisar Mahallesi 39. Sokak 11/A Aydın")
Venue.find_or_create_by(name: "Şehir Kebap Salonu Rüştü'nün Yeri", address: "Veyispaşa Mah. 1604 Sok. No:10/4 Aydın")