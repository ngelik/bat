call DependOnService.bat list rinitd_1
call DependOnService.bat add rinitd_1 MSSQL$SQLEXPRESS/LanmanServer/PlugPlay
call DependOnService.bat list rinitd_1
call DependOnService.bat remove rinitd_1
call DependOnService.bat list rinitd_1