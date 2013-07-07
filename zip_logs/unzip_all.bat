for /f %%i in ('dir /b "*.zip" /o:D') do (
		@rem создаем zip архивы логов. Если исходные логи нужно удалять, добавляем ключ -df
		@rem tools\Rar.exe e %%i
		tools\unzip %%i
	)
)