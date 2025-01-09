-- Criando o banco de dados
CREATE DATABASE redeSocialDB;

-- Conectando ao banco de dados criado
-- (Este comando funciona apenas em PostgreSQL, remova caso não seja necessário)
-- \c redeSocialDB;

-- Criando o esquema
CREATE SCHEMA rede_social;

-- Criando a tabela de usuários
CREATE TABLE "rede_social".usuarios (
    usuario_id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    genero VARCHAR(50),
    bio TEXT,
    foto_perfil VARCHAR(255),
    cidade VARCHAR(100),
    estado VARCHAR(50),
    pais VARCHAR(50),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'ativo' CHECK (status IN ('ativo', 'inativo', 'banido'))
);

-- Criando a tabela de publicações
CREATE TABLE "rede_social".publicacoes (
    publicacao_id SERIAL PRIMARY KEY,
    usuario_id INTEGER NOT NULL,
    conteudo TEXT NOT NULL,
    imagem VARCHAR(255),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP,
    visibilidade VARCHAR(20) DEFAULT 'publico' CHECK (visibilidade IN ('publico', 'privado', 'amigos')),
    FOREIGN KEY (usuario_id) REFERENCES rede_social.usuarios(usuario_id) ON DELETE CASCADE
);

-- Criando a tabela de comentários
CREATE TABLE "rede_social".comentarios (
    comentario_id SERIAL PRIMARY KEY,
    publicacao_id INTEGER NOT NULL,
    usuario_id INTEGER NOT NULL,
    conteudo TEXT NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (publicacao_id) REFERENCES rede_social.publicacoes(publicacao_id) ON DELETE CASCADE,
    FOREIGN KEY (usuario_id) REFERENCES rede_social.usuarios(usuario_id) ON DELETE CASCADE
);

-- Criando a tabela de curtidas
CREATE TABLE "rede_social".curtidas (
    curtida_id SERIAL PRIMARY KEY,
    publicacao_id INTEGER NOT NULL,
    usuario_id INTEGER NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (publicacao_id) REFERENCES rede_social.publicacoes(publicacao_id) ON DELETE CASCADE,
    FOREIGN KEY (usuario_id) REFERENCES rede_social.usuarios(usuario_id) ON DELETE CASCADE,
    UNIQUE (publicacao_id, usuario_id) -- Impede que um usuário curta a mesma publicação mais de uma vez
);

-- Criando a tabela de amizades
CREATE TABLE "rede_social".amizades (
    amizade_id SERIAL PRIMARY KEY,
    usuario_id1 INTEGER NOT NULL,
    usuario_id2 INTEGER NOT NULL,
    status VARCHAR(20) DEFAULT 'pendente' CHECK (status IN ('pendente', 'aceita', 'recusada')),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id1) REFERENCES rede_social.usuarios(usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (usuario_id2) REFERENCES rede_social.usuarios(usuario_id) ON DELETE CASCADE,
    UNIQUE (usuario_id1, usuario_id2) -- Impede duplicação de amizades
);

-- Criando a tabela de mensagens privadas
CREATE TABLE "rede_social".mensagens (
    mensagem_id SERIAL PRIMARY KEY,
    remetente_id INTEGER NOT NULL,
    destinatario_id INTEGER NOT NULL,
    conteudo TEXT NOT NULL,
    enviado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    lido BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (remetente_id) REFERENCES rede_social.usuarios(usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (destinatario_id) REFERENCES rede_social.usuarios(usuario_id) ON DELETE CASCADE
);
