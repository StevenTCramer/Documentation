@ECHO OFF

pushd %~dp0

REM Command file for Sphinx documentation

if "%SPHINXBUILD%" == "" (
	set SPHINXBUILD=sphinx-build
)
if "%PIP%" == "" (
	set PIP=pip
)
if "%GIT%" == "" (
	set GIT=git
)
set SOURCEDIR=source
set BUILDDIR=../build
set SPHINXPROJ=StratisAcademy

if "%1" == "" goto help

%SPHINXBUILD% >NUL 2>NUL
if errorlevel 9009 (
	echo.
	echo.The 'sphinx-build' command was not found. Make sure you have Sphinx
	echo.installed, then set the SPHINXBUILD environment variable to point
	echo.to the full path of the 'sphinx-build' executable. Alternatively you
	echo.may add the Sphinx directory to PATH.
	echo.
	echo.If you don't have Sphinx installed, grab it from
	echo.http://sphinx-doc.org/
	exit /b 1
)

rmdir /s /q temp
rmdir /s /q "source\Developer Resources\Pystratis Reference\source\"
mkdir temp\
mkdir "source\Developer Resources\Pystratis Reference\source\"
%GIT% clone https://github.com/stratisproject/pyStratis.git temp/pyStratis/
%PIP% install -r temp/pyStratis/requirements.txt
copy "temp\pyStratis\doc_build\source\" "source\Developer Resources\Pystratis Reference\source\"
%SPHINXBUILD% -M %1 %SOURCEDIR% %BUILDDIR% %SPHINXOPTS%
"%BUILDDIR%\html\index.html"
goto end

:help
%SPHINXBUILD% -M help %SOURCEDIR% %BUILDDIR% %SPHINXOPTS%

:end
popd
