for /f %%i in ('dir /b /o:D') do (
		@rem ������� zip ������ �����. ���� �������� ���� ����� �������, ��������� ���� -df
		@rem tools\Rar.exe a %%i.zip %%i m5
		tools\zip %%i.zip %%i -9 -D
	)
)