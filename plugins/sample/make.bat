@ECHO off
REM Batch file to build Python code

REM
REM shell must have been started with "cmd /V:on" for bang syntax to work
REM restart if it has not
REM
SET path_="_py_continue_"
IF NOT !path_! equ "_py_continue_" (
  cmd /V:ON /S /C "%0 %*"
  GOTO exit
)

REM Set parameters, these can be overriden from the command line
SET CONFIGURATION=Release
SET BUILD=Rebuild
SET CLEAN=True
SET COMPILE=True

IF /I "%2" EQU "Debug" SET CONFIGURATION=Debug
IF /I "%1" EQU "Build" SET BUILD=Build
IF /I "%1" EQU "Clean" SET BUILD=Clean

REM Only do a Clean on Rebuild / Clean
IF /I "%BUILD%" EQU "Build" SET CLEAN=False
REM Only do a compile on Build/Rebuild
IF /I "%BUILD%" EQU "Clean" SET COMPILE=False

SET OUTPUT_DIR="%CD%\..\output"
SET PYTHON_OUTPUT="%OUTPUT_DIR%\installation\"
SET TEST_OUTPUT="%OUTPUT_DIR%\test\"
SET ZIP="%CD%\..\..\..\..\..\3rd_party\7zip\7z.exe"

IF /I "%CLEAN%" EQU "True" (
	IF EXIST *.pyc (
		ATTRIB -R *.pyc
		DEL /Q *.pyc
	)
	IF EXIST test (
		IF EXIST test\*.pyc (
			ATTRIB -R test\*.pyc
			DEL /Q test\*.pyc
		)
	)
)

IF /I "%COMPILE%" EQU "True" (
	IF NOT EXIST %PYTHON_OUTPUT%	MKDIR %PYTHON_OUTPUT%
	IF NOT EXIST %TEST_OUTPUT%	MKDIR %TEST_OUTPUT%

	python -mcompileall -l .
	IF NOT %ERRORLEVEL% == 0 GOTO error
	%ZIP% a openstack.zip openstack.pyc openstack.xml
	MOVE /y *.zip %PYTHON_OUTPUT%
	IF EXIST test (
		CD test
		python -mcompileall -l .
		IF NOT %ERRORLEVEL% == 0 GOTO error
		COPY *.pyc %TEST_OUTPUT%
		CD ..
	)
)

GOTO success

:error
IF %ERRORLEVEL% == 0 SET ERRORLEVEL=1
GOTO exit

:success
SET ERRORLEVEL=0
GOTO exit

:exit
IF NOT %ERRORLEVEL% == 0 EXIT %ERRORLEVEL%
EXIT /B
