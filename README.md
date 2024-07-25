## *Установка зависимостей*

```bash
    yarn install
```

## *Настройка окружения*
*Это делается при один раз и больше не изменяется!*

1. *Укажите путь до приложения, откуда скрипт заберет данные:*
    ```javascript
    // scripts/xportClientExpoConfig.js
    const projectDir = 'путь/до/вашего/приложения';
    ```

2. *Укажите адрес сервера обновлений:*

    ```dotenv
    HOSTNAME=адрес/сервера/обновлений;
    ```

## *Подготовка обновления вариант 1*
+ <span style="color:#edeb5c">*Этот вариант более предпочтительный т.к нету смысла хранить предыдущие обновления тут*

+ <span style="color:#fc6656">**Название папки вложенная в updates обзяаательно должна совпадать с текущей версией runtimeVersion!!!**

В `package.json` `expo-config` *захардкодить* `runtimeVersion` и `updateVersion`:

`Пример:`
```json
{
   "expo-config": "node ./scripts/exportClientExpoConfig.js > updates/1/latest/expoConfig.json"
}
```

В `package.json` `expo-publish` *захардкодить* `runtimeVersion` и `updateVersion`:

*Пример:*
```json
{
   "expo-config": "./scripts/publish.sh -d 1/latest && yarn expo-config"
}
```

## *Подготовка обновления вариант 2*

*Создать папку в* `updates` *с текущей версией* `runtime`.  

*Закоментировать в* `scripts/publish.sh` *строчку* `rm -rf updates/$directory/`

В `package.json` `expo-config` указать `runtimeVersion` и `updateVersion`:

`Пример:`
```json
{
   "expo-config": "node ./scripts/exportClientExpoConfig.js > updates/runtimeVersion/updateVersion/expoConfig.json"
}
```

В `package.json` `expo-publish` *указать* `runtimeVersion` и `updateVersion`:

*Пример:*
```json
{
   "expo-config": "./scripts/publish.sh -d runtimeVersion/updateVersion && yarn expo-config"
}
```

## *Запуск генерации обновления*
   ```bash
    yarn expo-publish
   ```

## *Получение нового обновления на удаленном сервере*
1. *Получить последние обновления с репозитория* `git pull`.
2. *Запустить сервер* `yarn dev`.

## <span style="color:#7BD169">*TODO*
<span style="color:#7BD169">1. *Загружать обновления скриптом сразу на сервер.*
