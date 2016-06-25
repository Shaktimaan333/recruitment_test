User.create!(name: "Example User", email: "example@railstutorial.org", mobileno: "1234567890", password: "foobar", password_confirmation: "foobar", admin: true, freq: 0, count: 0, under_test: 0, exam_id: 0, redi: 0)
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  mobileno = "1234567890"
  password = "foobar"
  User.create!(name: name, email: email, mobileno: mobileno, password: password, password_confirmation: password, freq: 0, count: 0, under_test: 0, exam_id: 0, redi: 0)
end
300.times do |n|
  question = Faker::Lorem.sentence
  one = Faker::Lorem.word
  two = Faker::Lorem.word
  three = Faker::Lorem.word
  four = Faker::Lorem.word
  category_id = Faker::Number.between(1,8)
  diff = Faker::Number.between(1,5)
  correct = Faker::Number.between(1,4).to_s
  Que.create!(question: question, category_id: category_id, one: one, two: two, three: three, four: four, correct: correct, diff: diff, correct_attempt: 0, no_attempt: 0, wrong_attempt: 0)
end
150.times do |n|
  question = Faker::Lorem.sentence
  one = Faker::Lorem.word
  two = Faker::Lorem.word
  three = Faker::Lorem.word
  four = Faker::Lorem.word
  category_id = Faker::Number.between(1,8)
  diff = Faker::Number.between(1,5)
  correct = (Faker::Number.between(1,4) + (Faker::Number.between(1,4)*10)).to_s
  Que.create!(question: question, category_id: category_id, one: one, two: two, three: three, four: four, correct: correct, diff: diff, correct_attempt: 0, no_attempt: 0, wrong_attempt: 0)
end
150.times do |n|
  question = Faker::Lorem.sentence
  one = Faker::Lorem.word
  two = Faker::Lorem.word
  three = Faker::Lorem.word
  four = Faker::Lorem.word
  category_id = Faker::Number.between(1,8)
  diff = Faker::Number.between(1,5)
  correct = (Faker::Number.between(1,4) + (Faker::Number.between(1,4)*10) + (Faker::Number.between(1,4)*100)).to_s
  Que.create!(question: question, category_id: category_id, one: one, two: two, three: three, four: four, correct: correct, diff: diff, correct_attempt: 0, no_attempt: 0, wrong_attempt: 0)
end
150.times do |n|
  question = Faker::Lorem.sentence
  one = Faker::Lorem.word
  two = Faker::Lorem.word
  three = Faker::Lorem.word
  four = Faker::Lorem.word
  category_id = Faker::Number.between(1,8)
  diff = Faker::Number.between(1,5)
  correct = (Faker::Number.between(1,4) + (Faker::Number.between(1,4)*10) + (Faker::Number.between(1,4)*100) + (Faker::Number.between(1,4)*1000)).to_s
  Que.create!(question: question, category_id: category_id, one: one, two: two, three: three, four: four, correct: correct, diff: diff, correct_attempt: 0, no_attempt: 0, wrong_attempt: 0)
end
8.times do |n|
  name = Faker::Lorem.word
  Category.create(name: name)
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
