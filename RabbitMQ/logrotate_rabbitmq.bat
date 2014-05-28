@echo off

set current_path=d:\RabbitMQ\install
set log_path=d:\RabbitMQ\log
set rabbitmqctl="c:\Program Files (x86)\RabbitMQ Server\rabbitmq_server-3.3.1\sbin\rabbitmqctl"

for /f "delims=" %%a in ('%current_path%\tools\date +%%Y%%m%%d') do @set datetime=%%a

call %rabbitmqctl% rotate_logs .%datetime%

:: for debug
:: move /Y %log_path%\*.%datetime% %log_path%\old 1>>%current_path%\test.txt 2>>&1
move /Y %log_path%\*.%datetime% %log_path%\old


