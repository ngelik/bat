@echo off

@rem Имя локального пользователя, под которым будетм работать
set user_name=user_name
@rem Пароль для локального пользователя
set user_passw=
@rem Имя запланированного задание, под которым будет работать приложение
set task_name=rabbitmq.logrotate
@rem Путь к приложению
set my_app_path="d:\RabbitMQ\install\logrotate_rabbitmq.bat "
@rem Интервал работы приложения во временном задании
set schtasks_time=DAILY
set schtasks_time_intervale=1
@rem Начальное время старта приложения во временном задании
set schtasks_start=00:00:01

@REM Создание запланированного задания
@rem  Valid schedule types: MINUTE, HOURLY, DAILY, WEEKLY, MONTHLY, ONCE, ONSTART, ONLOGON, ONIDLE.
@rem ЕЖЕМИНУТНО, ЕЖЕЧАСНО, ЕЖЕДНЕВНО, ЕЖЕНЕДЕЛЬНО, ЕЖЕМЕСЯЧНО ПРИ ЗАПУСКЕ ВХОДЕ В СИСТЕМУ ПРИ ПРОСТОЕ
schtasks /create /tn "%task_name%" /tr %my_app_path% /sc %schtasks_time% /MO %schtasks_time_intervale% /st %schtasks_start% /ru %user_name% /rp %user_passw%

