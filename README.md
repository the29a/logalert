# Logalert

Скрипт для отправки логов разным транспортом.

## E-mail:
Требуются пакеты mailutils и postfix.
```
sudo apt update
sudo apt install mailutils postfix
```


## Telegram:
Создаем через https://t.me/botfather бота и получаем токен.
Находим через поиск нашего бота и "скармливаем" команду /start, после чего получаем chat_id диалога
```
curl https://api.telegram.org/bot876875234:BBSG4GZcUHkFhAJDaDsc8hH6u-pO-LQALPQ0/getUpdates
```
Или получаем id чата, указав @channelName
```
curl https://api.telegram.org/bot876875234:BBSG4GZcUHkFhAJDaDsc8hH6u-pO-LQALPQ0/sendMessage?chat_id=@channelName&text=Test
```

## Discord:

В настройках сервера открываем вкладку "Интеграция", нажимаем "новый вебхук" указываем название вебхука и  выбираем канал, куда будут приходить запросы. 

```
curl -H "Content-Type: application/json" -X POST -d '{"username": "Тест", "content": "Привет!"}' https://discordapp.com/api/webhooks/203019812404264973/rptBmYgoehu70kw2rItSlhRqKi7kMJh1bM2KCUUD2vR6grZckvtdl62h4xR7XWUS5463
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



## Дополнительные ссылки:

[discord-webhooks-guide[EN]](https://birdie0.github.io/discord-webhooks-guide/)
[discord-webhooks-gude [RU]](https://darkpro1337.github.io/discord-webhooks/)
[Использование Webhooks Discord](https://support.discord.com/hc/ru/articles/228383668-%D0%98%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-Webhooks)

## TODO:  

[ X ] Добавить скрипт для Telegram  
[   ] Доделать скрипт для Telegram  
[   ] Добавить проверку на зависимости и наличие в crontab.  

