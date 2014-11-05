@echo off
SETLOCAL ENABLEEXTENSIONS
set OLD_CD=%CD%
cd /D "%~dp0"

set PROVISION_TARGET=
if [%1]==[] goto :aftertarget
if EXIST "ansible\hosts\%1" (
  set PROVISION_TARGET=%1
  echo Target: %1
  shift
)
:aftertarget

set PROVISION_ACTION=
if [%1]==[] goto :afteraction
if EXIST "ansible\%1.yml" (
  set PROVISION_ACTION=%1
  echo Action: %1
  shift
)
:afteraction

if [%1]==[] goto :no_args
set PROVISION_ARGS=%1
shift
:loopargs
if [%1]==[] goto :afterargs
set PROVISION_ARGS=%PROVISION_ARGS% %1
shift
goto :loopargs
:afterargs
set PROVISION_ARGS=%PROVISION_ARGS:\=/%
echo Arguments: %PROVISION_ARGS%
:no_args

:: windows has no local ansible
set VM_ANSIBLE=1
echo vagrant provision
vagrant provision

cd /D "%OLD_CD%"
ENDLOCAL
