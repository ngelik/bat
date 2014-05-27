@echo off

@rem ��� ���������� ������������, ��� ������� ������ ��������
set user_name=user_name
@rem ������ ��� ���������� ������������
set user_passw=
@rem ��� ���������������� �������, ��� ������� ����� �������� ����������
set task_name=rabbitmq.logrotate
@rem ���� � ����������
set my_app_path="d:\RabbitMQ\install\logrotate_rabbitmq.bat "
@rem �������� ������ ���������� �� ��������� �������
set schtasks_time=DAILY
set schtasks_time_intervale=1
@rem ��������� ����� ������ ���������� �� ��������� �������
set schtasks_start=00:00:01

@REM �������� ���������������� �������
@rem  Valid schedule types: MINUTE, HOURLY, DAILY, WEEKLY, MONTHLY, ONCE, ONSTART, ONLOGON, ONIDLE.
@rem ����������, ��������, ���������, �����������, ���������� ��� ������� ����� � ������� ��� �������
schtasks /create /tn "%task_name%" /tr %my_app_path% /sc %schtasks_time% /MO %schtasks_time_intervale% /st %schtasks_start% /ru %user_name% /rp %user_passw%

