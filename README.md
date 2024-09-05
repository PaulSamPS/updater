### *Установка зависимостей*

```shell
    yarn install
```

### *Настройка окружения*

1. ###### *Добавить в package.json 'scripts' мобильного приложения'*
    ```json
      "expo-update": "npx expo export && node ./scripts/exportClientExpoConfig.js > dist/expoConfig.json && ./scripts/gzip.sh"
    ```

2. ###### *Переместить папку scripts  в корень мп*

    ```javascript
    exportClientExpoConfig.js
   gzip.sh

3. ###### *Относительный путь папки scripts до папки мп*

    ```javascript
    const projectDir = path.join(__dirname, '..', '..', 'имя__папки_мп');
    ```
   
4. ###### *В мобильном приложении в* `app.json` *добавить:*
   ```json
     "updates": {
      "url": "http://10.0.2.2:5000/api/manifest",
      "fallbackToCacheTimeout": 30000,
      "enabled": true,
      "codeSigningCertificate": "./code-signing/development-certificate.pem",
      "codeSigningMetadata": {
        "keyid": "main",
        "alg": "rsa-v3-sha256"
      }
   ```

5. ###### *Переместить папку code-signing в корень мп*

6. ###### *Установить зависимости в мп*

### *Подготовка обновления*
#### *указать в gzip.sh UPLOAD_URL="http://`адрес сервера`/api/update*
```shell
# запуск скрипта из мп
  npm run expo-update
```

### *Запуск сервера*

```shell
   yarn start
```
