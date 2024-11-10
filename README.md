# Sistema de Gerenciamento de Vacinas para Crianças

Este projeto é um sistema para gerenciar vacinas de crianças, desenvolvido com `Flutter` no front-end e `json-server` para o back-end. 
O objetivo é permitir o cadastro, listagem, edição e exclusão de crianças e vacinas associadas a cada criança.

## Funcionalidades

- **Cadastro de Crianças:** Adicione novas crianças com informações como nome, gênero e data de nascimento.
- **Listagem de Crianças e Vacinas:** Veja uma lista completa das crianças registradas e vacinas associadas a cada criança.
- **Registro de Vacinas:** Associe vacinas a uma criança registrando as vacinas que já foram tomadas.
- **Atualização e Exclusão de Vacinas:** Edite o status de uma vacina (registrar como tomada ou excluir uma vacina incluída indevidamente).

## Estrutura do Projeto

A estrutura do projeto no front-end é organizada da seguinte forma:

- `model/`: Contém os modelos de dados, como `Child` e `Vaccine`.
- `pages/`: Contém as páginas principais, incluindo tela de login, tela inicial, formulário de cadastro da criança, listagem das crianças cadastradas, listagem das vacinas ainda não tomadas pela criança.
- `service/`: Define classes para requisições HTTP ao back-end.
  - `abstract_service.dart`: Serviço responsável pelas operações CRUD.
  - `child_service.dart`: Serviço responsável pelas operações relativas às crianças.
  - `vaccine_service.dart`: Serviço responsável pelas operações com as vacinas.
- `components/`: Contém os componentes do projeto.

## Tecnologias

- **Front-end**: Flutter
- **Back-end**: json-server para simular uma API RESTful com armazenamento em JSON

## Pré-requisitos

- Flutter SDK
- Node.js (para rodar o json-server)

## Rodar o Projeto

1. Clone o repositório:

   ```bash
   git clone https://github.com/cassiab13/aplicativo_mobile.git

2. Navegue até a pasta do aplicativo Flutter e execute o projeto:
 - cd aplicativo
 - flutter run

3. Navegue até a pasta backend/api e execute o json-server:
  - cd backend/api
  - npx json-server db.json

O json-server estará rodando na URL http://localhost:3000 para o back-end.
