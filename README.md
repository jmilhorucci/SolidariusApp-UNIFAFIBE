# SolidariusApp-UNIFAFIBE

Solidariu's App - Aplicativo para engajamento de doações

## Configuração

- Para ter acesso a API, por favor, entrar em contato pelo e-mail "solidariusapp@outlook.com" solicitando o acesso
- Acesse o arquivo `.base.service.dart` e substitua o "###########"; pela credenciais enviada pelo administrador do sistema
- Para ter acesso ao mapa do aplicativo, renomeie o arquivo `.env.example` para `.env`
- Substitua as credenciais no `.env` pelas [chaves de API do Google Maps](https://console.cloud.google.com/google/maps-apis/credentials)

## Observações

- Execute o projeto no Android (versão 10 API level 29 ou superior)
- Recomenda-se utilizar o app em telas 6.3" ou superior com densidade de tela 392dpi ou superior (testado até 460dpi)

## Capturas de Tela

<div align=center>
  <img width="250em" src="https://user-images.githubusercontent.com/44588590/201185221-dfafb2e9-e5cd-4e0e-ae8f-a49edcb2b2b9.jpg"/>
  <img width="250em" src="https://user-images.githubusercontent.com/44588590/201185224-108af144-bf8f-488f-883a-57c1bcb46b9d.jpg"/>
  <img width="250em" src="https://user-images.githubusercontent.com/44588590/201185225-4f8324cc-4356-413a-a06c-76e952dcc4dc.jpg"/>
</div>

<div>
  <h2>Paleta de Cores</h2>
  
  <div align=center>
    <h4>ROXO</h4>
    <img width="1024em" src="https://user-images.githubusercontent.com/44588590/201454708-b68ff8b6-b3b0-47da-993a-b81e4e903827.png"/>
    <h4>VERDE</h4>
    <img width="1024em" src="https://user-images.githubusercontent.com/44588590/201454676-a7006fa9-1f63-41f0-a652-822abb363582.png"/>
  </div>
  
</div>

<div>
  
  <h2>Terminal</h2>
  <p>No terminal, execute os seguintes comandos para visualizar a:</p>
  
  <h3>Versões</h3>
  
  <h4>Flutter e Dart</h4>
  
  - <small>Linha de Comando:</small>
  
  ```
    $flutter doctor -v
  ```
  
  - <small>Retorno:</small>
  
  ```
    [✓] Flutter (Channel master, 3.4.0-19.0.pre.153, on Microsoft Windows [versÆo 10.0.19044.2130], locale pt-BR)
        • Flutter version 3.4.0-19.0.pre.153 on channel master at C:\tools\flutter
        • Upstream repository https://github.com/flutter/flutter.git
        • Framework revision d2434a2b60 (9 weeks ago), 2022-09-08 15:39:07 -0700
        • Engine revision 4096e133ef
        • Dart version 2.19.0 (build 2.19.0-177.0.dev)
        • DevTools version 2.17.0

    [✓] Checking Android licenses is taking an unexpectedly long time...[✓] Android toolchain - develop for Android devices (Android SDK version 32.0.0)
        • Platform android-33, build-tools 32.0.0
        • Java binary at: C:\Program Files\Android\Android Studio\jre\bin\java
        • Java version OpenJDK Runtime Environment (build 11.0.12+7-b1504.28-7817840)
        • All Android licenses accepted.

    [✓] Android Studio (version 2021.2)
        • Android Studio at C:\Program Files\Android\Android Studio
        • Flutter plugin can be installed from:
        🔨 https://plugins.jetbrains.com/plugin/9212-flutter
        • Dart plugin can be installed from:
        🔨 https://plugins.jetbrains.com/plugin/6351-dart
        • Java version OpenJDK Runtime Environment (build 11.0.12+7-b1504.28-7817840)
  ```

<h3>Execução</h3>

- <small>Linha de Comando:</small>
  
  ```
    $flutter clean
    $flutter run
  ```
  
</div>

<h2>URLs</h2>

- [API - Swagger UI](http://3.209.132.93:9812/swagger/index.html) - Documentação da API do projeto
