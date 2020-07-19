adm = User.create(login: 'ADM', password: 'password', password_confirmation: 'password', signature: 'EU Q MANDO')
users = []
users.push(adm)
(1..20).each do |i|
  users.push(User.create(login: "User#{i}", password: 'password', password_confirmation: 'password'))
end

off_topic = Section.create(name: 'Section1', description: 'Section1\'s description.')
Section.create(name: 'Section2', description: 'Section2\'s description.')

(1..10).each do |n|
  Topic.create(title: "#{n}", message: '0', parsed_message: '0', user_id: adm.id, section_id: off_topic.id)
end 

t11 = Topic.create(title: '11', message: '0', parsed_message: '0', user_id: adm.id, section_id: off_topic.id)
(1..100).each do |n|
  id = users[n % users.length].id
  Post.create(message: "#{n+1}", parsed_message: "#{n+1}", user_id: id, topic_id: t11.id)
end
