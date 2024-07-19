#while getopts d: flag
#do
#    case "${flag}" in
#        d) directory=${OPTARG};;
#    esac
#done
#
#cd ../expo-updates-client
#npx expo export
#cd ../expo-updates-server
#rm -rf updates/$directory/
#cp -r ../expo-updates-client/dist/ updates/$directory
#
#node ./scripts/exportClientExpoConfig.js > updates/$directory/expoConfig.json

while getopts d: flag
do
    case "${flag}" in
        d) directory=${OPTARG};;
    esac
done

cd ../expo-updates-client
npx expo export
cd ../expo-updates-server
rm -rf updates/$directory/
cp -r ../expo-updates-client/dist/ updates/$directory

# Создаем функцию для выполнения команды node и ожидания её завершения
run_node_script() {
    node ./scripts/exportClientExpoConfig.js > updates/$directory/expoConfig.json
}

# Запускаем функцию и ждем её завершения
run_node_script &
wait

echo "Скрипт выполнен успешно и expoConfig.json создан."

#!/bin/bash
#
## Получение параметра directory
#while getopts d: flag
#do
#    case "${flag}" in
#        d) directory=${OPTARG};;
#    esac
#done
#
## Установка переменных
#project_folder=/home/luanphung/expo-server
#dest_dir=$project_folder/$directory/$CURRENT_VERSION/$NEW_EXPO_BUILD_NUMBER
#SERVER=ubuntu@your-server-ip
#zipfile=expo_update
#
## Экспорт кода и копирование необходимых файлов в dist каталог
#cd ../expo-updates-client
#npx expo export > /dev/null
#cd ../expo-updates-server
#node ./scripts/exportClientExpoConfig.js > updates/$directory/expoConfig.json
#
## Создание zip архива из dist каталога, чтобы ускорить копирование файлов на сервер
#(cd ../expo-updates-client/dist && zip -r "$OLDPWD/$zipfile.zip" . > /dev/null)
#
#if [[ $? -ne 0 ]]; then
#  echo "Ошибка при создании zip архива"
#  exit 1
#fi
#
## Создание каталога на сервере
#ssh -t $SERVER "
#mkdir -p $dest_dir"
#
## Копирование zip файла на сервер
#scp $zipfile.zip $SERVER:$dest_dir
#if [[ $? -ne 0 ]]; then
#  echo "Ошибка при копировании zip файла"
#  exit 1
#fi
#
## Разархивирование файла на сервере
#ssh -t $SERVER "
#cd $dest_dir &&
#unzip $zipfile.zip > /dev/null &&
#rm ./$zipfile.zip &&
#rm $zipfile.zip
#"
#
## Очистка локального zip файла
#rm -rf $zipfile.zip
#
## Копирование обновленных файлов
#rm -rf updates/$directory/
#cp -r ../expo-updates-client/dist/ updates/$directory
#
#echo "Деплой завершен успешно"
