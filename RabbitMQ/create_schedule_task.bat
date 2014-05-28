@echo off

:: ***********************************************************************************************
:: ������ �������� ����������
:: ***********************************************************************************************
:: ������� ����
set current_path=d:\RabbitMQ\install

:: ��� ���������� ������������, ��� ������� ����� ��������
set user_name=rabbitmq
:: ������ ��� ���������� ������������
set user_passw=Pa$$w0rd

:: ��� ���������������� �������, ��� ������� ����� �������� ����������
set task_name=rabbitmq.logrotate
:: ���� � ����������
set my_app_path="d:\RabbitMQ\install\logrotate_rabbitmq.bat "
:: �������� ������ ���������� �� ��������� �������
set schtasks_time=DAILY
set schtasks_time_intervale=1
:: ��������� ����� ������ ���������� �� ��������� �������
set schtasks_start=23:59:00

:: ***********************************************************************************************
:: � ����������� �� ����� �� ���������� ����� ��������� ����������
:: ***********************************************************************************************
:: S-1-5-32-545 - ��������� ������������
:: S-1-5-32-544 - ��������������
Set GroupSID=S-1-5-32-545
Set GroupName=
For /F "UseBackQ Tokens=1* Delims==" %%I In (`WMIC Group Where "SID = '%GroupSID%'" Get Name /Value ^| Find "="`) Do Set GroupName=%%J
Set GroupName=%GroupName:~0,-1%
:: ***********************************************************************************************

:: �������� ������������
net user %user_name% %user_passw% /add  /comment:"Simple user with Batch logon privilege for rotation RabbitMQ logs. Don't delete!" /expires:never /fullname:%user_name% /passwordchg:no
:: �������������, ����� ������ �� ������� �������
:: ���� ��� - wmic path Win32_UserAccount where Name='%user_name%' set PasswordExpires=false
wmic USERACCOUNT where Name='%user_name%' set PasswordExpires=false
:: ���������� ���������� ������������ � �������� ��������� ������
net localgroup %GroupName% %user_name% /ADD

:: ***********************************************************************************************
:: ���� ��������������� ������������ ����� Batch logon privilege
:: ***********************************************************************************************
%current_path%\tools\ntrights.exe -u %user_name% +r SeBatchLogonRight

:: �������� ���������������� �������
::  Valid schedule types: MINUTE, HOURLY, DAILY, WEEKLY, MONTHLY, ONCE, ONSTART, ONLOGON, ONIDLE.
:: ����������, ��������, ���������, �����������, ���������� ��� ������� ����� � ������� ��� �������
schtasks /create /tn "%task_name%" /tr %my_app_path% /sc %schtasks_time% /MO %schtasks_time_intervale% /st %schtasks_start% /ru %user_name% /rp %user_passw%

