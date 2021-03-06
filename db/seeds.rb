store = Store.create(name: 'Dtronics')
user = User.new(
    first_name: 'Dominic',
    last_name: 'Nunes',
    email: 'dominic.n@me.com',
    password: 'password',
    password_confirmation: 'password',
)
user.confirmed_at = Time.now
user.save!
store.update(user_id: user.id)

(2...100).each do |i|
  store = Store.create(name: Faker::Company.name)
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "user#{i + 1}@mail.com",
    password: 'password',
    password_confirmation: 'password',
  )
  user.confirmed_at = Time.now
  user.save!
  store.update(user_id: user.id)
end
Product.destroy_all
(1...300).each do |i|
  product = Product.new(
    title: Faker::Commerce.product_name,
    tagline: Faker::HarryPotter.quote,
    body: Faker::Hipster.paragraph(2, true),
    price: rand(100),
    quantity: rand(1...20),
    category: Faker::Commerce.department(1),
    store_id: rand(1..10),
  )
  (1..(rand(3..5))).each do
    image = product.images.new
    filename = "#{rand(20)}.png"
    attachment = File.open(File.join(Rails.root,
                                                    'app', 'assets', 'images', 'kits', filename))
    image.attachment.attach(io: attachment, filename: filename)
  end
  product.save!
  p product
end

Product.all.each do |product|
  tutorial = product.create_tutorial
  (3..(rand(4..7))).each do
    tutorial.steps.new
  end
  tutorial.steps.each_with_index do |step, index|
    step.number = index + 1
    step.title = Faker::Hipster.sentence
    step.body = Faker::Hipster.paragraph(1, true)

    image = step.images.new
    filename = "#{rand(20)}.png"
    attachment = File.open(File.join(Rails.root,
                                     'app', 'assets', 'images', 'kits', filename))
    image.attachment.attach(io: attachment, filename: filename)
    step.save!
  end
  tutorial.save
end
