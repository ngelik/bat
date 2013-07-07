for /f %%i in ('dir /b "*.log" /o:D /A') do (
	grep delivery_receipt::ack %%i > tmp\%%i.txt
	echo %%i >> tmp\count.txt
	cat tmp\%%i.txt | wc -l >> tmp\count.txt
	
	echo %%i
)