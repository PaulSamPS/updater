REMOTE_USER=root
REMOTE_HOST="195.133.1.164"
REMOTE_PATH="/root/Desktop/updater/updates/"
LOCAL_DIRECTORY="./updates/1"

ssh $REMOTE_USER@$REMOTE_HOST << EOF
  mkdir -p $REMOTE_PATH
  rm -rf ${REMOTE_PATH}*
EOF

if [ $? -ne 0 ]; then
    echo "Ошибка при выполнении команд на удаленном сервере."
    exit 1
fi

scp -r ${LOCAL_DIRECTORY}* $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH

if [ $? -eq 0 ]; then
    echo "Файлы успешно загружены на удаленный сервер."
else
    echo "Ошибка при загрузке файлов на удаленный сервер."
fi