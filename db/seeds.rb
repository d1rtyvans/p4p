puts 'Beginning seed of DB...'
puts 'Seeding Resorts...'
# Seed with a few resorts in diff areas
SEED_RESORTS = [
  {
    uid:  'sierra',
    name: 'Sierra At Tahoe',
    lat:  38.8009,
    lon:  -120.0809,
  },
  {
    uid:  'kwood',
    name: 'Kirkwood',
    lat:  38.6848,
    lon:  -120.0652,
  },
  {
    uid:  'jhole',
    name: 'Jackson Hole',
    lat:  43.4799,
    lon: -110.7624,
  },
  {
    uid:  'alta',
    name: 'Alta',
    lat:  40.5884,
    lon:  -111.6386,
  },
  {
    uid:  'whistler',
    name: 'Whistler Blackomb',
    lat:  50.108333,
    lon:  -122.9425,
  }
]


# Find existing ones, create new ones that aren't found
uids             = SEED_RESORTS.map { |resort| resort[:uid] }
existing_resorts = Resort.where(uid: uids).pluck(:uid)

puts "\t#{existing_resorts.size} resort(s) already exist..."

new_resorts = SEED_RESORTS.reject do |resort|
  existing_resorts.include?(resort[:uid])
end

puts "\tCreating #{new_resorts.size} new resort(s) in DB..."
Resort.create!(new_resorts)

puts 'Done.'
