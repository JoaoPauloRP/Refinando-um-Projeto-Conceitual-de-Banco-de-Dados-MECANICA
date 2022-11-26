-- criação do banco de dados para o cenário de E-commerce 

create database ecommerce;
use ecommerce;
-- drop database ecommerce;

create table pessoa_fisica(
		idpf int auto_increment not null unique,
        CPF varchar(11) not null primary key,
        Pnome varchar(10) not null,
        MnomeInicial varchar(3) not null,
        Sobrenome varchar(20) not null,
        dataDeNascimento date not null,
        telefone char(11),
        rua longtext not null,
        complemento varchar(45),
        bairro varchar(45) not null,
        cidade varchar(45) not null,
        estado char(2) not null,
        pais varchar(10) not null,
        CEP varchar(15)
        );
        
alter table pessoa_fisica auto_increment=1;


    
create table pessoa_juridica(
		idpj int auto_increment not null unique,
        CNPJ varchar(15) not null primary key,
        razãoSocial varchar(45) default null,
        nomeFantasia varchar(45) not null,
        DataDeCriação date not null,
        Telefone char(11),
        rua varchar(45) not null,
        complemento varchar(45),
        bairro varchar (45) not null,
        cidade varchar (45) not null,
        estado char (2) not null,
        pais varchar (10) not null,
        CEP varchar (15)
        );
        
alter table pessoa_fisica auto_increment=1;

create table cliente(
		idCliente int auto_increment not null unique primary key,
        CPF char(11) unique,
        CNPJ char(14) unique,
        constraint fk_pf_cliente foreign key(CPF) references pessoa_fisica(CPF),
		constraint fk_pj_cliente foreign key(CNPJ) references pessoa_juridica(CNPJ)
);

alter table pessoa_fisica auto_increment=1;


create table produto(
		idProduto int auto_increment unique primary key,
        prodnome varchar(255) not null,
        classificação_criança bool default false,
        categoria enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
        avaliação float default 0,
        prodDimensão varchar(10),
        valor float
);

														
alter table produto auto_increment=1;

create table pagamento(
	idpagamento int auto_increment not null unique,
    idcliente int not null,
    tipoDePagamento enum('Boleto','Cartão','Dois cartões') not null,
    limiteDisponivel float default 0,
    pagamentoStatus enum("Não autorizado", "Em Andamento","Pagamento confirmado") not null,
    primary key(idpagamento, idcliente),
	constraint fk_pagamento_cliente foreign key(idcliente) references cliente(idcliente)
);



create table pedido(
	idpedido int auto_increment not null unique primary key,
    idcliente int not null,
    idpagamento int,
    statusPedido enum('Cancelado','Em processamento','Enviado','Entregue') default 'Em processamento',
    descriçãoDoPedido varchar(255),
    valorDaVenda float default 0,
    valorDoFrete float default 0,
    codRastreio varchar(25),
    constraint fk_pedido_cliente foreign key (idCliente) references cliente(idCliente),
    constraint fk_pedido_pagamento foreign key (idpagamento) references pagamento(idpagamento)
			on update cascade
);

alter table pedido auto_increment=1;

create table estoque(
	idestoque int auto_increment not null unique primary key,
    localizaçãoEstoque varchar(255) not null,
    quantidade int default 0
);

alter table estoque auto_increment=1;

create table fornecedor(
	idfornecedor int auto_increment not null unique primary key,
    CNPJ char(15) not null,
    constraint fk_pj_fornecedor foreign key(CNPJ) references pessoa_juridica(CNPJ)
);

alter table fornecedor auto_increment=1;

create table vendedor(
	idvendedor int auto_increment not null unique primary key,
    CNPJ char(15),
    CPF char(9),
    constraint fk_cnpj_vendedor foreign key(CNPJ) references pessoa_juridica(CNPJ),
    constraint fk_cpf_vendedor foreign key(CPF) references pessoa_fisica(CPF)
);

alter table vendedor auto_increment=1;

