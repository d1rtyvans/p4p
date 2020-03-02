puts 'Beginning seed of DB...'
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
  },
  {
    uid: 'mammoth',
    name: 'Mammoth Mountain',
    lat: 37.6308,
    lon: -119.0326,
  }
]

# Find existing ones, create new ones that aren't found
puts 'Seeding Resorts...'
uids             = SEED_RESORTS.map { |resort| resort[:uid] }
existing_resorts = Resort.where(uid: uids).pluck(:uid)

puts "\t#{existing_resorts.size} resort(s) already exist..."

new_resorts = SEED_RESORTS.reject do |resort|
  existing_resorts.include?(resort[:uid])
end

puts "\tCreating #{new_resorts.size} new resort(s) in DB..."
Resort.create!(new_resorts)
puts "\tDone."

# Seed users
SEED_USERS = [
  {
    email: 'hi@shred.gov',
    resorts: %w[sierra kwood jhole],
  }
]

puts 'Seeding Users...'
puts "\tFinding or creating #{SEED_USERS.size} user(s)..."
User.transaction do
  SEED_USERS.each do |user_data|
    puts "\t\tCreating user with email: #{user_data[:email]}..."
    user    = User.find_or_create_by!(email: user_data[:email])
    resorts = Resort.where(uid: user_data[:resorts])

    puts "\t\tCreating favorites for #{resorts.size} resort(s)..."
    user.update!(resorts: resorts)
  end
end

puts "\tDone."
puts 'Done.'
