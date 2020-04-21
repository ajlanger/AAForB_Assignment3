@echo off

echo Setting paths...

set CURRENT_HOME=%~dp0

echo %CURRENT_HOME%

IF NOT "%CURRENT_HOME%"=="%CURRENT_HOME: =%" (
    echo Uh-oh, you have spaces in your path
    echo Please move Spark to a location without spaces
    GOTO End
)

set SPARK_HOME=%CURRENT_HOME%spark-2.4.5-bin-hadoop2.7
set HADOOP_HOME=%CURRENT_HOME%winutils
set JAVA_HOME=%CURRENT_HOME%jre1.8.0_241

set PATH=%PATH%;%SPARK_HOME%\bin;%HADOOP_HOME%\bin;%JAVA_HOME%\bin

set PYSPARK_DRIVER_PYTHON=jupyter
set PYSPARK_DRIVER_PYTHON_OPTS='notebook'

echo %JAVA_HOME%

:Java

echo Checking if Java exists...

java -version 1>NUL 2>NUL
IF NOT %ERRORLEVEL%==9009 GOTO Python

echo It doesn't -- try installing manually or adding java.exe to your path

GOTO End

:Python

echo Checking if Python exists...

python -V 1>NUL 2>NUL
IF NOT %ERRORLEVEL%==9009 GOTO Start

echo Doesn't seem to be the case, I'll try to load in Anaconda

call C:\Users\%username%\Anaconda3\Scripts\activate.bat C:\Users\%username%\Anaconda3
call %localappdata%\Continuum\Anaconda3\Scripts\activate.bat %localappdata%\Continuum\Anaconda3

python -V 1>NUL 2>NUL
IF NOT %ERRORLEVEL%==9009 GOTO Start

echo Still nothing -- try to manually add python.exe to your path
echo Or start this script from an Anaconda prompt

GOTO End

:Start

echo Starting...
echo In case of trouble, make sure Jupyter is installed and up to date

pyspark

:End

pause
