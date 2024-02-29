@echo off

if "%1" == "" (
  echo don't forget input CHART_NAME
  echo ex: package.bat CHART_NAME
  exit /b 1
)

set CHART_NAME=%1

echo The CHART_NAME variable is: %CHART_NAME%

if not exist "assets\%CHART_NAME%" mkdir "assets\%CHART_NAME%"

helm package -d "temp" "charts\%CHART_NAME%"

helm repo index --url "assets/%CHART_NAME%/" --merge "index.yaml" "temp"

move /Y "temp\%CHART_NAME%-*.tgz" "assets\%CHART_NAME%"

move /Y "temp\index.yaml" .

rmdir "temp"

set CHART_NAME=""
