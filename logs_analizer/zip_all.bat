for /f %%i in ('dir /b /o:D') do (
		@rem создаем zip архивы логов. Если исходные логи нужно удалять, добавляем ключ -df
		@rem tools\Rar.exe a %%i.zip %%i m5
		tools\zip %%i.zip %%i -9 -D
	)
)