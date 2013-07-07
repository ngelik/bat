@rem Текст, который нужно найти в логах
@set STR_FIND=%1

@rem Расширение обрабатываемых логов
@set LOG_TYPE="*.log"

@rem Имя файла с результатами работы
@set RESULT_FILE=result.txt 

echo Результат поиска строки %STR_FIND% >> %RESULT_FILE%
for /f %%i in ('dir /b %LOG_TYPE% /o:D /A') do (

	@rem "Set /P $V=%%a" выводит приглашение для ввода значения переменной $V (см. "SET /?")
	@rem "<Nul" отключает ожидание ввода пользователя (перенаправляет ввод SET на пустое устр-во)
	<Nul Set /P $V=%%i - >> %RESULT_FILE%
	tools\grep %STR_FIND% %%i | tools\wc -l >> %RESULT_FILE%
	
	echo %%i
)
