About
===
Adds dependency on a Windows Service after the service is installed

Usage
===
Old version
==
DependOnServiceByReg.bat [reg file]

Example: DependOnServiceByReg.bat DependOnService

New version.
==
DependOnService.bat [add service_name ServiceB/ServiceC/ServiceD | remove | list service_name]

call DependOnService.bat list rinitd_1

call DependOnService.bat add rinitd_1 MSSQL$SQLEXPRESS/LanmanServer/PlugPlay

call DependOnService.bat remove rinitd_1
