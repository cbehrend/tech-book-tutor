@echo off
setlocal enabledelayedexpansion

set BOOK_DIR=..\book

if not exist "!BOOK_DIR!" (
    echo Error: book/ directory not found
    exit /b 1
)

REM Find first PDF in book directory
set PDF_FILE=
for %%f in (!BOOK_DIR!\*.pdf) do (
    set PDF_FILE=%%~nxf
    goto :found
)

:found
if "!PDF_FILE!"=="" (
    echo Error: No PDF found in !BOOK_DIR!
    exit /b 1
)

set INPUT_PDF=!BOOK_DIR!\!PDF_FILE!
set OUTPUT_MD=!INPUT_PDF:.pdf=.md!

echo Converting !INPUT_PDF! to !OUTPUT_MD!...

REM Check if pdftotext exists (from xpdf-tools or poppler-utils)
where pdftotext >nul 2>&1
if errorlevel 1 (
    echo ERROR: pdftotext not found!
    echo.
    echo Please install one of the following:
    echo   1. Xpdf command line tools from: https://www.xpdfreader.com/download.html
    echo   2. Or install Poppler for Windows
    echo.
    echo After installation, make sure pdftotext.exe is in your PATH.
    exit /b 1
)

pdftotext -layout "!INPUT_PDF!" "!OUTPUT_MD!"
if errorlevel 1 (
    echo Conversion failed!
    exit /b 1
)

echo Conversion complete!

endlocal
