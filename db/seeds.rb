# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

adm = User.create(login: 'ADM', password: 'senha', signature: 'EU Q MANDO')
user = User.create(login: 'User', password: 'senha')

off_topic = Section.create(name: 'Área geral', description: 'Local [único] para discussão de assuntos diversos.')

(1..10).each do |n|
  Topic.create(title: "#{n}", message: '0', user_id: adm.id, section_id: off_topic.id)
end 

t11 = Topic.create(title: '11', message: '0', user_id: adm.id, section_id: off_topic.id)
(1..100).each do |n|
  if n % 2 == 0
    id = adm.id
  else
    id = user.id
  end

  Post.create(message: "#{n+1}", user_id: id, topic_id: t11.id)
end
