require 'rails_helper'

RSpec.describe Denunciation, type: :model do
  it 'é válida se denunciador, denunciado, e tipo
      não estão em branco e source_id está especificado' do

    usuario = Usuario.create(login: 'login', password: 'senha')
    topico = Topico.create(titulo: 'título', mensagem: 'mensagem', usuario_id: usuario.id)
    post = Post.create(mensagem: 'post_msg', video: nil, topico_id: topico.id, usuario_id: usuario.id)
    denuncia = Denunciation.new(denunciador: 'denunciador', denunciado: 'denunciado',
      tipo: 'post', source_id: post.id)

    expect(denuncia).to be_valid
  end

  it 'é válido se source_id já existe' do
    usuario = Usuario.create(login: 'login', password: 'senha')
    topico = Topico.create(titulo: 'título', mensagem: 'mensagem', usuario_id: usuario.id)
    post = Post.create(mensagem: 'post_msg', video: nil, topico_id: topico.id, usuario_id: usuario.id)
    denuncia = Denunciation.create(denunciador: 'denunciador', denunciado: 'denunciado',
      tipo: 'post', source_id: post.id)

    denuncia = Denunciation.new(denunciador: 'denunciador', denunciado: 'denunciado',
      tipo: 'post', source_id: post.id)

    denuncia.valid?
    expect(denuncia.errors[:source_id]).to_not include 'não está disponível'
  end

  it 'é inválida se o denunciador está em branco' do
    usuario = Usuario.create(login: 'login', password: 'senha')
    topico = Topico.create(titulo: 'título', mensagem: 'mensagem', usuario_id: usuario.id)
    post = Post.create(mensagem: 'post_msg', video: nil, topico_id: topico.id, usuario_id: usuario.id)
    denuncia = Denunciation.new(denunciador: nil, denunciado: 'denunciado',
      tipo: 'post', source_id: post.id)
  end

  it 'é inválida se o denunciado está em branco' do
    usuario = Usuario.create(login: 'login', password: 'senha')
    topico = Topico.create(titulo: 'título', mensagem: 'mensagem', usuario_id: usuario.id)
    post = Post.create(mensagem: 'post_msg', video: nil, topico_id: topico.id, usuario_id: usuario.id)
    denuncia = Denunciation.new(denunciador: 'denunciador', denunciado: nil,
      tipo: 'post', source_id: post.id)

    expect(denuncia).to_not be_valid
  end

  it 'é inválida se o tipo está em branco' do
    usuario = Usuario.create(login: 'login', password: 'senha')
    topico = Topico.create(titulo: 'título', mensagem: 'mensagem', usuario_id: usuario.id)
    post = Post.create(mensagem: 'post_msg', video: nil, topico_id: topico.id, usuario_id: usuario.id)
    denuncia = Denunciation.new(denunciador: 'denunciador', denunciado: 'denunciado',
      tipo: nil, source_id: post.id)

    expect(denuncia).to_not be_valid
  end

  it 'é inválida se source_id não está especificado' do
    denuncia = Denunciation.new(denunciador: 'denunciador', denunciado: 'denunciado',
      tipo: 'topico', source_id: nil)

    expect(denuncia).to_not be_valid
  end
end
