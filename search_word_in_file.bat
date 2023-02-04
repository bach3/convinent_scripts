REM enter searching keyword
@set /p keyword="Enter KEYWORD:"
if "%keyword%"=="q" exit
findstr %keyword% *.txt > temp
chcp 65001
cls
REM display content of the text file
@type temp
@set /p answer="[Q]uit [O]pen:"
if "%answer%"=="o" notepad temp
if "%answer%"=="q" exit
@search_word_in_file.bat