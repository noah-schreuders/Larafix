@ECHO OFF

:: MIT License

:: Copyright (c) 2022 Devon Thomassen
:: 
:: Permission is hereby granted, free of charge, to any person obtaining a copy
:: of this software and associated documentation files (the "Software"), to deal
:: in the Software without restriction, including without limitation the rights
:: to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
:: copies of the Software, and to permit persons to whom the Software is
:: furnished to do so, subject to the following conditions:

:: The above copyright notice and this permission notice shall be included in all
:: copies or substantial portions of the Software.

:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
:: IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
:: FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
:: AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
:: LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
:: OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
:: SOFTWARE.

:: No flags passed, so we'll just run the default larafix command
IF "%1"=="" GOTO Default

:Loop
IF "%1"=="" GOTO :EOF
:: Help
IF "%1"=="-h" GOTO help
IF "%1"=="--help" GOTO Help
IF "%1"=="help" GOTO Help

:: Clear
IF "%1"=="-c" GOTO clear
IF "%%A"=="--clear" GOTO clear
IF "%%A"=="clear" GOTO clear

:: Drop
IF "%%A"=="-d" GOTO drop
IF "%%A"=="--drop" GOTO drop
IF "%%A"=="drop" GOTO drop

::Dumpimize
IF "%%A"=="--dumpimize" GOTO dumpimize
IF "%%A"=="dumpimize" GOTO dumpimize

::Migrate
IF "%%A"=="-m" GOTO migrate
IF "%%A"=="--migrate" GOTO migrate
IF "%%A"=="migrate" GOTO migrate

::Serve
IF "%%A"=="-s" GOTO serve
IF "%%A"=="--serve" GOTO serve
IF "%%A"=="serve" GOTO serve

GOTO :EOF

:Help
  ECHO Help menu:
  ECHO By default this script executes the following artisan commands: `optimize`, `migrate:fresh --seed` and `serve`
  ECHO To execute commands, use the following flags:
  ECHO Help:        [-h ^| --help ^| help]        Help command
  ECHO Clear:       [-c ^| --clear ^| clear]      Manual clears (routes, config, view and cache)
  ECHO Drop:        [-d ^| --drop ^| drop]        Drops all tables
  ECHO Dumpimize:   [--dump ^| dump]             Executes composer dump-autoload and artisan optimize command
  ECHO Migrate:     [-m ^| --migrate ^| migrate]  Drops the database and create it again + seeding
  ECHO Serve:       [-s ^| --serve ^| serve]      Serve the application
  ECHO Wipe:        [-w ^| --wipe ^| wipe]        Drops all tables
  ECHO You can combine flags as the following example:
  ECHO Example: larafix -dump -s
  ECHO This example will execute composer dump-autoload, artisan optimize and artisan serve
  SHIFT
  GOTO :EOF

:Default
  CALL php artisan optimize
  CALL php artisan migrate:fresh --seed
  CALL php artisan serve
  SHIFT 
  GOTO Loop

:Clear
  CALL php artisan route:clear
  CALL php artisan config:clear
  CALL php artisan view:clear
  CALL php artisan cache:clear
  SHIFT
  GOTO Loop

:Drop
  CALL php artisan db:wipe
  SHIFT
  GOTO Loop

:Dumpimize
  CALL composer dump-autoload
  CALL php artisan optimize
  SHIFT
  GOTO Loop

:Migrate
  CALL php artisan migrate:fresh --seed
  SHIFT
  GOTO Loop

:Serve
  php artisan serve
  SHIFT
  GOTO Loop
