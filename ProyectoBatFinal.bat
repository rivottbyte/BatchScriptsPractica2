@echo off 
setlocal enabledelayedexpansion
:inicio
cls
echo --------------------------------------
echo Si ya tienes una cuenta creada :
echo 1- Inicia Sesion
echo --------------------------------------
echo Si no tiene cuenta creada:
echo 2- Registrate si no tienes cuenta
echo --------------------------------------
echo Si quieres salir de aquí JEJEJ:
echo 3- Salir
echo --------------------------------------
set /p respuesta=
if %respuesta% EQU 1 (
    goto inicioSesion
) else if %respuesta% EQU 2 (
    goto registro
) else if %respuesta% EQU 3 (
    goto FIN
) else (
    goto inicio
)






                                         REM INICIO SESION








:inicioSesion
echo **************************************
echo Nombre de Usuario:
echo **************************************
set /p Nombre=Nombre:
set contador=1
for /F "tokens=%contador% delims=:" %%a in (base_de_datos.txt) do (
 if %%a EQU !Nombre! (
    goto Contraseña
pause
 ) else (
  set /a contador=!contador!+1
 )
)
echo Nombre de usuario no encontrado
goto inicioSesion
:Contraseña
echo **************************************
echo Contraseña:
echo **************************************
set /p Contraseña=Contraseña:
set cuenta=!Nombre!:!Contraseña!
set contador=1
for /F "tokens=%contador%" %%i in (base_de_datos.txt) do (
 if !cuenta! EQU %%i (
    goto dentro
pause
 ) else (
    set /a contador=!contador!+1
 )
)
echo Contraseña incorrecta
goto inicioSesion





                                REM REGISTRO




                                
:registro
if NOT EXIST base_de_datos.txt  (
    copy nul base_de_datos.txt >nul
)
echo **************************************
set /p Nombre=Nombre de Usuario:
echo **************************************
set contador=1
for /F "tokens=%contador% delims=:" %%a in (base_de_datos.txt) do (
 if %%a EQU !Nombre! (
    echo Ya hay un usuario con ese nombre
    goto registro
pause
 ) else (
  set /a contador=!contador!+1
 )
)
:contraseña_registro 
set /p Contraseña=Contraseña:
echo **************************************
set /p Contraseña_1=Confirme la contraseña:
if !Contraseña! EQU !Contraseña_1! (
    goto Registrado
) else (
    echo Las contraseñas no coinciden
    goto contraseña_registro
)
:Registrado
echo %Nombre%:%Contraseña% >> base_de_datos.txt
echo *********Te has registrado correctamente*********
echo 1- Volver a inicio
echo 2- Salir
echo *************************************************
set /p respuesta_regis=
if !respuesta_regis! EQU 1 (
    goto inicio
) else if !respuesta_regis! EQU 2 (
    goto FIN
)




                            REM INICIO SESION COMPLETADO





:dentro
cls
echo **************************************
echo Usuario y Contraseña correctos:
echo --------------------------------------
echo 1- Entrar en tu cuenta
echo 2- Volver al menu principal
echo **************************************
set /p respuesta_inicio_sesion=
if !respuesta_inicio_sesion! EQU 1 (
    goto cuenta
) else if !respuesta_inicio_sesion! EQU 2 (
    goto inicio
) else (
    goto dentro
)





                                    REM DENTRO DE LA CUENTA 







:cuenta
cls
echo **************************************
echo Has entrado en tu cuenta
echo --------------------------------------
echo 1- Modificar Contraseña
echo 2- Eliminar Usuario
echo 3- Cerrar Sesion
echo **************************************
set /p dentro_cuenta=
if !dentro_cuenta! EQU 1 (
    goto modificar
) else if !dentro_cuenta! EQU 2 (
    goto eliminar
) else if !dentro_cuenta! EQU 3 (
    goto inicio
)
:modificar
set /p nueva_cont=Introduzca la nueva contraseña:
set /p nueva_cont_1=Confirme la nueva contraseña:
if !nueva_cont! EQU !nueva_cont_1! (
goto cambio
) else (
    echo Las contraseñas no coinciden
    goto modificar
)
:cambio
set cont=1
        rename base_de_datos.txt base_de_datos_old.txt 
    copy nul base_de_datos.txt >NUL
for /F "tokens=%cont%" %%m in (base_de_datos_old.txt) do (
 if !cuenta! EQU %%m (
    echo !Nombre!:!nueva_cont! >> base_de_datos.txt 
 ) else (
    set /a contador=!contador!+1
     echo %%m >>base_de_datos.txt
 )
)
del base_de_datos_old.txt
:menu_cont_mod
echo ******************************************
echo La contraseña ha sido modificada con exito
echo ------------------------------------------
echo 1- Volver atras
echo 2- Cerrar Sesion
echo ******************************************
set /p r_cont_mod=
if !r_cont_mod! EQU 1 (
    goto cuenta
) else if !r_cont_mod! EQU 2 (
    goto inicio
) else (
    goto menu_cont_mod
)
:eliminar
set cont=1
    rename base_de_datos.txt base_de_datos_old.txt 
    copy nul base_de_datos.txt >NUL
for /F "tokens=%cont%" %%k in (base_de_datos_old.txt) do (
 if !cuenta! EQU %%k (
    echo La cuenta ha sido eliminada con exito
 ) else (
    set /a contador=!contador!+1
     echo %%k >>base_de_datos.txt
 )
)
del base_de_datos_old.txt
:menu_us_elim
echo ******************************************
echo La contraseña ha sido modificada con exito
echo ------------------------------------------
echo 1- Volver al menu principal
echo 2- Salir
echo ******************************************
set /p r_us_elim=
if !r_us_elim! EQU 1 (
    goto cuenta
) else if !r_us_elim! EQU 2 (
    goto inicio
) else (
    goto FIN
)                       
pause
:FIN
