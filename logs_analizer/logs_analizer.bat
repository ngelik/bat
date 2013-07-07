@rem �����, ������� ����� ����� � �����
@set STR_FIND=%1

@rem ���������� �������������� �����
@set LOG_TYPE="*.log"

@rem ��� ����� � ������������ ������
@set RESULT_FILE=result.txt 

echo ��������� ������ ������ %STR_FIND% >> %RESULT_FILE%
for /f %%i in ('dir /b %LOG_TYPE% /o:D /A') do (

	@rem "Set /P $V=%%a" ������� ����������� ��� ����� �������� ���������� $V (��. "SET /?")
	@rem "<Nul" ��������� �������� ����� ������������ (�������������� ���� SET �� ������ ����-��)
	<Nul Set /P $V=%%i - >> %RESULT_FILE%
	tools\grep %STR_FIND% %%i | tools\wc -l >> %RESULT_FILE%
	
	echo %%i
)
