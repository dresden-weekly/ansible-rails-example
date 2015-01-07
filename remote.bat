@echo off
:: This script should be placed in the root of your project
SETLOCAL ENABLEEXTENSIONS

::   Absolute path of the project
set "PROJECT_FOLDER=%~dp0"

::   Relative path of vagrant-ansible-remote to the project
set "VAGRANT_ANSIBLE_REMOTE=vagrant-ansible-remote"

::   Vagrant name of the machine with Ansible
if not defined VAGRANT_ANSIBLE_MACHINE (
  set "VAGRANT_ANSIBLE_MACHINE=ansible-vm"
)

::   transfer some environment variables
if not defined ANSIBLE_ENV (
  set "ANSIBLE_ENV=REMOTE=ON"
)
if defined REPO_USER if "%ANSIBLE_ENV:REPO_USER=%." == "%ANSIBLE_ENV%." (
  set "ANSIBLE_ENV=REPO_USER=%REPO_USER% %ANSIBLE_ENV%"
)
if defined REPO_PASSWORD if "%ANSIBLE_ENV:REPO_PASSWORD=%." == "%ANSIBLE_ENV%." (
  set "ANSIBLE_ENV=REPO_PASSWORD=%REPO_PASSWORD% %ANSIBLE_ENV%"
)
if defined SECRET_KEY_BASE if "%ANSIBLE_ENV:SECRET_KEY_BASE=%." == "%ANSIBLE_ENV%." (
  set "ANSIBLE_ENV=SECRET_KEY_BASE=%SECRET_KEY_BASE% %ANSIBLE_ENV%"
)

call "%VAGRANT_ANSIBLE_REMOTE%/remote.bat" %*

ENDLOCAL
