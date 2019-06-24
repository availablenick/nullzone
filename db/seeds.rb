# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

adm = Usuario.create(login: 'ADM', password: 'senha')
user = Usuario.create(login: 'User', password: 'senha')

t1 = Topico.create(titulo: '1', mensagem: '0', video: nil, usuario_id: adm.id)
10.times do |n|
  Topico.create(titulo: "#{n+2}", mensagem: '0', video: nil, usuario_id: adm.id)
end

101.times do |n|
  if n % 2 == 0
    id = adm.id
  else
    id = user.id
  end

  Post.create(mensagem: "#{n+1}", usuario_id: id, topico_id: t1.id)
end
