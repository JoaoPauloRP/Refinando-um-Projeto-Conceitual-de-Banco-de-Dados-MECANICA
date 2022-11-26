create database oficina;
use oficina;



create table Cliente (

		idCliente int AUTO_INCREMENT not null unique primary key,
		pNome VARCHAR(45) not null,
        sobrenome VARCHAR(45) not null,
        CPF VARCHAR(11) not null unique,
        dataDeNascimento date,
        endereço VARCHAR(255)
        
);

alter table Cliente auto_increment=1;

create table Veiculo (

		idVeiculo int AUTO_INCREMENT not null unique,
        idCliente int,
        marca VARCHAR(45) not null,
        modelo VARCHAR(45) not null,
        anoFabricação VARCHAR(45),
        cor VARCHAR(45),
        PRIMARY KEY (idVeiculo, idCliente),
        CONSTRAINT fk_Cliente_Veiculo FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)

);

ALTER TABLE Veiculo AUTO_INCREMENT=1;

CREATE TABLE Equipe (

		idEquipe int AUTO_INCREMENT not null unique PRIMARY KEY,
        funcionario VARCHAR(125),
        endereço VARCHAR(255),
        especialidade ENUM('Reparo Automotivo', 'Troca de oleo', 'Alinhamento e Balanceamento', 'Manutenção de Embrenhagem', 'Revisão de componente de freio')

);

ALTER TABLE equipe AUTO_INCREMENT=1;

CREATE TABLE Peça (

idPeça int AUTO_INCREMENT not null unique PRIMARY KEY,
peçaNome VARCHAR(45),
peçaValor FLOAT

);

ALTER TABLE Peça AUTO_INCREMENT=1;

desc Peça;
desc ordemDeServiço;


CREATE TABLE OrdemDeServiço (

idOS int AUTO_INCREMENT not null unique,
idCliente int,
idPeça int,
peçaValor FLOAT,
valorMãoDeObraHora FLOAT,
valorTotalDoServiço FLOAT,
duraçãoServiço FLOAT,
dataEmissão date,
serviçoStatus ENUM('Cancelado','Aguardando Autorização', 'Realizando Serviço', 'Concluido'),
dataConclusão date,
PRIMARY KEY (idOS, idCliente, idpeça),
CONSTRAINT fk_Cliente_OS FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
CONSTRAINT fk_peça_OS FOREIGN KEY (idPeça) REFERENCES Peça(idPeça)

);

ALTER TABLE OrdemdeServiço AUTO_INCREMENT=1;

CREATE TABLE ValorReferencia (

		valorMãoDeObraHora FLOAT NOT NULL PRIMARY KEY,
        tipoDeServiço ENUM('Reparo Automotivo', 'Troca de oleo', 'Alinhamento e Balanceamento', 'Manutenção de Embrenhagem', 'Revisão de componente de freio')

);

CREATE TABLE Veiculo_Equipe (

		idVeiculo int NOT NULL,
        idEquipe int NOT NULL,
        PRIMARY KEY (idVeiculo, idEquipe),
        CONSTRAINT fk_Veiculo_Veiculo_Equipe FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo),
		CONSTRAINT fk_Equipe_Veiculo_Equipe FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe)

);

CREATE TABLE Equipe_OrdemDeServiço (

		idOS INT NOT NULL,
		idEquipe INT NOT NULL,
        serviçoStatus ENUM('Cancelado','Aguardando Autorização', 'Realizando Serviço', 'Concluido'),
		PRIMARY KEY (idOS, idEquipe),
		CONSTRAINT fk_OS_OS_Equipe FOREIGN KEY (idOS) REFERENCES OrdemdeServiço(idOS),
		CONSTRAINT fk_Equipe_OS_Equipe FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe)

);

CREATE TABLE Veiculo_OS (

		idVeiculo INT NOT NULL,
        idOS INT NOT NULL,
        PRIMARY KEY (idVeiculo, idOS),
		CONSTRAINT fk_OS_Veiculo_OS FOREIGN KEY (idOS) REFERENCES OrdemdeServiço(idOS),
        CONSTRAINT fk_Veiculo_Veiculo_OS FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo)

);


INSERT INTO Cliente (pNome, sobrenome, CPF, dataDeNascimento, endereço) VALUES
			('Evelyn', 'Rodrigues', 41658967197, '1988-05-04', 'Rua Carlos Augusto Cornel, Bom  Retiro, Curitiba-PR'),
			('Wladimir', 'Barbosa', 54879621458,'1963-12-25', 'Travessa Antonio Ferreira, Igrejinha, Curitiba-PR'),
			('Adair', 'Aparecido', 78145793156,'1992-06-12', 'Avenida Almirante Maximiano, Zona Portuaria, Curitiba-PR'),
			('Regina', 'Gonçalves', 68244973256,'1981-04-04', 'Rua Domingos Olimpio, Centro, Curitiba-PR'),
			('Patricia', 'Gomes', 28647935647,'1977-08-16', 'Rua Paracatu, Parque Imperial, Curitiba-PR'),
			('Rogerio', 'Oliveira', 86972463897,'1997-10-27', 'Rua da Imprensa, Monte Castelo, Curitiba-PR'),
			('Ingrid', 'Araujo', 25974638125,'1988-07-30', 'Rua Maria Luisa do Val, Cidade São Mateus, Curitiba-PR');

