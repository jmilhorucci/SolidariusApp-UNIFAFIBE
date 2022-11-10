# SolidariusApp-UNIFAFIBE

Solidariu's App

## Configuração

- Para ter acesso a API, por favor, entrar em contato pelo e-mail "solidariusapp@outlook.com" solicitando o acesso
- Acesse o arquivo `.base.service.dart` e substitua o "###########"; pela credenciais enviada pelo administrador do sistema
- Para ter acesso ao mapa do aplicativo, renomeie o arquivo `.env.example` para `.env`
- Substitua as credenciais no `.env` pelas [chaves de API do Google Maps](https://console.cloud.google.com/google/maps-apis/credentials)

## Observações

- Execute o projeto no Android (versão 10 API level 29 ou superior)
- Recomenda-se utilizar o app em telas 6.3" ou superior com densidade de tela 392dpi ou superior (testado até 460dpi)

## Capturas de tela

<div align=center>
  <img width="250em" src="https://user-images.githubusercontent.com/44588590/201185221-dfafb2e9-e5cd-4e0e-ae8f-a49edcb2b2b9.jpg"/>
  <img width="250em" src="https://user-images.githubusercontent.com/44588590/201185224-108af144-bf8f-488f-883a-57c1bcb46b9d.jpg"/>
  <img width="250em" src="https://user-images.githubusercontent.com/44588590/201185225-4f8324cc-4356-413a-a06c-76e952dcc4dc.jpg"/>
</div>

<div>
  <h2>Paleta de Cores</h2>
  
  <p><b>ROXO</b></p>
  <p>#A020F0 (primary)</p>
  <p>#9500FF</p>
  <p>#8705FA</p>
  <p>#7C2AE8</p>
  <p>#B354EF</p>

  <p><b>VERDE</b></p>
  <p>#4EC1C1 (primary)</p>
  <p>#57D7D7</p>
  <p>#6FEBEB</p>
  
</div>

<div>
  
  <h2>Terminal</h2>
  <p>No terminal, execute os seguintes comandos para visualizar a:</p>
  
  <h3>Versão do Flutter e Dart</h3>
  
  <p>Linha de Comando:</p>
  
  <pre><code>
    flutter doctor -v
  </pre></code>
  
  <p>Retorno:</p>
  
  <pre><code>
  
    [✓] Flutter (Channel master, 3.4.0-19.0.pre.153, on Microsoft Windows [versÆo 10.0.19044.2130], locale pt-BR)
    • Flutter version 3.4.0-19.0.pre.153 on channel master at C:\tools\flutter
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision d2434a2b60 (9 weeks ago), 2022-09-08 15:39:07 -0700
    • Engine revision 4096e133ef
    • Dart version 2.19.0 (build 2.19.0-177.0.dev)
    • DevTools version 2.17.0

    Checking Android licenses is taking an unexpectedly long time...[✓] Android toolchain - develop for Android devices (Android SDK version 32.0.0)
        • Platform android-33, build-tools 32.0.0
        • Java binary at: C:\Program Files\Android\Android Studio\jre\bin\java
        • Java version OpenJDK Runtime Environment (build 11.0.12+7-b1504.28-7817840)
        • All Android licenses accepted.

    [✓] Chrome - develop for the web
        • Chrome at C:\Program Files (x86)\Google\Chrome\Application\chrome.exe

    [✓] Visual Studio - develop for Windows (Visual Studio Professional 2019 16.11.16)
        • Visual Studio at C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional
        • Visual Studio Professional 2019 version 16.11.32602.291
        • Windows 10 SDK version 10.0.18362.0

    [✓] Android Studio (version 2021.2)
        • Android Studio at C:\Program Files\Android\Android Studio
        • Flutter plugin can be installed from:
        🔨 https://plugins.jetbrains.com/plugin/9212-flutter
        • Dart plugin can be installed from:
        🔨 https://plugins.jetbrains.com/plugin/6351-dart
        • Java version OpenJDK Runtime Environment (build 11.0.12+7-b1504.28-7817840)

    [✓] VS Code (version 1.73.1)
        • Flutter extension version 3.52.0

    [✓] VS Code, 64-bit edition (version 1.69.2)
        • VS Code at C:\Program Files\Microsoft VS Code
        • Flutter extension version 3.52.0

    [✓] Connected device (4 available)
        • M2102J20SG (mobile) • cdbb665 • android-arm64  • Android 12 (API 31)
        • Windows (desktop)   • windows • windows-x64    • Microsoft Windows [versÆo 10.0.19044.2130]
        • Chrome (web)        • chrome  • web-javascript • Google Chrome 107.0.5304.88
        • Edge (web)          • edge    • web-javascript • Microsoft Edge 105.0.1343.53

    [✓] HTTP Host Availability
        • All required HTTP hosts are available

</code></pre>

<h3>Execução</h3>
  
  <p>Linha de Comando:</p>
  
  <pre><code>
    flutter clean
  </code></pre>
  <pre><code>
    flutter run
  </code></pre>

</div>
