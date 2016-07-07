User.create!(name: "Example User", email: "example@railstutorial.org", mobileno: "1234567890", password: "foobar", password_confirmation: "foobar", admin: true, freq: 0, count: 0, under_test: 0, exam_id: 0, redi: 0, activated: true, activated_at: Time.zone.now)
AdminUser.create!(email: 'admin@example.com', password: 'wrig2015', password_confirmation: 'wrig2015')
500.times do |n|
  question = Faker::Lorem.sentence
  one = Faker::Lorem.word
  two = Faker::Lorem.word
  three = Faker::Lorem.word
  four = Faker::Lorem.word
  diff = Faker::Number.between(0,5)
  category_id = Faker::Number.between(1,4)
  correct = Faker::Number.between(1,4).to_s
  Que.create!(question: question, category_id: category_id, one: one, two: two, three: three, four: four, correct: correct, diff: diff, correct_attempt: 0, no_attempt: 0, wrong_attempt: 0)
end
4.times do |n|
  name = Faker::Lorem.word
  exam_id = 1
  Category.create!(name: name, exam_id: exam_id)
end
Exam.create!(topic: "Maths")