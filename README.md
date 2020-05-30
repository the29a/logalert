# Logalert

Скрипт для отправки логов разным транспортом.

## E-mail:
Требуются пакеты mailutils и postfix.
```
sudo apt update
sudo apt install mailutils postfix
```


## Telegram:
C Telegram всё сложнее, так как доступ к api зароскомнадзорен.
Нам потребуется tor.

```
sudo apt install tor
```
Запускаем и добавляем в автозапуск
```
sudo sytemctl start tor
sudo sytemctl enable tor
```

Создаем через https://t.me/botfather бота и получаем токен.
Находим через поиск нашего бота и "скармливаем" команду /start, после чего получаем chat_id диалога
```
torify curl https://api.telegram.org/bot876875234:BBSG4GZcUHkFhAJDaDsc8hH6u-pO-LQALPQ0/getUpdates
```

## chmod и cron

Делаем скрипт исполняемым:
```
chmod +x logalert.tg.sh
chmod +x logalert.mail.sh
```

Добавляем скрипт в cron:
```
crontab -e
0 7 * * * /bin/bash logalert.mail.sh
0 7 * * * /bin/bash logalert.tg.sh
```


## TODO:  

[ X ] Добавить скрипт для Telegram  
[   ] Доделать скрипт для Telegram  
[   ] Добавить проверку на зависимости и наличие в crontab.  
