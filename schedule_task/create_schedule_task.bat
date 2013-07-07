@rem ��� ���������� ������������, ��� ������� ������ ��������
set user_name=test_user
@rem ������ ��� ���������� ������������
set user_passw=test_user
@rem ��� ���������������� �������, ��� ������� ����� �������� ����������
set task_name=Test_task_bat
@rem ���� � ����������
set my_app_path="d:\test.bat"
@rem �������� ������ ���������� �� ��������� �������
set schtasks_time=MINUTE
@rem ��������� ����� ������ ���������� �� ��������� �������
set schtasks_start=08:00:00

@rem ***********************************************************************************************
@rem � ����������� �� ����� �� ���������� ����� ��������� ����������
@rem ***********************************************************************************************
@rem S-1-5-32-545 - ��������� ������������
@rem S-1-5-32-544 - ��������������
Set GroupSID=S-1-5-32-544
Set GroupName=
For /F "UseBackQ Tokens=1* Delims==" %%I In (`WMIC Group Where "SID = '%GroupSID%'" Get Name /Value ^| Find "="`) Do Set GroupName=%%J
Set GroupName=%GroupName:~0,-1%
@rem ***********************************************************************************************

@REM �������� ������������
net user %user_name% %user_passw% /add  /comment:"User for works with application" /expires:never /fullname:%user_name% /passwordchg:no
@REM �������������, ����� ������ �� ������� �������
@rem wmic path Win32_UserAccount where Name='%user_name%' set PasswordExpires=false
wmic USERACCOUNT where Name='%user_name%' set PasswordExpires=false

@REM ���������� ���������� ������������ � �������� ��������� ������
net localgroup %GroupName% %user_name% /ADD

@REM �������� ���������������� �������
@rem  Valid schedule types: MINUTE, HOURLY, DAILY, WEEKLY, MONTHLY, ONCE, ONSTART, ONLOGON, ONIDLE.
@rem ����������, ��������, ���������, �����������, ���������� ��� ������� ����� � ������� ��� �������
schtasks /create /tn "%task_name%" /tr %my_app_path% /sc %schtasks_time% /st %schtasks_start% /ru %user_name% /rp %user_passw%
