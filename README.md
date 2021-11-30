# otus-project


## Проект  

## Цель: Создание рабочего проекта

    Веб проект с развертыванием нескольких виртуальных машин должен отвечать следующим требованиям:

    включен https;
    основная инфраструктура в DMZ зоне;
    файрвалл на входе;
    сбор метрик и настроенный алертинг;
    везде включен selinux;
    организован централизованный сбор логов.

---

## Тема: развертывание веб-приложения Mattermost

### Схема стенда

![](https://github.com/MaxOOOOON/otus-project/blob/main/pictures/project-otus.jpg)  


Установка дополнительных коллекций из ansible-galaxy
    
    ansible-galaxy collection install community.mysql

Стенд запускается с помощью команды 

    vagrant up 

Также необходимо прописать в файле hosts строку 

    127.0.0.1       otus-messenger.com

Веб-сайт доступен по следующей ссылке

    https://otus-messenger.com:8080

### Интерфейс приложения

![](https://github.com/MaxOOOOON/otus-project/blob/main/pictures/Screenshot_20211130_185753.png)  


## Формирование ролей

### Используются следующие роли:

- backup-client - установка borg и сервиса, который будет периодически бэкапить mysql;
- backup-server - установка borg;
- log-client - установка плагинов для rsyslog;
- log-server - настройка rsyslog для сбора логов;
- monitoring - установка и настройка Prometheus + Grafana;
- monitoring-node - установка экспортеров для Prometheus;
- mysql - установка и настройка Percona MySQL для веб приложения;
- mysql-slave - создание сервера репликации MySQL;
- router - настройка файерволла.
- web - установка веб приложения и настройка nginx.


### Данные роли были назначены группам серверов следующим образом:

**backup-client:**
slave 

**backup-server:**
backupserver

**log-client:**
web, mysql, slave, backupserver

**log-server:**
log

**monitoring:**
monitoring

**monitoring-node:**
web, mysql, backupserver, log

**mysql:**
mysql

**mysql-slave:**
slave

**router:**
inetRouter

**web:**
web


На nginx запросы проксируются на порт 8065




Дашборд из графаны

![](https://github.com/MaxOOOOON/otus-project/blob/main/pictures/Screenshot_20211130_185734.png)  

Настроен алертинг в телеграм, при использовании процессора >80%

![](https://github.com/MaxOOOOON/otus-project/blob/main/pictures/Screenshot_20211130_182127.png)  



Grafana доступна по следующей ссылке

    http://localhost:8888

Prometheus
    
    http://localhost:8889/targets









Заметки             

mysql

use mattermost;
show tables;
select * from Users\G;


systemctl start backup-db.service
borg list /var/backup/mysql/


dd if=/dev/urandom | bzip2 -9 > /dev/null
