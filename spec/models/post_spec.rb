require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'é válido quando a mensagem não está em branco,
      link para vídeo está ou não em branco e topico_id e
      usuario_id estão especificados' do

    usuario = Usuario.create(login: 'login', password: 'senha')
    topico = Topico.create(titulo: 'título', mensagem: 'mensagem', usuario_id: usuario.id)
    post = Post.new(mensagem: 'post_msg', video: nil, topico_id: topico.id, usuario_id: usuario.id)
    expect(post).to be_valid
  end

  it 'é válido se possui uma mensagem que já existe' do
    usuario = Usuario.create(login: 'login', password: 'senha')
    topico = Topico.create(titulo: 'título', mensagem: 'mensagem', usuario_id: usuario.id)
    post = Post.create(mensagem: 'post_msg', video: nil, topico_id: topico.id, usuario_id: usuario.id)
    post = Post.new(mensagem: 'post_msg', video: nil, topico_id: topico.id, usuario_id: usuario.id)
    post.valid?
    expect(post.errors[:mensagem]).to_not include 'não está disponível'
  end

  it 'é inválido quando a mensagem está em branco' do
    usuario = Usuario.create(login: 'login', password: 'senha')
    topico = Topico.create(titulo: 'título', mensagem: 'mensagem', usuario_id: usuario.id)
    post = Post.new(mensagem: nil, video: nil, topico_id: topico.id, usuario_id: usuario.id)
    expect(post).to_not be_valid
  end

  it 'é inválido quando topico_id não está especificado' do
    usuario = Usuario.create(login: 'login', password: 'senha')
    post = Post.new(mensagem: 'post_msg', video: nil, topico_id: nil, usuario_id: usuario.id)
    expect(post).to_not be_valid
  end

  it 'é inválido quando usuario_id não está especificado' do
    usuario = Usuario.create(login: 'login', password: 'senha')
    topico = Topico.create(titulo: 'título', mensagem: 'mensagem', usuario_id: usuario.id)
    post = Post.new(mensagem: 'post_msg', video: nil, topico_id: topico.id, usuario_id: nil)
    expect(post).to_not be_valid
  end
end
