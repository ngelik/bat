for /f %%i in ('dir /b "*.zip" /o:D') do (
		@rem ������� zip ������ �����. ���� �������� ���� ����� �������, ��������� ���� -df
		@rem tools\Rar.exe e %%i
		tools\unzip %%i
	)
)