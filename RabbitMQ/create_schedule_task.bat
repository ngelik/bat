@echo off

:: ***********************************************************************************************
:: Задаем значения переменных
:: ***********************************************************************************************
:: Текущий путь
set current_path=d:\RabbitMQ\install

:: Имя локального пользователя, под которым будем работать
set user_name=rabbitmq
:: Пароль для локального пользователя
set user_passw=Pa$$w0rd

:: Имя запланированного задание, под которым будет работать приложение
set task_name=rabbitmq.logrotate
:: Путь к приложению
set my_app_path="d:\RabbitMQ\install\logrotate_rabbitmq.bat "
:: Интервал работы приложения во временном задании
set schtasks_time=DAILY
set schtasks_time_intervale=1
:: Начальное время старта приложения во временном задании
set schtasks_start=23:59:00

:: ***********************************************************************************************
:: В зависимости от языка ОС определяем имена системных параметров
:: ***********************************************************************************************
:: S-1-5-32-545 - локальные пользователи
:: S-1-5-32-544 - администраторы
Set GroupSID=S-1-5-32-545
Set GroupName=
For /F "UseBackQ Tokens=1* Delims==" %%I In (`WMIC Group Where "SID = '%GroupSID%'" Get Name /Value ^| Find "="`) Do Set GroupName=%%J
Set GroupName=%GroupName:~0,-1%
:: ***********************************************************************************************

:: Создание пользователя
net user %user_name% %user_passw% /add  /comment:"Simple user with Batch logon privilege for rotation RabbitMQ logs. Don't delete!" /expires:never /fullname:%user_name% /passwordchg:no
:: Устанавливаем, чтобы пароль не истекал никогда
:: Либо так - wmic path Win32_UserAccount where Name='%user_name%' set PasswordExpires=false
wmic USERACCOUNT where Name='%user_name%' set PasswordExpires=false
:: Добавление локального пользователя в заданную локальную группу
net localgroup %GroupName% %user_name% /ADD

:: ***********************************************************************************************
:: Даем свежесозданному пользователю права Batch logon privilege
:: ***********************************************************************************************
%current_path%\tools\ntrights.exe -u %user_name% +r SeBatchLogonRight

:: Создание запланированного задания
::  Valid schedule types: MINUTE, HOURLY, DAILY, WEEKLY, MONTHLY, ONCE, ONSTART, ONLOGON, ONIDLE.
:: ЕЖЕМИНУТНО, ЕЖЕЧАСНО, ЕЖЕДНЕВНО, ЕЖЕНЕДЕЛЬНО, ЕЖЕМЕСЯЧНО ПРИ ЗАПУСКЕ ВХОДЕ В СИСТЕМУ ПРИ ПРОСТОЕ
schtasks /create /tn "%task_name%" /tr %my_app_path% /sc %schtasks_time% /MO %schtasks_time_intervale% /st %schtasks_start% /ru %user_name% /rp %user_passw%

