-- Projeto: Estrutura de Banco de Dados (DDL)
-- Desenvolvedor: Autor Anônimo

-- Criando o banco de dados
CREATE DATABASE lojaDB;

-- Conectando ao banco de dados criado
\c lojaDB;

-- Criando o esquema
CREATE SCHEMA loja;

-- Criando a tabela de clientes
CREATE TABLE loja.clientes (
    cliente_id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    documento VARCHAR(20) UNIQUE,
    endereco VARCHAR(255),
    cidade VARCHAR(100),
    estado VARCHAR(50),
    codigo_postal VARCHAR(20),
    data_nascimento DATE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'ativo'
);

-- Criando a tabela de produtos
CREATE TABLE loja.produtos (
    produto_id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco NUMERIC(10, 2) NOT NULL,
    quantidade_estoque INTEGER NOT NULL,
    sku VARCHAR(50) UNIQUE,
    categoria VARCHAR(100),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'disponivel'
);

-- Criando a tabela de fornecedores
CREATE TABLE loja.fornecedores (
    fornecedor_id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    contato VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(255) UNIQUE,
    endereco VARCHAR(255),
    cidade VARCHAR(100),
    estado VARCHAR(50),
    codigo_postal VARCHAR(20),
    pais VARCHAR(50),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'ativo'
);

-- Criando a tabela de estoque
CREATE TABLE loja.estoque (
    estoque_id SERIAL PRIMARY KEY,
    produto_id INTEGER NOT NULL,
    quantidade INTEGER NOT NULL CHECK (quantidade >= 0),
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    localizacao VARCHAR(100),
    fornecedor_id INTEGER,
    limite_alerta INTEGER DEFAULT 10,
    FOREIGN KEY (produto_id) REFERENCES loja.produtos(produto_id) ON DELETE CASCADE,
    FOREIGN KEY (fornecedor_id) REFERENCES loja.fornecedores(fornecedor_id) ON DELETE SET NULL
);
