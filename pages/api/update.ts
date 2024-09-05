import formidable from 'formidable';
import fs from 'fs';
import type { NextApiRequest, NextApiResponse } from 'next';
import path from 'path';
import * as tar from 'tar'; // Обратите внимание на импорт с использованием '* as tar'
import zlib from 'zlib';

export const config = {
  api: {
    bodyParser: false, // Отключаем встроенный парсер, чтобы использовать formidable
  },
};

export default async function update(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === 'POST') {
    const form = formidable();

    // Парсим запрос для получения файла
    form.parse(req, async (err, fields, files) => {
      if (err) {
        res.status(500).json({ error: 'Ошибка при парсинге запроса' });
        return;
      }

      // Проверяем, что файл был загружен
      const fileArray = files.file as formidable.File[] | formidable.File | undefined;
      if (!fileArray) {
        res.status(400).json({ error: 'Файл не найден в запросе' });
        return;
      }

      // Если пришел массив, берем первый элемент, иначе используем сам объект
      const file = Array.isArray(fileArray) ? fileArray[0] : fileArray;

      if (!file) {
        res.status(400).json({ error: 'Файл не найден в запросе' });
        return;
      }

      // Указываем путь для распакованного архива
      const outputDir = path.join(process.cwd(), 'updates');

      // Убедимся, что директория существует
      if (!fs.existsSync(outputDir)) {
        fs.mkdirSync(outputDir, { recursive: true });
      }

      // Распаковываем GZIP-файл и сохраняем содержимое в outputDir
      const gzipFilePath = file.filepath; // путь к загруженному файлу
      const inputStream = fs.createReadStream(gzipFilePath);
      const unzip = zlib.createGunzip();

      // Используем tar для распаковки содержимого tar архива после распаковки gzip
      inputStream
        .pipe(unzip)
        .pipe(tar.x({ cwd: outputDir }))
        .on('finish', () => {
          console.log('Распаковка завершена'); // Логируем успешное завершение
          res.status(200).json({ message: 'Файлы успешно распакованы', path: outputDir });
        })
        .on('error', (err) => {
          console.error('Ошибка при распаковке файла:', err); // Логируем ошибку
          res.status(500).json({ error: 'Ошибка при распаковке файла' });
        });

      // Логирование потока для отладки
      inputStream.on('data', (chunk) => {
        console.log('Чтение данных из файла...');
      });

      unzip.on('data', (chunk) => {
        console.log('Распаковка данных...');
      });
    });
  } else {
    res.status(405).json({ error: 'Метод не поддерживается' });
  }
}
