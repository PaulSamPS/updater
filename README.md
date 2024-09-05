### *Установка зависимостей*

```shell
    yarn install
```

### *Настройка окружения*
>**Это делается один раз при первом запуске и больше не изменяется!**

1. ###### *Добавить в package.json 'scripts' мобильного приложения'*
    ```json
      "expo-update": "npx expo export && node ./scripts/exportClientExpoConfig.js > dist/expoConfig.json"
    ```

2. ###### *Переместить из папки scripts в папку scripts  в корне мп*

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

### *Подготовка обновления*
1. 
```shell
  npm run expo-update
```

2. 
  #### *запустить скрипт gzip.sh предварительно указав UPLOAD_URL="http://`адрес сервера`/api/update*

### *Запуск сервера*

```shell
   yarn start
```
