# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

adm = Usuario.create(login: 'ADM', password: 'senha')
user = Usuario.create(login: 'User', password: 'senha')

t1 = Topico.create(titulo: 'teste1', mensagem: 'msg1', usuario_id: adm.id)
t2 = Topico.create(titulo: 'teste2', mensagem: 'msg2', usuario_id: adm.id)
t3 = Topico.create(titulo: 'teste3', mensagem: 'msg3', usuario_id: adm.id)
t4 = Topico.create(titulo: 'teste4', mensagem: 'msg4', usuario_id: adm.id)
t5 = Topico.create(titulo: 'teste5', mensagem: 'msg5', usuario_id: adm.id)
t6 = Topico.create(titulo: 'teste6', mensagem: 'msg6', usuario_id: adm.id)
t7 = Topico.create(titulo: 'teste7', mensagem: 'msg7', usuario_id: adm.id)
t8 = Topico.create(titulo: 'teste8', mensagem: 'msg8', usuario_id: adm.id)
t9 = Topico.create(titulo: 'teste9', mensagem: 'msg9', usuario_id: adm.id)
t10 = Topico.create(titulo: 'teste10', mensagem: 'msg10', usuario_id: adm.id)
t11 = Topico.create(titulo: 'teste11', mensagem: 'msg11', usuario_id: adm.id)

t1_post1 = Post.create(mensagem: '1', usuario_id: adm.id, topico_id: t1.id)
t1_post2 = Post.create(mensagem: '2', usuario_id: adm.id, topico_id: t1.id)
t1_post3 = Post.create(mensagem: '3', usuario_id: user.id, topico_id: t1.id)
t1_post4 = Post.create(mensagem: '4', usuario_id: user.id, topico_id: t1.id)
t1_post5 = Post.create(mensagem: '5', usuario_id: adm.id, topico_id: t1.id)
t1_post6 = Post.create(mensagem: '6', usuario_id: adm.id, topico_id: t1.id)
t1_post7 = Post.create(mensagem: '7', usuario_id: adm.id, topico_id: t1.id)
t1_post8 = Post.create(mensagem: '8', usuario_id: adm.id, topico_id: t1.id)
t1_post9 = Post.create(mensagem: '9', usuario_id: adm.id, topico_id: t1.id)
t1_post10 = Post.create(mensagem: '10', usuario_id: adm.id, topico_id: t1.id)
t1_post11 = Post.create(mensagem: '11', usuario_id: adm.id, topico_id: t1.id)
