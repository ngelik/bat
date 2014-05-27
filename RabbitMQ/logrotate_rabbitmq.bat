@echo off

set current_path=d:\RabbitMQ\install
set rabbitmqctl="c:\Program Files (x86)\RabbitMQ Server\rabbitmq_server-3.3.1\sbin\rabbitmqctl"

for /f "delims=" %%a in ('%current_path%\tools\date +%%Y%%m%%d') do @set datetime=%%a

call %rabbitmqctl% rotate_logs .%datetime%.log


