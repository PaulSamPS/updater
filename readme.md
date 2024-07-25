# Проект

## Настройка окружения

1. Укажите путь до приложения, откуда скрипт заберет данные:
    - Откройте файл `scripts/xportClientExpoConfig.js` и укажите путь до приложения.
    ```javascript
    // scripts/xportClientExpoConfig.js
    const projectDir = 'путь/до/вашего/приложения';
    ```

2. Укажите адрес, где будет лежать обновление:
    - В файле `env.local` укажите значение `HOSTNAME`.
    ```dotenv
    HOSTNAME=адрес_сервера_где_будет_лежать_обновление
    ```

## Создание обновления

в package.json expo-config указать `runtimeVersion` и `updateVersion`:

`node ./scripts/exportClientExpoConfig.js > updates/runtimeVersin/updateVersion/expoConfig.json`

Для создания обновления выполните следующую команду:
```bash
yarn expo-updates