create table produto_vendedor(
	idvendedor int not null,
    idproduto int not null,
    prodQuantidade int default 1,
    primary key (idvendedor, idproduto),
    constraint fk_vendedor_prod_vend foreign key (idvendedor) references vendedor(idvendedor),
    constraint fk_produto_prod_vend foreign key (idproduto) references produto(idproduto)
);

create table produto_pedido(
	idproduto int not null,
    idpedido int not null,
    prodQuantidade int default 1,
    prodStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idproduto, idpedido),
    constraint fk_produto_prod_ped foreign key (idproduto) references produto(idProduto),
    constraint fk_pedido_prod_ped foreign key (idpedido) references pedido(idpedido)

);

create table produto_estoque(
	idproduto int,
    idestoque int,
    localização varchar(255) not null,
    primary key (idproduto, idestoque),
    constraint fk_estoque_localização_produto foreign key (idproduto) references produto(idProduto),
    constraint fk_estoque_localização_estoque foreign key (idestoque) references estoque(idestoque)
);

create table produto_fornecedor(
	idfornecedor int,
    idproduto int,
    quantidade int not null,
    primary key (idfornecedor, idproduto),
    constraint fk_fornecedor_produto_fornecedor foreign key (idfornecedor) references fornecedor(idfornecedor),
    constraint fk_produto_produto_fornecedor foreign key (idproduto) references produto(idProduto)
);

-- show tables;

-- show databases;

-- use information_schema;

-- show tables;

-- desc referential_constraints;

-- select * from referential_constraints where constraint_schema = 'ecommerce';

-- desc pessoa_fisica;
-- desc pessoa_juridica;
-- desc cliente;
-- desc pedido;
-- desc produto;
-- desc pagamento;
-- desc fornecedor;
-- desc vendedor;
-- desc pagamento;
-- desc estoque;
-- desc produto_vendedor;
-- desc produto_fornecedor;
-- desc produto_pedido;
-- desc produto_estoque;



-- inserção de dados e queries


insert into pessoa_fisica(Pnome, MnomeInicial, Sobrenome, dataDeNascimento, CPF, rua, bairro, cidade, estado, pais) 
	   values('Maria','M','Silva', '1965-08-21',123467898,'rua prata','Carangola','Cidade das flores', 'SP','Brasil'),
		     ('Matheus','O','Pimentel','1974-06-08',987654321,'rua alemeda','Centro','Cidade das flores','SP','Brasil'),
			 ('Ricardo','F','Silva','1978-11-30',45678913,'avenida alameda','Centro','Cidade das flores','SP','Brasil'),
			 ('Julia','S','França','1989-03-06',789123456,'rua laranjeiras','Centro','Cidade das flores','SP','Brasil'),
			 ('Roberta','G','Assis','1993-05-22',98745631,'avenidade koller','Centro','Cidade das flores','SP','Brasil'),
			 ('Isabela','M','Cruz','1981-04-18',654789123,'rua das flores','Centro','Cidade das flores','SP','Brasil');
             
             
insert into pessoa_juridica (razãosocial, nomeFantasia, dataDeCriação, CNPJ, rua, bairro, cidade, estado, pais) values 
			('Fornecimento Almeida e Silva LTDA', 'Almeida e filhos', '1991-09-10', 123456789123456, 'Av. Doutor Arman', 'Jd. Vera Cruz', 'Cidade das flores', 'SP', 'Brasil'),
			('Bautec representates - ME', 'Eletrônicos Silva', '1981-05-30', 854519649143457, 'Rua João Quirino', 'Jd. Boa Esperança', 'Cidade das flores', 'SP', 'Brasil'),
			('remodelic fornecedor LTDA', 'Eletrônicos Valma', '2000-12-02', 934567893934695, 'Av. independencia', 'Iporanga', 'Cidade das flores', 'SP', 'Brasil');
            
