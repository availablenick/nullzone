require 'rails_helper'

RSpec.describe Usuario, type: :model do
  it 'é válido quando contém login e senha' do
    usuario = Usuario.new(login: 'login', password: 'senha')
    expect(usuario).to be_valid
  end

  it 'é inválido quando o login está em branco' do
    usuario = Usuario.new(login: nil, password: 'senha')
    expect(usuario).to_not be_valid
  end

  it 'é inválido quando a senha está em branco' do
    usuario = Usuario.new(login: 'login', password: nil)
    expect(usuario).to_not be_valid
  end

  it 'é inválido quando login e senha estão em branco' do
    usuario = Usuario.new(login: nil, password: nil)
    expect(usuario).to_not be_valid
  end

  it 'é inválido caso o login já exista' do
    usuario = Usuario.create(login: 'login', password: 'senha')
    usuario = Usuario.new(login: 'login', password: 'senha')
    usuario.valid?
    expect(usuario.errors[:login]).to include 'não está disponível'
  end

  it 'é inválido caso a senha não possua o comprimento mínimo' do
    usuario = Usuario.new(login: 'login', password: 'senh')
    usuario.valid?
    expect(usuario.errors[:password]).to include 'não possui o comprimento mínimo (5 caracteres)'
  end
end
