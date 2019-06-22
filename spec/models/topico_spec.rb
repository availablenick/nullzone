require 'rails_helper'

RSpec.describe Topico, type: :model do
  it 'é válido quando possui título e mensagem' do
    usuario = Usuario.create(login: 'login', password: 'senha')
    topico = Topico.new(titulo: 'título', mensagem: 'mensagem', usuario_id: usuario.id)
    expect(topico).to be_valid
  end

  it 'é válido se possui um título que já existe' do
    usuario = Usuario.create(login: 'login', password: 'senha')
    topico = Topico.create(titulo: 'título', mensagem: 'mensagem1', usuario_id: usuario.id)
    topico = Topico.new(titulo: 'título', mensagem: 'mensagem2', usuario_id: usuario.id)
    topico.valid?
    expect(topico.errors[:topico]).to_not include 'não está disponível'
  end

  it 'é válido se possui uma mensagem que já existe' do
    usuario = Usuario.create(login: 'login', password: 'senha')
    topico = Topico.create(titulo: 'título1', mensagem: 'mensagem', usuario_id: usuario.id)
    topico = Topico.new(titulo: 'título2', mensagem: 'mensagem', usuario_id: usuario.id)
    topico.valid?
    expect(topico.errors[:mensagem]).to_not include 'não está disponível'
  end

  it 'é inválido quando o título está em branco' do
    usuario = Usuario.create(login: 'login', password: 'senha')
    topico = Topico.new(titulo: nil, mensagem: 'mensagem', usuario_id: usuario.id)
    expect(topico).to_not be_valid
  end

  it 'é inválido quando a mensagem está em branco' do
    usuario = Usuario.create(login: 'login', password: 'senha')
    topico = Topico.new(titulo: 'título', mensagem: nil, usuario_id: usuario.id)
    expect(topico).to_not be_valid
  end

  it 'é inválido quando usuario_id não está especificado' do
    topico = Topico.new(titulo: 'título', mensagem: 'mensagem2', usuario_id: nil)
    expect(topico).to_not be_valid
  end
end
