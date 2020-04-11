# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

adm = User.create(login: 'ADM', password: 'senha', password_confirmation: 'senha', signature: 'EU Q MANDO')
users = []
users.push(adm)
(1..20).each do |i|
  users.push(User.create(login: "User#{i}", password: 'senha', password_confirmation: 'senha'))
end

off_topic = Section.create(name: 'Área geral', description: 'Local [único] para discussão de assuntos diversos.')
Section.create(name: 'Bueiro', description: 'Miséria completa.')

(1..10).each do |n|
  Topic.create(title: "#{n}", message: '0', parsed_message: '0', user_id: adm.id, section_id: off_topic.id)
end 

t11 = Topic.create(title: '11', message: '0', parsed_message: '0', user_id: adm.id, section_id: off_topic.id)
(1..100).each do |n|
  id = users[n % users.length].id
  Post.create(message: "#{n+1}", parsed_message: "#{n+1}", user_id: id, topic_id: t11.id)
end
