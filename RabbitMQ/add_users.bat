@echo off
set function_name=%~1

set rabbitmqctl="c:\Program Files (x86)\RabbitMQ Server\rabbitmq_server-3.3.1\sbin\rabbitmqctl"

GOTO CASE_%function_name%
:CASE_restart_rabbitmq
    ECHO [START] restart_rabbitmq
	CALL :restart_rabbitmq
	ECHO [FINISH] restart_rabbitmq
    GOTO END_SWITCH
:CASE_init_users
    ECHO [START] init_users
    CALL :init_users
	ECHO [FINISH] init_users
	GOTO END_SWITCH
:CASE_create_user
    ECHO [START] create_user
    CALL :create_user %~2 %~3 %~4 %~5
	ECHO [FINISH] create_user
	GOTO END_SWITCH
:CASE_
	ECHO "usage: add_users.bat [restart_rabbitmq | init_users | create_user]"
	ECHO "example: add_users.bat create_user user_name user_pwd vhost_name [management | policymaker | monitoring | administrator]"
	GOTO END_SWITCH
:END_SWITCH
	GOTO :EOF

:: -----------------------------------------------------------------------------------
:init_users
	SETLOCAL enableextensions enabledelayedexpansion	
	
	CALL :create_user monitor_user monitor_pwd monitor monitoring
	CALL :create_user admin admin / administrator
	:: CALL :create_user user user user management
	
	( 
		ENDLOCAL
	)
	exit /b	
	
:: ******************************************************************************
:create_user
	SETLOCAL enableextensions enabledelayedexpansion
	
	set user_name=%~1
	set user_pwd=%~2
	set vhost=%~3
	set role=%~4
	
	call %rabbitmqctl% add_vhost %vhost%
	call %rabbitmqctl% add_user %user_name% %user_pwd%
	call %rabbitmqctl% set_permissions -p %vhost% %user_name% ".*" ".*" ".*"
	call %rabbitmqctl% set_user_tags %user_name%  %role%
	
	( 
		ENDLOCAL
	)
	exit /b	

:: ******************************************************************************
:restart_rabbitmq
	sc stop RabbitMQ
	sleep 5
	sc start RabbitMQ
	exit /b
	