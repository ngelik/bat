@rem Имя файла реестра с новыми настройками
SET FileName=DependOnService.reg

@rem Импортируем в рееестр новые настройки прокси
reg import %FileName%