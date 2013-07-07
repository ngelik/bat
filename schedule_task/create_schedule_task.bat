@rem Имя локального пользователя, под которым будетм работать
set user_name=test_user
@rem Пароль для локального пользователя
set user_passw=test_user
@rem Имя запланированного задание, под которым будет работать приложение
set task_name=Test_task_bat
@rem Путь к приложению
set my_app_path="d:\test.bat"
@rem Интервал работы приложения во временном задании
set schtasks_time=MINUTE
@rem Начальное время старта приложения во временном задании
set schtasks_start=08:00:00

@rem ***********************************************************************************************
@rem В зависимости от языка ОС определяем имена системных параметров
@rem ***********************************************************************************************
@rem S-1-5-32-545 - локальные пользователи
@rem S-1-5-32-544 - администраторы
Set GroupSID=S-1-5-32-544
Set GroupName=
For /F "UseBackQ Tokens=1* Delims==" %%I In (`WMIC Group Where "SID = '%GroupSID%'" Get Name /Value ^| Find "="`) Do Set GroupName=%%J
Set GroupName=%GroupName:~0,-1%
@rem ***********************************************************************************************

@REM Создание пользователя
net user %user_name% %user_passw% /add  /comment:"User for works with application" /expires:never /fullname:%user_name% /passwordchg:no
@REM Устанавливаем, чтобы пароль не истекал никогда
@rem wmic path Win32_UserAccount where Name='%user_name%' set PasswordExpires=false
wmic USERACCOUNT where Name='%user_name%' set PasswordExpires=false

@REM Добавление локального пользователя в заданную локальную группу
net localgroup %GroupName% %user_name% /ADD

@REM Создание запланированного задания
@rem  Valid schedule types: MINUTE, HOURLY, DAILY, WEEKLY, MONTHLY, ONCE, ONSTART, ONLOGON, ONIDLE.
@rem ЕЖЕМИНУТНО, ЕЖЕЧАСНО, ЕЖЕДНЕВНО, ЕЖЕНЕДЕЛЬНО, ЕЖЕМЕСЯЧНО ПРИ ЗАПУСКЕ ВХОДЕ В СИСТЕМУ ПРИ ПРОСТОЕ
schtasks /create /tn "%task_name%" /tr %my_app_path% /sc %schtasks_time% /st %schtasks_start% /ru %user_name% /rp %user_passw%
