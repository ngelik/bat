@echo off

set rabbitmqctl="c:\Program Files (x86)\RabbitMQ Server\rabbitmq_server-3.3.1\sbin\rabbitmqctl"
set rabbit_service="c:\Program Files (x86)\RabbitMQ Server\rabbitmq_server-3.3.1\sbin\rabbitmq-service"
set rabbitmq_log_path="d:\RabbitMQ\log"
set rabbitmq_config_file="d:\RabbitMQ\install\rabbitmq.config"

for /f "delims=" %%a in ('tools\date +%%Y%%m%%d_%%H%%M%%S') do @set datetime=%%a

copy rabbitmq-env.conf %APPDATA%\RabbitMQ\
copy rabbitmq.config %APPDATA%\RabbitMQ\

setx -m RABBITMQ_LOG_BASE %rabbitmq_log_path%
setx -m RABBITMQ_CONSOLE_LOG "new"
:: setx RABBITMQ_CONFIG_FILE %rabbitmq_config_file%
:: setx -m RABBITMQ_CONFIG_FILE %rabbitmq_config_file%

sc stop RabbitMQ
sleep 5

call %rabbitmqctl% rotate_logs .%datetime%.log

call %rabbit_service% remove
sleep 5
call %rabbit_service% install

sc start RabbitMQ