### *Установка зависимостей*

```bash
    yarn install
```

### *Настройка окружения*
>**Это делается один раз при первом запуске и больше не изменяется!**

1. ###### *Укажите путь до приложения, откуда скрипт заберет данные:*
    ```javascript
    // scripts/xportClientExpoConfig.js
    const projectDir = 'путь/до/вашего/приложения';
    ```

2. ###### *Укажите адрес сервера обновлений:*

    ```dotenv
   # http://10.0.2.2:5000
    HOSTNAME=адрес/сервера/обновлений;
    ```
3. ###### *В скрипте* `scripts/publish.sh` *указать свои данные*

   ```shell
   // Путь и название мобильного приложения
   cd ../superapp
   
   // Название папки сервера 
   cd ../updater
   
   // Название мобильного приложения
   cp -r ../superapp/dist/ updates/$directory
   ```
4. ###### *В скрипте* `scripts/copyToServer.sh` *указать свои данные для подключения к серверу по ssh*

   ```dotenv
   # Имя пользователя
   REMOTE_USER=root
   # Адрес сервера
   REMOTE_HOST="128.0.0.1"
   # Путь до папки сервера
   REMOTE_PATH="/root/Desktop/updater/updates/"
   ```
5. ###### *В мобильном приложении в* `app.json` *добавить:*
   ```json
     {
        "runtimeVersion": "1",
        "updates": {
        "url": "http://адрес сервера/api/manifest",
        "fallbackToCacheTimeout": 30000
        }
     }
   ```

### *Подготовка обновления вариант `1`*
+ <span style="color:#edeb5c">*Этот вариант более предпочтительный т.к нету смысла хранить предыдущие обновления тут*

+ <span style="color:#fc6656">**Название папки вложенная в updates обзяаательно должна совпадать с текущей версией `runtimeVersion` в мп app.json!!!**

В `package.json` `expo-config` *захардкодить* `runtimeVersion` и `updateVersion`:

###### *Пример:*
```json
{
   "expo-config": "node ./scripts/exportClientExpoConfig.js > updates/1/latest/expoConfig.json"
}
```

В `package.json` `expo-publish` *захардкодить* `runtimeVersion` и `updateVersion`:

###### *Пример:*
```json
{
   "expo-config": "./scripts/publish.sh -d 1/latest && yarn expo-config"
}
```

### *Подготовка обновления вариант `2`*

###### *Создать папку в* `updates` *с текущей версией* `runtime`.  

###### *Закоментировать в* `scripts/publish.sh` *строчку* `rm -rf updates/$directory/`

###### В `package.json` `expo-config` указать `runtimeVersion` и `updateVersion`:

###### *Пример:*
```json
{
   "expo-config": "node ./scripts/exportClientExpoConfig.js > updates/runtimeVersion/updateVersion/expoConfig.json"
}
```

###### В `package.json` `expo-publish` *указать* `runtimeVersion` и `updateVersion`:

###### *Пример:*
```json
{
   "expo-config": "./scripts/publish.sh -d runtimeVersion/updateVersion && yarn expo-config"
}
```

### *Запуск генерации обновления и копирование на сервер*
   ```shell
   # Создает локально файлы обновления
    yarn expo-publish   
   ```

   ```shell
   # Копирует файлы на сервер
      yarn export-server
   ```
    
### *Получение нового обновления на удаленном сервере*  
###### *Запустить сервер* `yarn dev`.

