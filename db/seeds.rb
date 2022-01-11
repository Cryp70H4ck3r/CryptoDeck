# Create a main sample user.
User.create!(first_name:  "Crypto",
             middle_name: "Bio",
             last_name: "Hacker",
             username: "Cryp70 H4ck3r",
             bio: "Ethical Hacker, Ruby on Rails Coder, Nerd!",
             phone: "469-307-2579",
             email: "cryp70_h4ck3r@crypto-deck.com",
             location: "Planet Earth, Milky Way Galaxy",
             job_title: "Lead Developer",
             job_duties: "Create and Develop CryptoDeck",
             company_name: "CryptoDeck",
             college_degree: "Doctoral of Computer Science",
             college_name: "Ashley University",
             eth_adr: "0x18A2Dbb76Ff69e0Cb402aa3d564b8f647e42285f",
             btc_adr: "bc1qml9clwsw3a7l0uu9mg4x4tytd2qnd6yp5js9px",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

# Generate a bunch of additional users.
99.times do |n|
  first_name  = Faker::Name.first_name
  middle_name = Faker::Name.middle_name
  last_name = Faker::Name.last_name
  username = Faker::Name.unique.name
  location = Faker::Address.full_address
  phone = Faker::PhoneNumber.cell_phone
  bio = Faker::Movies::StarWars.quote
  job_title = Faker::Job.title
  job_duties = Faker::Job.field
  company_name = Faker::Company.name
  college_degree = Faker::Job.education_level
  college_name = Faker::Educator.university
  eth_adr = Faker::Crypto.sha256
  btc_adr = Faker::Crypto.sha256
  email = "user-#{n+1}@crypto-deck.com"
  password = "password"
  User.create!(first_name:  first_name,
               middle_name: middle_name,
               last_name: last_name,
               username: username,
               bio: bio,
               phone: phone,
               email: email,
               location: location,
               job_title: job_title,
               job_duties: job_duties,
               company_name: company_name,
               college_name: college_name,
               college_degree: college_degree,
               eth_adr: eth_adr,
               btc_adr: btc_adr,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end
