@echo off
setlocal enabledelayedexpansion

echo Running setup...

REM Get Git Username
for /f "delims=" %%i in ('git config user.name 2^>nul') do set GIT_NAME=%%i
if "!GIT_NAME!"=="" (
    echo Could not get git user.name, defaulting to "student"
    set GIT_NAME=student
)

REM Sanitize name for directory use
set WORKSPACE_DIR=!GIT_NAME: =-!
set WORKSPACE_DIR=!WORKSPACE_DIR:(=-!
set WORKSPACE_DIR=!WORKSPACE_DIR:)=-!

REM Convert to lowercase (simple approach for common cases)
for %%L in (A a B b C c D d E e F f G g H h I i J j K k L l M m N n O o P p Q q R r S s T t U u V v W w X x Y y Z z) do (
    set WORKSPACE_DIR=!WORKSPACE_DIR:%%L=%%L!
)

echo Workspace directory: !WORKSPACE_DIR!

REM Create workspace directory
if not exist "..\!WORKSPACE_DIR!" (
    mkdir "..\!WORKSPACE_DIR!"
    echo Created workspace directory: !WORKSPACE_DIR!/
) else (
    echo Workspace directory already exists: !WORKSPACE_DIR!/
)

REM Check and convert book
echo.
echo Checking for book...
if not exist "..\book" (
    echo ERROR: book/ directory not found
    exit /b 1
)

REM Run conversion script
echo Running book conversion...
node convert-book.js
if errorlevel 1 (
    echo WARNING: Book conversion failed or no PDF found.
    echo Please ensure a PDF exists in the "book/" directory.
)

REM Find markdown file
set BOOK_FILE=
for %%f in (..\book\*.md) do set BOOK_FILE=%%~nxf
if "!BOOK_FILE!"=="" (
    echo Error: No Markdown book file found after conversion attempt.
    exit /b 1
)
echo Using book file: !BOOK_FILE!

REM Create props.yml
(
echo workspace: !WORKSPACE_DIR!
echo book_file: "!BOOK_FILE!"
echo current_chapter: 1
echo last_step: "setup"
) > ..\props.yml

echo Created props.yml with workspace: !WORKSPACE_DIR!

echo.
echo Setup Complete!
echo -----------------------------------
echo Your workspace is: !WORKSPACE_DIR!/
echo Please proceed to Phase 2 in the README.

endlocal
