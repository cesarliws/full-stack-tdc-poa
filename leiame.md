# Projeto full stack Delphi MVC Framework e DevExtreme React.js

## [Click here for English instructions](readme)

Arquivos fontes do projeto da minha apresentação no TDC.
The Developer Conference 2018, Porto Alegre - Brasil - Trilha Delphi

Back-end: Delphi + DMVC Framework + FireDAC + PostgreSQL
Front-end: JS ES6 + React + DevExpress DevExtreme

## Tema da Apresentação

Introdução as plataformas web e cloud.

Como criar um servidor back-end cloud com Delphi MVC Framework simples, eficiente, alta performance e de fácil manutenção.

Como criar front-end web rapidamente com a biblioteca React.js, para consumir o backend criado com Delphi MVC Framework.

* Introdução a Plataforma Web e Cloud
* Servidor RESTful  com DMVC Framework e FireDAC
* Introdução ao Desenvolvimento frontend JavaScript com React.js

## Projeto Exemplo

* Front-end construído com DevExpress DevExtreme, código, registros e imagens do exemplo existente em:
    https://js.devexpress.com/Demos/WidgetsGallery/Demo/Common/DialogsAndNotificationsOverview/React/Light

![Main Window](./images/screenshot_1.png)
![Edit Window](./images/screenshot_2.png)

## Instruções

### Clonar repositório

* git clone https://github.com/cesarliws/full-stack-tdc-poa.git

### Restaurar o backup do banco de dados - PostgreSQL

* dmvc-backend\db\dmvc-backend-db.backup

### Instalar Delphi MVC Framework

* https://danieleteti.gitbooks.io/delphimvcframework/content/chapter_getting_started.html
* Compilar e executar o projeto "dmvc-backend\ReadStateBackEnd.dproj" com o Delphi

### Front end

* Instalar Node.js
  * https://nodejs.org/en/download/

* cd full-stack-tdc-poa\dx-real-state-front-end

#### npm

* Instalar as dependências do projeto
  * npm install

* Executar o front-end
  * npm start

ou:

#### yarn

* Instalar yarn
  * npm install yarn

* Instalar as dependências do projeto
  * yarn

* Executar o front-end
  * yarn run start

### Executar somente o front-end

* "dx-real-state-front-end\src\App.js"
* Alterar remoteDataSource para false no constructor.

![state.remoteDataSource](./images/remote-datasource.png)