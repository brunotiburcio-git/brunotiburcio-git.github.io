@echo off
rem Sobe um servidor local para testar o site e abre o navegador.
rem Uso: clique duas vezes neste arquivo. Para parar, feche a janela ou aperte Ctrl+C.

setlocal
cd /d "%~dp0"
set PORTA=8000
set URL=http://localhost:%PORTA%/

rem 1) Python pelo inicializador "py" (instalacao padrao no Windows)
py -3 --version >nul 2>&1
if %errorlevel%==0 (
    echo Servindo %CD% em %URL% com Python ^(py^)
    start "" "%URL%"
    py -3 -m http.server %PORTA%
    goto :fim
)

rem 2) Python pelo comando "python" (ignora o atalho da Microsoft Store)
python -c "import sys" >nul 2>&1
if %errorlevel%==0 (
    echo Servindo %CD% em %URL% com Python
    start "" "%URL%"
    python -m http.server %PORTA%
    goto :fim
)

rem 3) Node.js, se instalado
where npx >nul 2>&1
if %errorlevel%==0 (
    echo Servindo %CD% em %URL% com Node ^(http-server^)
    start "" "%URL%"
    npx --yes http-server -p %PORTA% -c-1
    goto :fim
)

echo Nao encontrei Python nem Node.js neste computador.
echo Instale o Python em https://www.python.org/downloads/ e rode de novo.
pause

:fim
endlocal
