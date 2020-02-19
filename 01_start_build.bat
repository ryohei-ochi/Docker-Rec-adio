cd /d c:\Docker\Rec-adio

for /f "tokens=2 skip=1 delims=," %%i in ('systeminfo /FO CSV') do set OS=%%i

if %OS% == "Microsoft Windows 10 Pro" (
  echo HOST_ROOT=C:\Docker\Rec-adio>.env
) else (
  echo HOST_ROOT=/C_DRIVE/Docker/Rec-adio>.env
)

docker-compose up --build 