select * from Cliente;

INSERT INTO Veiculo (idCliente, marca, modelo, anoFabricação, cor) VALUE
			('1','HAFEI', 'Towner Jr. Pick-up Ba', '2011', 'Azul'),
			('2', 'Ford', 'Probe GT 2.5 V6', '1993', 'Preto'),
			('6', 'Engesa', 'Engesa 4x4 4.0 Diesel', '1986', 'Amarelo'),
			('4', 'Alfa Romeo', '155', '1995', 'Preto');

select * from Veiculo;

INSERT INTO Equipe (funcionario, endereço, especialidade) VALUES
			('Renan Gustavo Fernando Nogueira', 'Centro-Curitiba', 'Reparo Automotivo'),
			('Carolina Melissa Rayssa da Rosa', 'Centro-Curitiba', 'Manutenção de Embrenhagem'),
			('Ruan Vinicius Costa', 'Bom Retiro-Curitiba', 'Alinhamento e Balanceamento'),
			('Márcio Davi Raul da Mata', 'Centro-Curitiba', 'Alinhamento e Balanceamento'),
			('Andreia Emanuelly Gonçalves', 'Centro-Curitiba', 'Troca de Oleo'),
			('Vicente Bruno Giovanni Ferreira', 'Bom Retiro-Curitiba', 'Revisão de componente de freio');

select * from Equipe;

INSERT INTO ValorReferencia (tipoDeServiço, valorMãoDeObraHora) VALUES
			('Reparo Automotivo', 35.00), 
			('Troca de oleo', 10.00),
			('Alinhamento e Balanceamento', 25.00),
			('Manutenção de Embrenhagem', 20.00),
			('Revisão de componente de freio', 15.00);

select * from ValorReferencia;

INSERT INTO Peça (peçaNome, peçaValor) VALUES
			('Correia Dentada', 217.40),
			('Engrenagem', 297.63),
			('Pastilha Freio', 50.00),
			('Junta Cabeçote', 136.91),
			('Pistão 050 c/ aneis', 689.00),
			('Barra de Direção', 250.50 ),
			('Manivela Vidro', 25.00),
			('Bateria', 380.40);

select * from peça;

INSERT INTO OrdemDeServiço (idCliente, idPeça, peçaValor, duraçãoServiço, valorMãoDeObraHora, valorTotalDoServiço, dataEmissão, dataConclusão, serviçoStatus) VALUES
			('2', '3', 50.0, 3,25.00,125.00,'2022-10-10', '2022-10-11', 'Concluido' ),
			('6', '2', 297.63, 1.5, 20.00, 327.63, '2022-10-13', '2022-10-13', 'Realizando Serviço'),
			('1', '5', '689.00', 2, 35.00, 759.00,'2022-10-13', '2022-10-14', 'Aguardando Autorização');
			
select * from OrdemDeServiço;

INSERT INTO Veiculo_Equipe (idVeiculo, idEquipe) VALUE
			('2','3'),
			('3','2'),
            ('1','1');
            
INSERT INTO Equipe_OrdemDeServiço (idOS, idEquipe, serviçoStatus) VALUES
			('1','3','Concluido'),
            ('2','2','Realizando Serviço'),
            ('3','1','Aguardando Autorização');
            
INSERT INTO Veiculo_OS (idVeiculo, idOS) VALUES
			('2', '1'),
            ('3', '2'),
            ('1', '3');
            
-- Qual(is) os veiculos de cada cliente pessoa Fisica? Recupere o Nome do Cliente, a Marca do Veiculo e o Modelo
select pNome, marca, modelo  from Cliente c, Veiculo v where c.idCliente = v.idCliente order by pNome;


-- Quais as peças presentes no estoque?

select peçaNome from peça order by peçaNome;

-- Quantas OS existem?

select count(*) from OrdemDeServiço;

-- Quantas OS foram Concluidas?

select count(*) from OrdemDeServiço where serviçoStatus = 'Concluido'; 

-- Qual o valor gasto por cada Cliente?

select pNome, valorTotalDoServiço  from Cliente c, OrdemDeServiço o WHERE c.idCliente = o.idCliente;


-- Recupere o Nome dos funcionarios e especialidade em cada O.S?

select idOS, funcionario, especialidade from Equipe e, Equipe_OrdemDeServiço o where e.idEquipe = o.idEquipe;

-- Recupere o Nome do cliente, a marca, o modelo, o id da ordem de serviço, duração do serviço e data da conclussão
select pNome, v.marca, v.modelo, o.idOS, o.duraçãoServiço, dataConclusão from Cliente, Veiculo v, OrdemDeServiço o where v.idCliente = o.idCliente;