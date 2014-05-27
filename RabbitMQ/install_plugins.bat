@echo off

set plugins=(^
	rabbitmq_management, ^
	rabbitmq_management_visualiser, ^
	rabbitmq_tracing ^
)

set rabbitmq_plugins="c:\Program Files (x86)\RabbitMQ Server\rabbitmq_server-3.3.1\sbin\rabbitmq-plugins"

@for %%i in %plugins% do (
	echo %rabbitmq_plugins% enable %%i
	call %rabbitmq_plugins% enable %%i
)

sc stop RabbitMQ
sleep 5
sc start RabbitMQ