-- First, we are gonna create our database:
CREATE database Finances;

-- Now create some tables and their informations:
CREATE table if not exists banco (
    numero integer not null primary key,
    nome varchar(50) not null,
    ativo boolean not null default true,
    data_criacao timestamp not null default current_timestamp
)

CREATE table if not exists agencia (
    banco_numero integer not null,
    numero integer not null,
    nome varchar(80) not null,
    ativo boolean not null default true,
    data_criacao timestamp not null default CURRENT_TIMESTAMP,
    primary key (banco_numero, numero),
    foreign key (banco_numero) references banco (numero)
)

CREATE table if not exists cliente (
    numero bigserial primary key,
    nome varchar(120) not null,
    ativo boolean not null default true,
    data_criacao timestamp not null default CURRENT_TIMESTAMP
)

CREATE table if not exists conta_corrente (
    banco_numero integer not null,
    agencia_numero integer not null,
    numero bigint not null,
    digito smallint not null,
    cliente_numero bigint not null,
    ativo boolean not null default true,
    data_criacao timestamp not null default CURRENT_TIMESTAMP,
    primary key (banco_numero, agencia_numero, numero, digito, cliente_numero),
    foreign key (banco_numero, agencia_numero) references agencia (banco_numero, numero),
    foreign key (cliente_numero) references cliente (numero)
)

CREATE table if not exists tipo_transacao (
    id smallserial primary key,
    nome varchar(50) not null,
    ativo boolean not null default true,
    data_criacao timestamp not null default CURRENT_TIMESTAMP
)

CREATE table if not exists cliente_transacoes (
    id bigserial primary key,
    banco_numero integer not null,
    agencia_numero integer not null,
    conta_corrente_numero bigint not null,
    conta_corrente_digito smallint not null,
    cliente_numero bigint not null,
    tipo_transacao_id smallint not null,
    valor numeric (15,2) not null
    data_criacao timestamp not null default CURRENT_TIMESTAMP,
    foreign key (banco_numero, agencia_numero, conta_corrente_numero, conta_corrente_digito, cliente_numero)
    references conta_corrente (banco_numero, agencia_numero, numero, digito, cliente_numero)
)

--Now we can see the tables without any information but already created:
select * from banco;
select * from cliente_transacoes;
select nome from tipo_transacao;
select nome.cliente, numero.conta_corrente_digito, digito.conta_corrente
join conta_corrente on cliente_numero.conta_corrente = numero.cliente;