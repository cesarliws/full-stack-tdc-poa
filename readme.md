# Full stack Delphi MVC Framework and React.js DevExtreme Project

## [Clique aqui para instruções em Português](leiame.md)

Project source files from my TDC presentation.
The Developer Conference 2018 - Brazil - Delphi Track

Back-end: Delphi + DMVC Framework + FireDAC + PostgreSQL
Front-end: JS ES6 + React + DevExpress DevExtreme

## Presentation Theme

Introduction to web and cloud platform.

How to create a simple, efficient, high performance and easy to maintain back-end server with Delphi MVC Framework.

How to create web front-end quickly with React.js library, to consume the back-end created with Delphi MVC Framework.

* Introduction to Web and Cloud Platform
* RESTful Server with DMVC Framework, FireDAC and PostgreSQL
* Introduction to JavaScript front-end Development with React.js

## Project Demo

* Front-end built with DevExpress DevExtreme, code, data and imagens from existing example:
    https://js.devexpress.com/Demos/WidgetsGallery/Demo/Common/DialogsAndNotificationsOverview/React/Light

![Main Window](./images/screenshot_1.png)
![Edit Window](./images/screenshot_2.png)

## Instructions

### Clone repository

* git clone https://github.com/cesarliws/full-stack-tdc-poa.git

### Restore Database backup - PostgreSQL

* dmvc-backend\db\dmvc-backend-db.backup

### Install Delphi MVC Framework

* https://danieleteti.gitbooks.io/delphimvcframework/content/chapter_getting_started.html
* Compile and run the project "dmvc-backend\ReadStateBackEnd.dproj" with Delphi

### Front-end

* Install Node.js
  * https://nodejs.org/en/download/

* cd full-stack-tdc-poa\dx-real-state-front-end

### npm or yarn

* You can use npm or yarn to install dependencies and execute the front-end.
* Yarn has better performance.

#### npm

* Install project dependencies
  * npm install

* Run front-end
  * npm start

#### or, yarn

* Install yarn
  * npm install yarn

* Install project dependencies
  * yarn

* Run front-end
  * yarn run start

### Run only the front-end

* Edit the "dx-real-state-front-end\src\App.js" file.
* Change "remoteDataSource" to false inside the constructor.

![state.remoteDataSource](./images/remote-datasource.png)