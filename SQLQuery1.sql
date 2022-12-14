CREATE DATABASE Clinica --Cria??o da base de dados Clinica
GO

USE Clinica
GO

--Cri??o da tabela paciente
CREATE TABLE paciente(
num_beneficiario       INT              NOT NULL,
nome                   VARCHAR(200)     NOT NULL,
logradouro             VARCHAR(200)     NOT NULL,
numero                 INT              NOT NULL,
CEP                    CHAR(8)          NULL,
complemento            VARCHAR(255)     NULL,
telefone               VARCHAR(11)      NOT NULL
PRIMARY KEY (num_beneficiario)
)
GO

--Cria??o da tabela especialidade
CREATE TABLE especialidade(
id                     INT              NOT NULL,
especialidade          VARCHAR(200)     NOT NULL
PRIMARY KEY (id)
)
GO

--Cria??o da tabela medico
CREATE TABLE medico(
codigo              INT                 NOT NULL,
nome                VARCHAR(100)        NOT NULL,
logradouro          VARCHAR(200)        NOT NULL,
numero              INT                 NOT NULL,
CEP                 CHAR(8)             NOT NULL,
complemento         VARCHAR(255)        NULL,
contato             VARCHAR(11)         NOT NULL,
especialidade_id    INT                 NOT NULL
PRIMARY KEY  (codigo)
FOREIGN KEY  (especialidade_id)   REFERENCES  especialidade(id)
) 
GO

--Cria??o da tabela consulta
CREATE TABLE consulta(
paciente_num_beneficiario       INT            NOT NULL,
medico_codigo                   INT            NOT NULL,
data_hora                       DATETIME      NOT NULL,
observacao                      VARCHAR(255)   NOT NULL
PRIMARY KEY (paciente_num_beneficiario, medico_codigo, data_hora)
FOREIGN KEY (paciente_num_beneficiario) REFERENCES  paciente(num_beneficiario),
FOREIGN KEY (medico_codigo) REFERENCES medico(codigo)   
)
GO

--Inser??o das informa??es do paciente
INSERT INTO paciente(num_beneficiario, nome, logradouro, numero, CEP, complemento, telefone)
VALUES               (99901, 'Washington Silva', 'R. Anhaia', 150, '02345000', 'Casa', '922229999')
GO

INSERT INTO paciente(num_beneficiario, nome, logradouro, numero, CEP, complemento, telefone)
VALUES               (99902, 'Luis Ricardo', 'R. Voluntarios da Patria', 2251, '03254010', 'Bloco B Apto 25', '923450987')
GO

INSERT INTO paciente(num_beneficiario, nome, logradouro, numero, CEP, complemento, telefone)
VALUES               (99903, 'Maria Elisa', 'Av. Aguia de Haia', 1188, '06987020', 'Apto 1208', '912348765')
GO

INSERT INTO paciente(num_beneficiario, nome, logradouro, numero, CEP, complemento, telefone)
VALUES               (99904, 'Jos? Araujo', 'R. XY de Novembro', 18, '03678000', 'Casa', '945674312')
GO

INSERT INTO paciente(num_beneficiario, nome, logradouro, numero, CEP, complemento, telefone)
VALUES               (99905, 'Joana Paula', 'R. 7 de Abril', 97, '01214000', 'Conjunto 3 Apto 801', '912095674')
GO


--Inser??o das informa??es da especialidade do medico
INSERT INTO especialidade(id, especialidade)
VALUES       (1 , 'Otorrinolaringologista')
GO

INSERT INTO especialidade(id, especialidade)
VALUES       (2 , 'Urologista')
GO

INSERT INTO especialidade(id, especialidade)
VALUES       (3 , 'Geriatrica')
GO

INSERT INTO especialidade(id, especialidade)
VALUES       (4 , 'Pediatra')
GO



--Inser??o das informa??es do medico
INSERT INTO medico(codigo, nome, logradouro, numero, CEP, complemento, contato, especialidade_id)
VALUES          (100001, 'Ana Paula', 'R. 7 de Setembro', 256, 03698000, 'Casa', 915689456, 1)
GO

INSERT INTO medico(codigo, nome, logradouro, numero, CEP, complemento, contato, especialidade_id)
VALUES          (100002, 'Maria Aparecida', 'Av. Brasil', 32, 02145070, 'Casa', 923235454, 1)
GO

INSERT INTO medico(codigo, nome, logradouro, numero, CEP, complemento, contato, especialidade_id)
VALUES          (100003, 'Lucas Borges', 'Av. do Estado', 3210, 05241000, 'Apto 205', 963698585, 2)
GO

INSERT INTO medico(codigo, nome, logradouro, numero, CEP, complemento, contato, especialidade_id)
VALUES          (100004, 'Gabriel Oliveira', 'Av. Dom Helder Camara', 350, 03145000, 'Apto 602', 93245845, 3)
GO



--inser??o das informa??es da consulta
INSERT INTO consulta(paciente_num_beneficiario, medico_codigo, data_hora, observacao)
VALUES              (99901, 100002, '2021-09-04 13:20', 'Infec??o Urina')
GO

INSERT INTO consulta(paciente_num_beneficiario, medico_codigo, data_hora, observacao)
VALUES              (99902, 100003, '2021-09-04 13:15', 'Gripe')
GO

INSERT INTO consulta(paciente_num_beneficiario, medico_codigo, data_hora, observacao)
VALUES              (99901, 100001, '2021-09-04 12:30', 'Infec??o Garganta')
GO


--Cria??o da coluna dia_atendimento
ALTER TABLE medico
ADD dia_atendimento  VARCHAR(100)  NULL
GO

--Autalizar e adicionar os dias da semana de atendimento do medico
UPDATE medico
SET dia_atendimento = '2? feira'
WHERE codigo = 100001
GO

UPDATE medico
SET dia_atendimento = '4? feira'
WHERE codigo = 100002
GO

UPDATE medico
SET dia_atendimento = '2? feira'
WHERE codigo = 100003
GO

UPDATE medico
SET dia_atendimento = '5? feira'
WHERE codigo = 100004
GO


EXEC sp_rename 'dbo.medico.dia_atendimento',
               'dia_semana_atendimento' , 'column'
GO


DELETE especialidade
WHERE id = 4
GO

--Atualizar tabela do medico lucas
UPDATE medico
SET logradouro = 'Av. Bras Leme'
WHERE codigo = 100003
GO

UPDATE medico
SET numero = 876
WHERE codigo = 100003
GO

UPDATE medico
SET complemento = 'apto 504'
WHERE codigo = 100003
GO

UPDATE medico
SET CEP = 02122000
WHERE codigo = 100003
GO

ALTER TABLE consulta
ALTER COLUMN observacao VARCHAR(200)   NOT NULL
GO

SELECT * FROM paciente
SELECT * FROM medico
SELECT * FROM especialidade
SELECT * FROM consulta


