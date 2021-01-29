drop table pizzasabor;
drop table pizza;
drop table borda;
drop table comanda;
drop table mesa;
drop table precoportamanho;
drop table tamanho;
drop table saboringrediente;
drop table ingrediente;
drop table sabor;
drop table tipo;

create table tipo (
	codigo integer not null,
	nome varchar(100) not null,
	primary key (codigo)
);

insert into tipo (codigo, nome) values
	(1, 'PIZZAS SALGADAS TRADICIONAIS'),
	(2, 'PIZZAS SALGADAS ESPECIAIS'),
	(3, 'PIZZAS DOCES TRADICIONAIS');

create table sabor (
	codigo integer not null,
	nome varchar(100) not null,
	tipo integer not null,
	foreign key (tipo) references tipo(codigo),
	primary key (codigo)
);

insert into sabor (codigo, nome, tipo) values
	(1, '3 QUEIJOS', 1),
	(2, '4 QUEIJOS', 1),
	(3, 'CHARQUE', 2),
	(4, 'BAFO', 2),
	(5, 'MORANGO', 3),
	(6, 'MACA E CANELA', 3);

create table ingrediente (
	codigo integer not null,
	nome varchar(100) not null,
	primary key (codigo)
);

insert into ingrediente (codigo, nome) values
	(1, 'ALHO'),
	(2, 'AZEITONA'),
	(3, 'BACON'),
	(4, 'CANELA'),
	(5, 'CATUPIRY'),
	(6, 'CEBOLA'),
	(7, 'CHARQUE'),
	(8, 'CHOCOLATE'),
	(9, 'GORGONZOLA'),
	(10, 'LEITE CONDENSADO'),
	(11, 'MACA'),
	(12, 'MORANGO'),
	(13, 'MUSSARELA'),
	(14, 'PROVOLONE');

create table saboringrediente (
	sabor integer not null,
	ingrediente integer not null,
	foreign key (sabor) references sabor(codigo),
	foreign key (ingrediente) references ingrediente(codigo),
	primary key (sabor, ingrediente)
);

insert into saboringrediente (sabor, ingrediente) values
	(1, 5), (1, 13), (1, 14),
	(2, 5), (2, 13), (2, 14), (2, 9),
	(3, 13), (3, 6), (3, 7),
	(4, 13), (4, 3), (4, 6), (4, 1), (4, 2),
	(5, 12), (5, 10), (5, 8),
	(6, 11), (6, 10), (6, 4);

create table tamanho (
	codigo char(1) not null,
	nome varchar(100) not null,
	qtdesabores integer not null check (qtdesabores > 0),
	primary key (codigo)
);

insert into tamanho (codigo, nome, qtdesabores) values
	('P', 'PEQUENA', 1),
	('M', 'MEDIA', 2),
	('G', 'GRANDE', 3),
	('F', 'FAMILIA', 4);

create table precoportamanho (
	tipo integer not null,
	tamanho char(1) not null,
	preco real not null check (preco > 0),
	foreign key (tipo) references tipo(codigo),
	foreign key (tamanho) references tamanho(codigo),
	primary key (tipo, tamanho)
);

insert into precoportamanho (tipo, tamanho, preco) values
	(1, 'P', 59.00), (1, 'M', 66.00), (1, 'G', 73.00), (1, 'F', 80.00),
	(2, 'P', 66.00), (2, 'M', 74.00), (2, 'G', 82.00), (2, 'F', 90.00),
	(3, 'P', 60.00), (3, 'M', 65.00), (3, 'G', 70.00), (3, 'F', 75.00);

create table mesa (
	codigo integer not null,
	nome varchar(100) not null,
	primary key (codigo)
);

insert into mesa (codigo, nome) values
	(1, '1A');

create table comanda (
	numero integer not null,
	data date default current_date,
	mesa integer not null,
	pago boolean not null default false,
	foreign key (mesa) references mesa(codigo),
	primary key (numero)
);

insert into comanda (numero, mesa) values
	(3, 1);

create table borda (
	codigo integer not null,
	nome varchar(100) not null,
	preco real not null check (preco > 0),
	primary key (codigo)
);

insert into borda (codigo, nome, preco) values
	(1, 'CATUPIRY', 2.00),
	(2, 'PIMENTA', 4.00);

create table pizza (
	codigo integer not null,
	comanda integer not null,
	tamanho char(1) not null,
	borda integer, -- -O| PODE SER NULL!
	foreign key (comanda) references comanda(numero),
	foreign key (tamanho) references tamanho(codigo),
	foreign key (borda) references borda(codigo),
	primary key (codigo)
);

insert into pizza (codigo, comanda, tamanho, borda) values
	(1, 3, 'G', 1),
	(2, 3, 'P', null);

create table pizzasabor (
	pizza integer not null,
	sabor integer not null,
	foreign key (pizza) references pizza(codigo),
	foreign key (sabor) references sabor(codigo),
	primary key (pizza, sabor)
);

insert into pizzasabor (pizza, sabor) values
	(1, 2), (1, 4),
	(2, 6);