insert into pessoa_juridica (nomeFantasia, dataDeCriação, CNPJ, rua, bairro, cidade, estado, pais) values
            ('Tech eletronics', '1999-03-25', 712345678945632, 'Rua das Arueiras', 'Coimbra', 'Rio de Janeiro', 'RJ', 'Brasil'),
			('Botique Durgas', '2011-01-06', 548123456783589, 'Av U78', 'St. Bueno', 'Goiânia', 'GO',  'Brasil'),
			('Kids World', '2005-07-09', 456789123654485, 'Av das conceições', 'Renascer', 'São Paulo', 'SP', 'Brasil');

insert into cliente (CPF) values
			(123467898),
			(987654321),
			(45678913),
			(789123456),
			(98745631),
			(654789123);


insert into produto (prodNome, classificação_criança, categoria, avaliação, prodDimensão, valor) values
			('Fone de ouvido',false,'Eletrônico',4,null, 39.90),
			('Barbie Elsa',true,'Brinquedos',3,null, 50.00),
			('Body Carters',true,'Vestimenta',5,null, 20.00),
			('Microfone Vedo - Youtuber',False,'Eletrônico',4,null, 85.40),
			('Sofá retrátil',False,'Móveis','3','3x57x80', 1490.00),
			('Farinha de arroz',False,'Alimentos',2,null, 19.95),
			('Fire Stick Amazon',False,'Eletrônico',3,null, 25.50);



insert into pagamento (idcliente, tipoDePagamento, limiteDisponivel, pagamentoStatus) values
			(1, "boleto", default, "Em Andamento"),
			(2, "Dois cartões", 100.00, "Pagamento confirmado"),
			(3, "Boleto", default, "Em Andamento"),
			(4, "Cartão", default, "Pagamento confirmado");


insert into pedido (idcliente, statusPedido, descriçãoDoPedido, valorDaVenda, valorDoFrete, codRastreio) values 
			(1, default,'compra via aplicativo',null,39.99, 4.00),
			(2,'Entregue','compra via aplicativo',50,14.90, 'BR54546545465465'),
			(3,'Cancelado',null,null,100.00, null),
			(4,'Enviado','compra via web site',150,0, 'BR8451541151141');


insert into produto_pedido (idproduto, idpedido, prodQuantidade, prodStatus) values
			(1,2,2,null),
			(2,4,1,null),
			(3,4,1,null);
            

insert into estoque (localizaçãoEstoque, quantidade) values 
			('Rio de Janeiro',1000),
			('Rio de Janeiro',500),
			('São Paulo',10),
			('São Paulo',100),
			('São Paulo',10),
			('Brasília',60);


insert into produto_estoque (idproduto, idestoque, localização) values
			(1,2,'RJ'),
			(2,6,'GO');


insert into fornecedor (CNPJ) values 
			(123456789123456),
			(854519649143457),
			(934567893934695);
                            

insert into produto_fornecedor (idproduto, idfornecedor, quantidade) values
			(1,1,500),
			(2,1,400),
			(4,2,633),
			(3,3,5),
			(5,2,10);


insert into vendedor (CNPJ) values 
						(712345678945632),
					    (548123456783589),
						(456789123654485);


insert into produto_vendedor (idvendedor, idproduto, prodQuantidade) values 
						 (1,6,80),
                         (2,7,10);

select * from pedido;

select count(*) from cliente;
select * from cliente c, pedido p where c.idcliente = p.idcliente;

select Pnome, Sobrenome, idpedido, statusPedido from pessoa_fisica as pf, pessoa_juridica as pj, cliente c, pedido p where c.idcliente = p.idcliente;
select concat(Pnome,' ',Sobrenome) as cliente, idpedido as Requisição, statusPedido as Status from pessoa_fisica as pf, pessoa_juridica as pj, cliente c, pedido p where c.idcliente= p.idcliente;

                             
select count(*) from cliente c, pedido p 
			where c.idcliente = p.idcliente;

select * from pedido;


select * from cliente c 
				inner join pedido p ON c.idcliente = p.idcliente
                inner join produto_pedido pp on p.idpedido = pp.idpedido
		group by c.idcliente; 
        
        


