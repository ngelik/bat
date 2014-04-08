@echo off
set command_param=%~1

:: ******************************* logging **************************************
for /f "delims=" %%a in ('tools\date +%%Y%%m%%d_%%H%%M%%S_%%N') do @set datetime=%%a
@set LOGFILE="log\DependOnService.%datetime%.log"

:: ******************************************************************************

GOTO CASE_%command_param%
:CASE_add
	call :echof %LOGFILE% "START add"
	CALL :add %~2 %~3 >> %LOGFILE% 2>&1
	call :echof %LOGFILE% "FINISH add"
    GOTO END_SWITCH
:CASE_remove
    call :echof %LOGFILE% "START remove"
    CALL :remove %~2 >> %LOGFILE% 2>&1
	call :echof %LOGFILE% "FINISH remove"
	GOTO END_SWITCH
:CASE_list
	call :echof %LOGFILE% "START list"
	call :list %~2 >> %LOGFILE% 2>&1
	call :echof %LOGFILE% "FINISH list"
	GOTO END_SWITCH
:END_SWITCH
	type %LOGFILE%
	GOTO :EOF

:: ******************************************************************************
:add
	SETLOCAL enableextensions enabledelayedexpansion
	sc config %~1 depend= %~2
	
	( 
		ENDLOCAL
	)
	exit /b

:: -----------------------------------------------------------------------------------
:remove
	SETLOCAL enableextensions enabledelayedexpansion
	sc config %~1 depend= /
	
	( 
		ENDLOCAL
	)
	exit /b	

:: -----------------------------------------------------------------------------------
:list
	SETLOCAL enableextensions enabledelayedexpansion
	sc qc %~1
	( 
		ENDLOCAL
	)
	exit /b	

:: -----------------------------------------------------------------------------------

:echof
	SETLOCAL enableextensions enabledelayedexpansion	
	set "log_name=%1"
	set msg=%2
	
	for /f "delims=" %%a in ('tools\date +%%T') do @set date_time=%%a
	
	:: echo %msg%
	echo [%date_time%] %msg% >> %log_name%
	
	( 
		ENDLOCAL
	)
	exit /b
	
:: -----------------------------------------------------------------------------------