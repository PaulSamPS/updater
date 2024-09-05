SOURCE_DIR="./dist"  # Путь к папке, которую нужно архивировать
OUTPUT_FILE="update.gz"  # Имя файла архива
UPLOAD_URL="http://localhost:5000/api/update"  # URL для загрузки

# Создание gzip архива из папки
# Сначала создадим временный архив с содержимым папки (без сжатия)
TEMP_ARCHIVE="update_temp.tar"
tar -cf $TEMP_ARCHIVE -C $SOURCE_DIR .

# Затем сжимаем архив с помощью gzip
gzip -c $TEMP_ARCHIVE > $OUTPUT_FILE

# Удаляем временный архив
rm $TEMP_ARCHIVE

# Проверка, что архив был успешно создан
if [ $? -eq 0 ]; then
  echo "Архив успешно создан: $OUTPUT_FILE"
else
  echo "Ошибка при создании архива"
fi

# Отправка архива через POST запрос
curl -X POST $UPLOAD_URL \
     -H "Content-Type: multipart/form-data" \
     -F "file=@$OUTPUT_FILE"

# Проверка успешности отправки
if [ $? -eq 0 ]; then
  echo "Архив успешно отправлен"
  # Удаляем архив после успешной отправки
  rm $OUTPUT_FILE
else
  echo "Ошибка при отправке архива"
fi

# Ожидание ввода от пользователя, чтобы окно не закрылось сразу
echo "Нажмите любую клавишу для выхода..."
read -n 1 -s
