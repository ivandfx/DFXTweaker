On Error Resume Next
Randomize

Set oWSH = CreateObject("WScript.Shell")
Set oAPP = CreateObject("Shell.Application")
Set oFSO = CreateObject("Scripting.FileSystemObject")
Set oWMI = GetObject("winmgmts:\\.\root\CIMV2")
strUser = CreateObject("WScript.Network").UserName

currentVersion = "1.11.1 "
currentFolder  = oFSO.GetParentFolderName(WScript.ScriptFullName)
Call runElevated()
Call ForceConsole()
Call archCheck()
Call checkW10orW11
wait 0.3
printf " "
printf "  Loading..."
wait 0.3
Call languageMenu()
Function languageMenu()
	cls
	printf "  Wait..."
	wait 1
	cls
	printf " "
	printf"   ____  _______  __  _____                    _             "
	printf"  |  _ \|  ___\ \/ / |_   _|_      _____  __ _| | _____ _ __ "
	printf"  | | | | |_   \  /    | | \ \ /\ / / _ \/ _` | |/ / _ \ '__|"
	printf"  | |_| |  _|  /  \    | |  \ V  V /  __/ (_| |   <  __/ |   "
	printf"  |____/|_|   /_/\_\   |_|   \_/\_/ \___|\__,_|_|\_\___|_|   "
        printf "     Created by ivandfx            	                  v" & currentVersion
	printf " "
	printf "  DFX Tweaker is a fork of AikonCWD W10 Script 5.6"
	printf "  Licensed under a GNU General Public License v3.0"
	printf " "
	printf "  Welcome, " & strUser
	printf "  Select your language:"
	printf " "
	printf "  1 = Spanish (ES_es)"
	printf " "
	printf "  2 = English (EN_us)"
	printf " "
	printf " "
	printf "  66 = Safe Mode Settings"
	printf "  77 = Quick Settings"
	printf " "
	printf " "
	printf "  88 = Check for a new release						   If you find any issues, type '55'"
	printf "  99 = Open DFX Tweaker GitHub						(This will open GitHub on your browser)"
	printf "  44 = Open DFX Tweaker Web"
	printf " "
	printf "  0 = Close"
	printf " "
	printl " > "
	RP = scanf
	If isNumeric(RP) = False Then
		printf ""
		printf " Only numbers are allowed."
		wait 2
		Call languageMenu()
		Exit Function
	End If
	Select Case RP
		Case 1
			Call spanishlang()
		Case 2
			Call englishlang()		
		Case 88
			cls
			Call dfxrelease()
			wait 1
			Call languageMenu
		Case 99
			cls
			Call dfxgithub()
			wait 1
			Call languageMenu
		Case 55
			cls
			Call reportIssue()
			wait 1
			Call languageMenu
		Case 66
			cls
			wait 1
			Call safemodesettings()
		Case 77
			cls
			wait 1
			Call quicksettings()
		Case 44
			cls
			wait 1
			Call dfxtweakerweb()
		Case 0
			Call xpshutEN()
		Case Else
			printf ""
			printf " Only numbers are allowed."
			wait 2
			Call showMenu()
			Exit Function
	End Select
End Function

Function dfxtweakerweb()
		Dim url
		Set url= CreateObject("WScript.Shell")
		url.Run "https://ivandfx.github.io/DFXTweaker", 9
		Call languageMenu()
	Exit Function
End Function

Function dfxgithub()
		Dim url
		Set url= CreateObject("WScript.Shell")
		url.Run "https://github.com/ivandfx/dfxtweaker", 9
		Call languageMenu()
	Exit Function
End Function

Function dfxrelease()
		Dim url
		Set url= CreateObject("WScript.Shell")
		url.Run "https://github.com/ivandfx/dfxtweaker/releases", 9
		Call languageMenu()
	Exit Function
End Function

Function reportIssue()
		Dim url
		Set url= CreateObject("WScript.Shell")
		url.Run "https://github.com/ivandfx/DFXTweaker/issues/new", 9
		Call languageMenu()
	Exit Function
End Function

Function safemodesettings()
	cls
	printf " "
	printf "   ____         __        __  __           _        ____       _   _   _                 "
	printf "  / ___|  __ _ / _| ___  |  \/  | ___   __| | ___  / ___|  ___| |_| |_(_)_ __   __ _ ___ "
	printf "  \___ \ / _` | |_ / _ \ | |\/| |/ _ \ / _` |/ _ \ \___ \ / _ \ __| __| | '_ \ / _` / __|"
	printf "   ___) | (_| |  _|  __/ | |  | | (_) | (_| |  __/  ___) |  __/ |_| |_| | | | | (_| \__ \"
	printf "  |____/ \__,_|_|  \___| |_|  |_|\___/ \__,_|\___| |____/ \___|\__|\__|_|_| |_|\__, |___/"
	printf "                                                                              |___/      "
	printf " "
	printf " "
	printf "  Select an option:"
	printf " "
	printf " "
	printf "  1 = Restart in Safe Mode (Normal)"
	printf " "
	printf "  2 = Restart in Safe Mode (Networking)"
	printf " "
	printf "  3 = Reboot to Standard Windows"
	printf " "
	printf " "
	printf "  0 = Return to Start Menu"
	printf " "
	printl " > "
	RP = scanf
	If isNumeric(RP) = False Then
		printf ""
		printf " Only numbers are allowed."
		wait 2
		Call safemodesettings()
		Exit Function
	End If
	Select Case RP
	Case 1	
		MsgBox "Your PC will reboot right after you close this window, make sure you saved all your data", vbInformation + vbOkOnly, "DFX Tweaker Safe Mode"
		Set objShell = WScript.CreateObject("WScript.Shell")
		oWSH.Run "bcdedit /set {current} safeboot minimal"
		wait 1
		objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
	Case 2
		MsgBox "Your PC will reboot right after you close this window, make sure you saved all your data", vbInformation + vbOkOnly, "DFX Tweaker Safe Mode"
		Set objShell = WScript.CreateObject("WScript.Shell")
		oWSH.Run "bcdedit /set {current} safeboot network"
		wait 1
		objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
	Case 3
		MsgBox "Your PC will reboot right after you close this window, make sure you did all your changes", vbInformation + vbOkOnly, "DFX Tweaker Safe Mode"
		Set objShell = WScript.CreateObject("WScript.Shell")
		oWSH.Run "bcdedit /deletevalue {current} safeboot"
		wait 1
		objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
	Case 0
		cls
		wait 1
		Call languageMenu()
		Exit Function
	End Select
End Function

Function quicksettings()
	cls
	printf " "
	printf "    ___        _      _               _   _   _                 "  
	printf "   / _ \ _   _(_) ___| | __  ___  ___| |_| |_(_)_ __   __ _ ___ "  
	printf "  | | | | | | | |/ __| |/ / / __|/ _ \ __| __| | '_ \ / _` / __|"  
	printf "  | |_| | |_| | | (__|   <  \__ \  __/ |_| |_| | | | | (_| \__ \"  
	printf "   \__\_\\__,_|_|\___|_|\_\ |___/\___|\__|\__|_|_| |_|\__, |___/"  
	printf "                                                      |___/  1.1"  
	printf " "
	printf " "
	printf " "
	printf " "
	printf " "
	printf " "
	printf " "
	printf " "
	printf " "
	printf "  1 = Disable Windows Update"
	printf " "
	printf "  2 = Disable Windows Defender (SF)"
	printf " "
	printf "  3 = Show file extensions"
	printf " "
	printf "  4 = Show Windows license status"
	printf " "
	printf "  5 = Open Additional Windows features"
	printf " "
	printf " "
	printf "  0 = Return to language menu"
	printf " "
	printl " > "
	RP = scanf
	If isNumeric(RP) = False Then
		printf ""
		printf " Only numbers are allowed."
		wait 2
		Call quicksettings()
		Exit Function
	End If
	Select Case RP
	Case 1
		oWSH.Run "sc stop WdNisSvc"
		oWSH.Run "sc stop WinDefend"
		oWSH.Run "sc config WdNisSvc start=disabled"
		oWSH.Run "sc config WinDefend start=disabled"	
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" & chr(34) & " /DISABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" & chr(34) & " /DISABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" & chr(34) & " /DISABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Verification" & chr(34) & " /DISABLE"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableBehaviorMonitoring", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableOnAccessProtection", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableScanOnRealtimeEnable", 1, "REG_DWORD"
		oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\NOC_GLOBAL_SETTING_TOASTS_ENABLED", 0, "REG_DWORD"
		cls
		printf ""
		printf "  Windows Update is now disabled"
		wait 2
		Call quicksettings()
	Case 2
		oWSH.Run "sc stop WdNisSvc"
		oWSH.Run "sc stop WinDefend"
		oWSH.Run "sc config WdNisSvc start=disabled"
		oWSH.Run "sc config WinDefend start=disabled"	
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" & chr(34) & " /DISABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" & chr(34) & " /DISABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" & chr(34) & " /DISABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Verification" & chr(34) & " /DISABLE"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableBehaviorMonitoring", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableOnAccessProtection", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableScanOnRealtimeEnable", 1, "REG_DWORD"
		oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\NOC_GLOBAL_SETTING_TOASTS_ENABLED", 0, "REG_DWORD"
		printf " "
		printf " INFO: Windows Defender has been disabled"
		wait 2
		Call quicksettings()
	Case 3
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", 0, "REG_DWORD"
		printf ""
		printf "Files extensions will now be shown"
		wait 1
		Call quicksettings()
	Case 4
		printf " Your license status will appear in a few seconds..."
		wait 0.2
		printf " Collecting license data..."
		wait 2
		oWSH.Run "slmgr.vbs /dli"
		oWSH.Run "slmgr.vbs /xpr"
		wait 1
		Call quicksettings()
	Case 5
		printf " > Executing optionalfeatures.exe"
		oWSH.Run "optionalfeatures.exe"
		wait 1
		Call quicksettings()
	Case 0
		cls
		wait 1
		Call languageMenu()
		Exit Function
	End Select
End Function

Function spanishlang()
	cls
	printf "  Espera..."
	wait 2
	Call showMenuES()
	Exit Function
End Function

Function showBannerES()
	printf" "
	printf"   ____  _______  __  _____                    _             "
	printf"  |  _ \|  ___\ \/ / |_   _|_      _____  __ _| | _____ _ __ "
	printf"  | | | | |_   \  /    | | \ \ /\ / / _ \/ _` | |/ / _ \ '__|"
	printf"  | |_| |  _|  /  \    | |  \ V  V /  __/ (_| |   <  __/ |   "
	printf"  |____/|_|   /_/\_\   |_|   \_/\_/ \___|\__,_|_|\_\___|_| "
        printf "     Creado por ivandfx            	 	          v" & currentVersion
	printf " "
	printf "  DFX Tweaker es un fork de AikonCWD W10 Script 5.6"
	printf "  Bajo una licencia GNU General Public License v3.0"
End Function

Function showMenuES()
	cls
	Call showBannerES
	printf "  "
	printf "  Selecciona una opción:                                     		   11 = Ayuda sobre (1X) y (SF)"
	printf " "
	printf "  1 = Configurar tweaks de sistema            		     		   12 = Opciones de apagado avanzadas "
	printf "  2 = Configurar tweaks de rendimiento			     		   13 = Sobre mi versión de Windows"
	printf "  3 = Desinstalar aplicaciones de Windows 10 (1X)"
	printf ""
	printf "  4 = Configurar el seguimiento"
	printf "  5 = Configurar MS OneDrive"
	printf "  6 = Configurar MS Cortana"
	printf "  7 = Configurar Windows Defender (SF)"
	printf "  8 = Configurar Windows Update"
	printf ""
	printf "  9 = Ver el estado de la licencia de Windows"
	printf "  10 = Atajos de teclado de Windows"
	printf ""
	printf "									   44 = Ajustes del Modo Seguro"
	printf "  0 = Salir						     		   55 = Cambiar idioma"
	printf ""
	printl " > "
	RP = scanf
	If isNumeric(RP) = False Then
		printf ""
		printf " Solo se permiten números."
		wait 2
		Call showMenuES()
		Exit Function
	End If
	Select Case RP
		Case 1
			Call menuSysTweaksES()
		Case 2
			Call menuPerformanceES()
		Case 3
			Call menuCleanAppsES()
		Case 4
			Call menuTrackingES()
		Case 5
			Call menuOneDriveES()
		Case 6
			Call menuCortanaES()
		Case 7
			Call menuWindowsDefenderES()
		Case 8
			Call menuWindowsUpdateES()
		Case 9
			Call menuXPRES()
		Case 10
			Call showKeyboardTipsES()
		Case 11
			MsgBox "Las opciones con (1X) solo son compatibles con Windows 10. Las opciones con (SF) necesitan Modo Seguro para funcionar.", vbInformation + vbOkOnly, "DFX Tweaker: Ayuda"
			Call showMenuES()
		Case 12
			Call shutdownMenuES()
		Case 13
			cls
			oWSH.Run "winver.exe"
			Call showMenuES()
		Case 44
			Call safemodesettingsES()
		Case 55
			Call languageMenu()
		Case 66
			Call creativecommons()
		Case 0
			Call xpshutES()
		Case Else
			cls
			printf ""
			printf " Solo se permiten números."
			wait 2
			Call showMenuES
			Exit Function
	End Select
End Function

Function menuXPRES()
	cls
	On Error Resume Next
	printf ""
	printf " En unos segundos aparecerá el estado de tu activación..."
	wait 0.2
	printf " Recopilando datos de la activación..."
	wait 2
	oWSH.Run "slmgr.vbs /dli"
	oWSH.Run "slmgr.vbs /xpr"
	wait 1
	Call showMenuES
End Function

Function showBannerWASTES()
	printf "  __        ___    ____ _____   _____           _              _     _          _ "
	printf "  \ \      / / \  / ___|_   _| | ____|_ __ ___ | |__   ___  __| | __| | ___  __| |"
	printf "   \ \ /\ / / _ \ \___ \ | |   |  _| | '_ ` _ \| '_ \ / _ \/ _` |/ _` |/ _ \/ _` |"
	printf "    \ V  V / ___ \ ___) || |   | |___| | | | | | |_) |  __/ (_| | (_| |  __/ (_| |"
	printf "     \_/\_/_/   \_\____/ |_|   |_____|_| |_| |_|_.__/ \___|\__,_|\__,_|\___|\__,_|"
	printf "                          Windows Advanced Shutdown Tool para DFX Tweaker 1.2"
	printf " "
	End Function

Function shutdownMenuES()
	cls
	Call showBannerWASTES()
	printf " "
	printf "  Cargando WAST para DFX Tweaker..."
	wait 0.4
	printf "  Espera..."
	wait 3
	cls
	On Error Resume Next
	Call showBannerWASTES()
	printf " "
	printf " "
	printf " "
	printf " "
	printf " "
	printf "   ¿Que quieres hacer?:"
	printf "                                            55 = Reiniciar el Explorador de Windows"
	printf ""
	printf "  1 = Apagar el equipo"
	printf " "
	printf "  2 = Reiniciar el equipo"
	printf " "
	printf "  3 = Cerrar sesión de este usuario"
	printf " "
	printf "  4 = Ir a opciones avanzadas"
	printf ""
	printf "  5 = Causar un BSOD (Blue Screen Of Death)"
	printf " "
	printf " "
	printf "  0 = Volver al menú"
	printf ""
	printl " > "
	RP = scanf
	If isNumeric(RP) = False Then
		printf ""
		printf " Solo se permiten números."
		wait 2
		Call shutdownMenuES()
		Exit Function
	End If
	Select Case RP
		Case 1
			result = MsgBox ("¿Apagar?", vbYesNo, "WAST Apagado")
Select Case result
    Case vbYes
	Set objShell = WScript.CreateObject("WScript.Shell")
	objShell.Run "C:\WINDOWS\system32\shutdown.exe -s -t 0"
        Dim objShell
    Case vbNo
	cls
	printf = "  Espera..."
		wait 1
		Call shutdownMenuES()
End Select
		Case 2
						result = MsgBox ("¿Reiniciar?", vbYesNo, "WAST Reinicio")
Select Case result
    Case vbYes
	Set objShell = WScript.CreateObject("WScript.Shell")
	objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
    Case vbNo
	cls
	printf = "  Espera..."
		wait 1
		Call shutdownMenuES()
End Select
		Case 3
						result = MsgBox ("¿Cerrar sesion? Los datos no guardados se perderan.", vbYesNo, "WAST Cierre de sesion")
Select Case result
    Case vbYes
	Set objShell = WScript.CreateObject("WScript.Shell")
	objShell.Run "C:\WINDOWS\system32\shutdown.exe -l"
    Case vbNo
	cls
	printf = "  Espera..."
		wait 1
		Call shutdownMenuES()
End Select
		Case 4
						result = MsgBox ("¿Ir al menu de opciones avanzadas? Esto cerrrara todas las sesiones de todos los usuarios del equipo.", vbYesNo, "WAST Opciones avanzadas")
Select Case result
    Case vbYes
	Set objShell = WScript.CreateObject("WScript.Shell")
	objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -o -t 0"
	wait 1
		Call shutdownMenuES()
    Case vbNo
	cls
	printf = "  Espera..."
		wait 1
		Call shutdownMenuES()
End Select
		Case 5
						result = MsgBox ("¿Quieres causar un pantallazo azul de la muerte? Asegurate de haber guardado TODOS los datos que estuvieras usando.", vbYesNo, "WAST BSOD")
Select Case result
    Case vbYes
	Set objShell = WScript.CreateObject("WScript.Shell")
	oWSH.Run "taskkill.exe /F /IM explorer.exe"
	wait 2
	objShell.Run "taskkill /f /im crss.exe"
	objShell.Run "taskkill /f /im winnit.exe"
	objShell.Run "taskkill /f /im winlogon.exe"
	objShell.Run "taskkill /f /im svchost.exe"
    Case vbNo
	cls
	printf = "  Espera..."
		wait 1
		Call shutdownMenuES()
End Select
		Case 55
						result = MsgBox ("¿Quieres reiniciar el Explorador de Windows?", vbYesNo, "WAST Explorador")
Select Case result
    Case vbYes
	printf = "  Espera..."
		printf " >> Reiniciando el explorador de Windows..."
		oWSH.Run "taskkill.exe /F /IM explorer.exe"
		wait 5
		oWSH.Run "explorer.exe"
		Call shutdownMenuES()
    Case vbNo
	cls
	printf = "  Espera..."
		wait 1
		Call shutdownMenuES()
End Select
Case 0
		cls
		printf "  Volviendo a DFX Tweaker..."
		wait 0.3
		printf "  Espera..."
		wait 2.7
		Call showMenuES()
	End Select
End Function

Function menuSysTweaksES()
	cls
	On Error Resume Next	
	printf "   _____                    _              _      _       _     _                       "
	printf "  |_   _|_      _____  __ _| | _____    __| | ___| |  ___(_)___| |_ ___ _ __ ___   __ _ "
	printf "    | | \ \ /\ / / _ \/ _` | |/ / __|  / _` |/ _ \ | / __| / __| __/ _ \ '_ ` _ \ / _` |"
	printf "    | |  \ V  V /  __/ (_| |   <\__ \ | (_| |  __/ | \__ \ \__ \ ||  __/ | | | | | (_| |"
	printf "    |_|   \_/\_/ \___|\__,_|_|\_\___/  \__,_|\___|_| |___/_|___/\__\___|_| |_| |_|\__,_|"                                                             
	printf ""
	printf "  Selecciona una opcion:"
	printf ""
	printf " "
	printf "  1 = Activar Modo oscuro"
	printf "  2 = Crear icono 'Modo Dios' en el escritorio"
	printf "  3 = Activar 'Acceso Rápido' en el Explorador de Windows"
	printf "  4 = Mostrar la extensión de los archivos" 
	printf "  5 = Activar 'Vista Clásica' en el Panel de Control"
	printf "  6 = Habilitar el control de volumen clásico"
	printf "  7 = Abrir CMD al pulsar Win+U (SF)"
	printf "  8 = Habilitar/Deshabilitar Control de Cuentas de Usuario"
	printf "  9 = Habilitar/Dehabilitar inicio de sesión sin la contraseña"
	printf ""
	printf " "
	printf "  0 = Volver al menu			99 = Restaurar"
	printf ""
	printl "  > "
	Select Case scanf
		Case 1
			printf ""
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\AppsUseLightTheme", 0, "REG_DWORD"
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\AppsUseLightTheme", 0, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call menuSysTweaksES()
		Case 2
			printf ""
		godFolder = oWSH.SpecialFolders("Desktop") & "\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
		If oFSO.FolderExists(godFolder) = False Then oFSO.CreateFolder(godFolder)
			printf ""
			printf ""
			wait 1
			Call menuSysTweaksES()
		Case 3
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\LaunchTo", 1, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call menuSysTweaksES()
		Case 4
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", 0, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call menuSysTweaksES()
		Case 5
		oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\ForceClassicControlPanel", 1, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call menuSysTweaksES()
		Case 6
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC\EnableMtcUvc", 0, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call menuSysTweaksES()
		Case 7
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\utilman.exe\Debugger", "cmd.exe", "REG_SZ"
			printf ""
			printf ""
			wait 1
			Call menuSysTweaksES()
		Case 9
			cls
			printf " Desmarca la opcion: Los usuarios deben escribir su nombre y contraseña para usar el equipo"
			printf " Acepta los cambios y reinicia el PC"
			wait 1
			oWSH.Run "control userpasswords2"
			wait 2
			Call menuSysTweaksES()
		Case 99
			Call restoreSysTweaksES()
		Case 0
			Call showMenuES()
		Case 8
			cls
			printf "  Espera..."
			wait 2
			printf ""
			oWSH.Run "UserAccountControlSettings.exe"
			MsgBox "Despues de cambiar este ajuste, debes reiniciar el PC. ¿Quieres hacerlo ahora?", vbInformation + vbYesNo, "DFX Tweaker UAC"
	Select Case result
  	  Case vbYes
		Set objShell = WScript.CreateObject("WScript.Shell")
		objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
  	  Case vbNo
		cls
		printf = "  Espera..."
			Call menuSysTweaksES()
		Case Else
			cls
			printf ""
			printf " Solo se permiten números."
			wait 2
			Call menuSysTweaksES()
			Exit Function
		End Select
	End Select
End Function

Function restoreSysTweaksES()
	cls
	On Error Resume Next	
	printf "   _____                    _              _      _       _     _     Restauración      "
	printf "  |_   _|_      _____  __ _| | _____    __| | ___| |  ___(_)___| |_ ___ _ __ ___   __ _ "
	printf "    | | \ \ /\ / / _ \/ _` | |/ / __|  / _` |/ _ \ | / __| / __| __/ _ \ '_ ` _ \ / _` |"
	printf "    | |  \ V  V /  __/ (_| |   <\__ \ | (_| |  __/ | \__ \ \__ \ ||  __/ | | | | | (_| |"
	printf "    |_|   \_/\_/ \___|\__,_|_|\_\___/  \__,_|\___|_| |___/_|___/\__\___|_| |_| |_|\__,_|"                                                             
	printf ""
	printf "  Selecciona una opcion:"
	printf ""
	printf " "
	printf "  1 = Desactivar Modo oscuro"
	printf "  2 = Eliminar icono 'Modo Dios' en el escritorio"
	printf "  3 = Desactivar 'Acceso Rápido' en el Explorador de Windows"
	printf "  4 = Dejar de mostrar la extensión de los archivos" 
	printf "  5 = Desactivar 'Vista Clásica' en el Panel de Control"
	printf "  6 = Deshabilitar el control de volumen clásico"
	printf "  7 = Desactivar el CMD al pulsar Win+U (SF)"
	printf " "
	printf "  0 = Volver al menú anterior"
	printf ""
	printl "  > "
	Select Case scanf
		Case 1
			printf ""
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\AppsUseLightTheme", 1, "REG_DWORD"
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\AppsUseLightTheme", 1, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call restoreSysTweaksES()
		Case 2
			printf ""
		godFolder = oWSH.SpecialFolders("Desktop") & "\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
		If oFSO.FolderExists(godFolder) = True Then oFSO.DeleteFolder(godFolder)
			printf ""
			printf ""
			wait 1
			Call restoreSysTweaksES()
		Case 3
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\LaunchTo", 2, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call restoreSysTweaksES()
		Case 4
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", 1, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call restoreSysTweaksES()
		Case 5
		oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\ForceClassicControlPanel", 0, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call restoreSysTweaksES()
		Case 6
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC\EnableMtcUvc", 1, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call restoreSysTweaksES()
		Case 7
		oWSH.RegDelete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\utilman.exe\Debugger"
			printf ""
			printf ""
			wait 1
			Call restoreSysTweaksES()
		Case 0
			Call menuSysTweaksES()
		Case Else
			cls
			printf ""
			printf " Solo se permiten números."
			wait 2
			Call restoreSysTweaksES()
			Exit Function
		End Select
End Function

Function menuOneDriveES()
	cls
	On Error Resume Next	
	printf "   __  __ ____     ___             ____       _           "
	printf "  |  \/  / ___|   / _ \ _ __   ___|  _ \ _ __(_)_   _____ "
	printf "  | |\/| \___ \  | | | | '_ \ / _ \ | | | '__| \ \ / / _ \"
	printf "  | |  | |___) | | |_| | | | |  __/ |_| | |  | |\ V /  __/"
	printf "  |_|  |_|____/   \___/|_| |_|\___|____/|_|  |_| \_/ \___|"                                                               
	printf ""
	printf "  Selecciona una opción:"
	printf ""
	printf "  1 = Deshabilitar MS OneDrive"
	printf "  2 = Habilitar MS OneDrive"
	printf ""
	printf "  0 = Volver al menú"
	printf ""
	printl "  > "
	Select Case scanf
		Case "1"
			printf ""
			printf " Deshabilitando OneDrive..."
			wait 1
				oWSH.Run "taskkill.exe /F /IM OneDrive.exe /T"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableFileSyncNGSC", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive\DisableFileSyncNGSC", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableLibrariesDefaultSaveToOneDrive", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableMeteredNetworkFileSync", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive\DisableLibrariesDefaultSaveToOneDrive", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive\DisableMeteredNetworkFileSync", 1, "REG_DWORD"
				oWSH.RegWrite "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 0, "REG_DWORD"
				oWSH.RegWrite "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 0, "REG_DWORD"
				oWSH.RegWrite "HKCU\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 0, "REG_DWORD"
				oWSH.RegWrite "HKCU\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 0, "REG_DWORD"
				oWSH.RegDelete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\OneDrive"
			printf ""
			printf " OneDrive se ha deshabilitado"
			wait 2
			Call menuOneDriveES()
		Case "2"
			printf ""
			printf " Habilitando OneDrive..."
			wait 1
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableFileSyncNGSC", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive\DisableFileSyncNGSC", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableLibrariesDefaultSaveToOneDrive", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableMeteredNetworkFileSync", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive\DisableLibrariesDefaultSaveToOneDrive", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive\DisableMeteredNetworkFileSync", 0, "REG_DWORD"
				oWSH.RegWrite "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 1, "REG_DWORD"
				oWSH.RegWrite "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 1, "REG_DWORD"
				oWSH.RegWrite "HKCU\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 1, "REG_DWORD"
				oWSH.RegWrite "HKCU\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 1, "REG_DWORD"
			printf ""
			printf " OneDrive se ha habilitado"
			wait 2
		Case "0"
			Call showMenuES()
		Case Else
			cls
			printf ""
			printf " Solo se permiten números."
			wait 2
			Call menuOneDriveES()
	End Select
	Call menuOneDriveES()
End Function

Function menuCortanaES()
	cls
	On Error Resume Next
	printf "   __  __ ____     ____           _                    "
	printf "  |  \/  / ___|   / ___|___  _ __| |_ __ _ _ __   __ _ "
	printf "  | |\/| \___ \  | |   / _ \| '__| __/ _` | '_ \ / _` |"
	printf "  | |  | |___) | | |__| (_) | |  | || (_| | | | | (_| |"
	printf "  |_|  |_|____/   \____\___/|_|   \__\__,_|_| |_|\__,_|"                                                         
	printf " "
	printf " Selecciona una opción:"
	printf ""
	printf "  1 = Deshabilitar MS Cortana"
	printf "  2 = Habilitar MS Cortana"
	printf ""
	printf "  0 = Volver al menú"
	printf ""
	printl "  > "
	Select Case scanf
		Case "1"
			oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\AllowCortana", 0, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\CortanaEnabled", 0, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\SearchboxTaskbarMode", 0, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\BingSearchEnabled", 0, "REG_DWORD"
			printf ""
			printf " >> Reiniciando el explorador de Windows..."
			oWSH.Run "taskkill.exe /F /IM explorer.exe"
			wait 5
			oWSH.Run "explorer.exe"
		Case "2"
			oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\AllowCortana", 1, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\CortanaEnabled", 1, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\SearchboxTaskbarMode", 1, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\BingSearchEnabled", 1, "REG_DWORD"
			printf ""
			printf " >> Reiniciando el explorador de Windows..."
			oWSH.Run "taskkill.exe /F /IM explorer.exe"
			wait 5
			oWSH.Run "explorer.exe"
		Case "0"
			Call showMenuES()
		Case Else
			cls
			printf ""
			printf " Solo se permiten números."
			wait 2
			Call menuCortanaES()
	End Select
	Call menuCortanaES()
End Function

Function menuTrackingES()
	cls
	On Error Resume Next
	printf "   ____                   _           _            _        "
	printf "  / ___|  ___  __ _ _   _(_)_ __ ___ (_) ___ _ __ | |_ ___  "
	printf "  \___ \ / _ \/ _` | | | | | '_ ` _ \| |/ _ \ '_ \| __/ _ \ "
	printf "   ___) |  __/ (_| | |_| | | | | | | | |  __/ | | | || (_) |"
	printf "  |____/ \___|\__, |\__,_|_|_| |_| |_|_|\___|_| |_|\__\___/ "
	printf "               |___/                                        "
	printf ""
	printf " Selecciona una opción:"
	printf ""
	printf "  1 = Deshabilitar el seguimiento"
	printf ""
	printf "  2 = Habilitar el seguimiento"
	printf " "
	printf " "
	printf "  0 = Volver al menú"
	printf ""
	printl "  > "
	Select Case scanf
		Case 1
			printf ""
			printf " Deshabilitando el seguimiento..."
			oWSH.Run "sc stop DiagTrack"
			oWSH.Run "sc config DiagTrack start= disabled"
			oWSH.Run "sc stop dmwappushservice"
			oWSH.Run "sc config dmwappushservice start= disabled"
			wait 2
			Call menuTrackingES()
		Case 2
			printf ""
			printf " Habilitando el seguimiento..."
			oWSH.Run "sc start DiagTrack"
			oWSH.Run "sc config DiagTrack start= enabled"
			oWSH.Run "sc start dmwappushservice"
			oWSH.Run "sc config dmwappushservice start= enabled"
			wait 2
			Call menuTrackingES()
		Case 0
			Call showMenuES()
		Case Else
			cls
			printf ""
			printf " Solo se permiten números."
			wait 2
			Call menuTrackingES()
	End Select
	Call menuTrackingES()
End Function

Function menuWindowsDefenderES()
	cls
	On Error Resume Next
	printf "   __  __ ____    ____        __                _           "
	printf "  |  \/  / ___|  |  _ \  ___ / _| ___ _ __   __| | ___ _ __ "
	printf "  | |\/| \___ \  | | | |/ _ \ |_ / _ \ '_ \ / _` |/ _ \ '__|"
	printf "  | |  | |___) | | |_| |  __/  _|  __/ | | | (_| |  __/ |   "
	printf "  |_|  |_|____/  |____/ \___|_|  \___|_| |_|\__,_|\___|_|   "
	printf ""
	printf "  En Windows 10 y Windows 11 versión 2004 y superior, se recomienda desactivar MS Defender en Modo Seguro"
	printf "  ya que desactivar MS Defender en modo normal no funcionará."
	printf ""
	printf "  Selecciona una opcion:"
	printf ""
	printf "  1 = Deshabilitar MS Defender"
	printf "  2 = Habilitar MS Defender"
	printf " "
	printf "  3 = Ajustes del Modo Seguro"
	printf ""
	printf "  0 = Volver al menú"
	printf ""
	printl "  > "
	Select Case scanf
		Case "1"
			printf ""
			printf "  Deshabilitando Windows Defender..."
			wait 1
		oWSH.Run "sc stop WdNisSvc"
		oWSH.Run "sc stop WinDefend"
		oWSH.Run "sc config WdNisSvc start=disabled"
		oWSH.Run "sc config WinDefend start=disabled"	
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" & chr(34) & " /DISABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" & chr(34) & " /DISABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" & chr(34) & " /DISABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Verification" & chr(34) & " /DISABLE"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableBehaviorMonitoring", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableOnAccessProtection", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableScanOnRealtimeEnable", 1, "REG_DWORD"
		oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\NOC_GLOBAL_SETTING_TOASTS_ENABLED", 0, "REG_DWORD"
			printf ""
			printf "  Windows Defender se ha deshabilitado correctamente"
			wait 2
		Case "2"
			printf ""
			printf "  Habilitando Windows Defender..."
			wait 1
		oWSH.Run "sc config WdNisSvc start=auto"
		oWSH.Run "sc config WinDefend start=auto"	
		oWSH.Run "sc start WdNisSvc"
		oWSH.Run "sc start WinDefend"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" & chr(34) & " /ENABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" & chr(34) & " /ENABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" & chr(34) & " /ENABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Verification" & chr(34) & " /ENABLE"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 0, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 0, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableBehaviorMonitoring", 0, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableOnAccessProtection", 0, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableScanOnRealtimeEnable", 0, "REG_DWORD"
		oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\NOC_GLOBAL_SETTING_TOASTS_ENABLED", 1, "REG_DWORD"
			printf ""
			printf "  Windows Defender se ha habilitado correctamente"
			wait 2
		Case 3
			Call safemodesettingsES()
		Case "0"
			Call showMenuES()
		Case Else
			cls
			printf ""
			printf " Solo se permiten números."
			wait 2
			Call menuWindowsDefenderES()
	End Select
	Call menuWindowsDefenderES()
End Function

Function menuWindowsUpdateES()
	cls
	On Error Resume Next
	printf "  __        ___           _                     _   _           _       _       "
	printf "  \ \      / (_)_ __   __| | _____      _____  | | | |_ __   __| | __ _| |_ ___ "
	printf "   \ \ /\ / /| | '_ \ / _` |/ _ \ \ /\ / / __| | | | | '_ \ / _` |/ _` | __/ _ \"
	printf "    \ V  V / | | | | | (_| | (_) \ V  V /\__ \ | |_| | |_) | (_| | (_| | ||  __/"
	printf "     \_/\_/  |_|_| |_|\__,_|\___/ \_/\_/ |___/  \___/| .__/ \__,_|\__,_|\__\___|"
	printf "                                                     |_|                        "
	printf " "
	printf " "
	printf "  Selecciona una opción:"
	printf " "
	printf " "
	printf "  1 = Desactivar Windows Update"
	printf " "
	printf "  2 = Activar Windows Update" 
	printf " "
	printf " "
	printf "  0 = Volver al menú"
	printl " > "
	RP = scanf
	If isNumeric(RP) = False Then
		printf ""
		printf " Solo se permiten números."
	Call menuWindowsUpdateES()
		Exit Function
	End If
	Select Case RP
		Case 1
		oWSH.Run "sc stop wuauserv"
		oWSH.Run "sc config wuauserv start=disabled"
	cls
	printf ""
	printf "  Windows Update se ha desactivado"
	wait 2
	Call menuWindowsUpdateES()
		Case 2
		oWSH.Run "sc config wuauserv start=auto"
		oWSH.Run "sc start wuauserv"
	cls
	printf ""
	printf "  Windows Update se ha activado"
	wait 2
	Call menuWindowsUpdateES()		
		Case 0
	Call showMenuES()
End Select
End Function

Function safemodesettingsES()
	cls
	printf " "
	printf "      _     _           _                  _      _   __  __           _         ____                             "
	printf "     / \   (_)_   _ ___| |_ ___  ___    __| | ___| | |  \/  | ___   __| | ___   / ___|  ___  __ _ _   _ _ __ ___  "
	printf "    / _ \  | | | | / __| __/ _ \/ __|  / _` |/ _ \ | | |\/| |/ _ \ / _` |/ _ \  \___ \ / _ \/ _` | | | | '__/ _ \ "
	printf "   / ___ \ | | |_| \__ \ ||  __/\__ \ | (_| |  __/ | | |  | | (_) | (_| | (_) |  ___) |  __/ (_| | |_| | | | (_) |"
	printf "  /_/   \_\/ |\__,_|___/\__\___||___/  \__,_|\___|_| |_|  |_|\___/ \__,_|\___/  |____/ \___|\__, |\__,_|_|  \___/ "
	printf "         |__/                                                                               |___/                 "
	printf " "
	printf " "
	printf "  Selecciona una opción:"
	printf " "
	printf " "
	printf "  1 = Reiniciar en Modo Seguro (Normal)"
	printf " "
	printf "  2 = Reiniciar en Modo Seguro (Con Internet)"
	printf " "
	printf "  3 = Volver a Windows"
	printf " "
	printf " "
	printf "  0 = Volver al menú"
	printf " "
	printl " > "
	RP = scanf
	If isNumeric(RP) = False Then
		printf ""
		printf " Solo se permiten números."
		wait 2
		Call safemodesettingsES()
		Exit Function
	End If
	Select Case RP
	Case 1	
		MsgBox "El PC se reiniciará justo después de cerrar esta ventana, asegúrate de haber guardado todos tus datos", vbInformation + vbOkOnly, "DFX Tweaker Modo Seguro"
		Set objShell = WScript.CreateObject("WScript.Shell")
		oWSH.Run "bcdedit /set {current} safeboot minimal"
		wait 1
		objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
	Case 2
		MsgBox "El PC se reiniciará justo después de cerrar esta ventana, asegúrate de haber guardado todos tus datos", vbInformation + vbOkOnly, "DFX Tweaker Modo Seguro"
		Set objShell = WScript.CreateObject("WScript.Shell")
		oWSH.Run "bcdedit /set {current} safeboot network"
		wait 1
		objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
	Case 3
		MsgBox "El PC se reiniciará justo después de cerrar esta ventana, asegúrate de haber hecho tus cambios", vbInformation + vbOkOnly, "DFX Tweaker Modo Seguro"
		Set objShell = WScript.CreateObject("WScript.Shell")
		oWSH.Run "bcdedit /deletevalue {current} safeboot"
		wait 1
		objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
	Case 0
		cls
		wait 1
		Call showMenuES()
		Exit Function
	End Select
End Function

Function menuPerformanceES()
	cls
	On Error Resume Next	
	printf "   _____                    _              _                           _ _           _            _        "
	printf "  |_   _|_      _____  __ _| | _____    __| | ___   _ __ ___ _ __   __| (_)_ __ ___ (_) ___ _ __ | |_ ___  "
	printf "    | | \ \ /\ / / _ \/ _` | |/ / __|  / _` |/ _ \ | '__/ _ \ '_ \ / _` | | '_ ` _ \| |/ _ \ '_ \| __/ _ \ "
	printf "    | |  \ V  V /  __/ (_| |   <\__ \ | (_| |  __/ | | |  __/ | | | (_| | | | | | | | |  __/ | | | || (_) |"
	printf "    |_|   \_/\_/ \___|\__,_|_|\_\___/  \__,_|\___| |_|  \___|_| |_|\__,_|_|_| |_| |_|_|\___|_| |_|\__\___/ "                                                            
	printf ""
	printf ""
	printf ""
	printf "  Selecciona una opción:"
	printf ""
	printf ""
	printf "  1 = Deshabilitar BitLocker, Cifrado y OfflineFiles"
	printf ""
	printf "  2 = Deshabilitar servicios WiFi"
	printf ""
	printf "  3 = Ejecutar el liberador de espacio en disco"
	printf ""
	printf "  4 = Añadir características adicionales de Windows"
	printf ""
	printf "  5 = Habilitar todo el ancho de banda para el sistema"
	printf ""
	printf ""
	printf "  0 = Volver al menú			99 = Restaurar"
	printf ""
	printl "  > "
	Select Case scanf
		Case 1
			printf ""
		oWSH.Run "sc config BDESVC start=disabled"
		oWSH.Run "sc config EFS start=disabled"
		oWSH.Run "sc config CscService start=disabled"
		oWSH.Run "sc stop BDESVC"
		oWSH.Run "sc stop EFS"
		oWSH.Run "sc stop CscService"
			printf ""
			printf ""
			wait 1
			Call menuPerformanceES()
		Case 2
			printf ""
		oWSH.Run "sc config WlanSvc start=disabled"
		oWSH.Run "sc stop WlanSvc"
			printf ""
			printf ""
			wait 1
			Call menuPerformanceES()
		Case 3
		oWSH.Run "cleanmgr.exe"
			printf ""
			printf ""
			wait 1
			Call menuPerformanceES()
		Case 4
		oWSH.Run "optionalfeatures.exe"
			printf ""
			printf ""
			wait 1
			Call menuPerformanceES()
		Case 5
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched\Psched", 0, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call menuPerformanceES()
		Case 99
			Call restorePerformanceES()
		Case 0
			Call showMenuES()
		Case Else
			cls
			printf ""
			printf " Solo se permiten números."
			wait 2
			Call menuPerformanceES()
			Exit Function
		End Select
End Function

Function restorePerformanceES()
	cls
	On Error Resume Next	
	printf "   _____                    _              _       Restauración        _ _           _            _        "
	printf "  |_   _|_      _____  __ _| | _____    __| | ___   _ __ ___ _ __   __| (_)_ __ ___ (_) ___ _ __ | |_ ___  "
	printf "    | | \ \ /\ / / _ \/ _` | |/ / __|  / _` |/ _ \ | '__/ _ \ '_ \ / _` | | '_ ` _ \| |/ _ \ '_ \| __/ _ \ "
	printf "    | |  \ V  V /  __/ (_| |   <\__ \ | (_| |  __/ | | |  __/ | | | (_| | | | | | | | |  __/ | | | || (_) |"
	printf "    |_|   \_/\_/ \___|\__,_|_|\_\___/  \__,_|\___| |_|  \___|_| |_|\__,_|_|_| |_| |_|_|\___|_| |_|\__\___/ "                                                            
	printf ""
	printf ""
	printf ""
	printf "  Selecciona una opción:"
	printf ""
	printf ""
	printf "  1 = Habilitar BitLocker, Cifrado y OfflineFiles"
	printf ""
	printf "  2 = Habilitar servicios WiFi"
	printf ""
	printf "  3 = Deshabilitar todo el ancho de banda para el sistema"
	printf ""
	printf ""
	printf "  0 = Volver al menú anterior"
	printf ""
	printl "  > "
	Select Case scanf
		Case 1
			printf ""
		oWSH.Run "sc config BDESVC start=auto"
		oWSH.Run "sc config EFS start=auto"
		oWSH.Run "sc config CscService start=auto"
		oWSH.Run "sc start BDESVC"
		oWSH.Run "sc start EFS"
		oWSH.Run "sc start CscService"
			printf ""
			printf ""
			wait 1
			Call restorePerformanceES()
		Case 2
			printf ""
		oWSH.Run "sc config WlanSvc start=auto"
		oWSH.Run "sc start WlanSvc"
			printf ""
			printf ""
			wait 1
			Call restorePerformanceES()
		Case 3
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched\Psched", 20, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call restorePerformanceES()
		Case 0
			Call menuPerformanceES()
		Case Else
			cls
			printf ""
			printf " Solo se permiten números."
			wait 2
			Call restorePerformanceES()
			Exit Function
		End Select
End Function

Function menuCleanAppsES()
	cls
	On Error Resume Next
	printf "      _                      _   ___        ______  "
	printf "     / \   _ __  _ __  ___  | | | \ \      / /  _ \ "
	printf "    / _ \ | '_ \| '_ \/ __| | | | |\ \ /\ / /| |_) |"
	printf "   / ___ \| |_) | |_) \__ \ | |_| | \ V  V / |  __/ "
	printf "  /_/   \_\ .__/| .__/|___/  \___/   \_/\_/  |_|    "
	printf "          |_|   |_|                                 "
	printf " "
	printf "  Esto va a desinstalar las siguientes aplicaciones:"
	printf ""
	printf "  > Bing, Zune, Skype, XboxApp"
	printf "  > Get started, Mensajes, Visor 3D"
	printf "  > Mapas de Windows, Telefono, Camera, Alarmas, Contactos"
	printf "  > Aplicaciones de Comunicacion de Windows, Grabadora de sonidos"
	printf "  > Microsoft Office Hub, Office Sway, OneNote"
	printf "  > Solitaire Collection, Candy Crush Saga"
	printf ""
	printl "  Esta opcion NO es reversible. Quieres continuar? (s/n) "
	
	If scanf = "s" Then
		oWSH.Run "powershell get-appxpackage -Name *Bing* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *Zune* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *XboxApp* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *OneNote* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *SkypeApp* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *3DBuilder* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *Getstarted* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *Microsoft.People* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *MicrosoftOfficeHub* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *MicrosoftSolitaireCollection* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *WindowsCamera* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *WindowsAlarms* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *WindowsMaps* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *WindowsPhone* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *WindowsSoundRecorder* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *windowscommunicationsapps* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *CandyCrushSaga* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *Messagin* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *ConnectivityStore* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *CommsPhone* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *Office.Sway* | Remove-AppxPackage", 1, True
		printf ""
		printf " > Todas las aplicaciones se han desinstalado correctamente..."
	Else
		printf ""
		printf " > Operación cancelada."
	End If
	wait 2
	Call showMenuES()
End Function

Function showKeyboardTipsES()
	msg = msg & "WIN+A		Abre el centro de actividades" & vbcrlf
	msg = msg & "WIN+C		Activa el reconocimiento de voz de Cortana" & vbcrlf
	msg = msg & "WIN+D		Muestra el escritorio" & vbcrlf
	msg = msg & "WIN+E		Abre el explorador de Windows" & vbcrlf
	msg = msg & "WIN+G		Activa Game DVR para grabar la pantalla" & vbcrlf
	msg = msg & "WIN+H		Compartir en las apps Modern para Windows 10" & vbcrlf
	msg = msg & "WIN+I		Abre la configuracion del sistema" & vbcrlf
	msg = msg & "WIN+K		Inicia 'Conectar' para enviar datos a dispositivos" & vbcrlf
	msg = msg & "WIN+L		Bloquea el equipo" & vbcrlf
	msg = msg & "WIN+R		Ejecutar un comando" & vbcrlf
	msg = msg & "WIN+S		Activa Cortana" & vbcrlf
	msg = msg & "WIN+X		Abre el menú de opciones avanzadas" & vbcrlf
	msg = msg & "WIN+TAB		Abre la vista de tareas" & vbcrlf
	msg = msg & "WIN+Flechas	Pega una ventana a la pantalla (Windows Snap)" & vbcrlf
	msg = msg & "WIN+CTRL+D		Crea un nuevo escritorio virtual" & vbcrlf
	msg = msg & "WIN+CTRL+F4	Cierra un escritorio virtual" & vbcrlf
	msg = msg & "WIN+CTRL+Flechas	Cambia de escritorio virtual" & vbcrlf
	msg = msg & "WIN+SHIFT+Flechas	Mueve la ventana actual de un monitor a otro" & vbcrlf
	
	MsgBox msg, vbOkOnly, "DFX Tweaker: Atajos de teclado"
	Call showMenuES()
End Function

Function englishlang()
	cls
	printf "  Wait..."
	wait 2
	Call showMenuEN()
	Exit Function
End Function

Function showBannerEN()
	printf" "
	printf"   ____  _______  __  _____                    _             "
	printf"  |  _ \|  ___\ \/ / |_   _|_      _____  __ _| | _____ _ __ "
	printf"  | | | | |_   \  /    | | \ \ /\ / / _ \/ _` | |/ / _ \ '__|"
	printf"  | |_| |  _|  /  \    | |  \ V  V /  __/ (_| |   <  __/ |   "
	printf"  |____/|_|   /_/\_\   |_|   \_/\_/ \___|\__,_|_|\_\___|_| "
        printf "     Created by ivandfx            	 	          v" & currentVersion
	printf " "
	printf "  DFX Tweaker is a fork of AikonCWD W10 Script 5.6"
	printf "  Licensed under a GNU General Public License v3.0"
End Function

Function showMenuEN()
	cls
	Call showBannerEN
	printf "  "
	printf "  Select an option:                                          		   11 = Help about (1X) and (SF)"
	printf " "
	printf "  1 = Configure system tweaks            		     		   12 = Advanced shutdown options"
	printf "  2 = Configure performance tweaks			     		   13 = About my Windows version"
	printf "  3 = Uninstall Windows 10 default apps (1X)"
	printf ""
	printf "  4 = Configure tracking"
	printf "  5 = Configure MS OneDrive"
	printf "  6 = Configure MS Cortana"
	printf "  7 = Configure Windows Defender (SF)"
	printf "  8 = Configure Windows Update"
	printf ""
	printf "  9 = Show Windows license status"
	printf "  10 = Windows keyboard shortcuts"
	printf ""
	printf " 									   44 = Safe Mode Settings"
	printf "  0 = Exit						     		   55 = Change language"
	printf ""
	printl " > "
	RP = scanf
	If isNumeric(RP) = False Then
		printf ""
		printf " Only numbers are allowed."
		wait 2
		Call showMenuEN()
		Exit Function
	End If
	Select Case RP
		Case 1
			Call menuSysTweaksEN()
		Case 2
			Call menuPerformanceEN()
		Case 3
			Call menuCleanAppsEN()
		Case 4
			Call menuTrackingEN()
		Case 5
			Call menuOneDriveEN()
		Case 6
			Call menuCortanaEN()
		Case 7
			Call menuWindowsDefenderEN()
		Case 8
			Call menuWindowsUpdateEN()
		Case 9
			Call menuXPREN()
		Case 10
			Call showKeyboardTipsEN()
		Case 11
			MsgBox "Options with (1X) are only compatible with Windows 10. Options with (SF) need to be ran in Safe Mode.", vbInformation + vbOkOnly, "DFX Tweaker: Ayuda"
			Call showMenuEN()
		Case 12
			Call shutdownMenuEN()
		Case 13
			oWSH.Run "winver.exe"
			Call showMenuEN()
		Case 44
			Call safemodesettingsEN()
		Case 55
			Call languageMenu()
		Case 66
			Call creativecommons()
		Case 0
			Call xpshutEN()
		Case Else
			printf ""
			printf " Only numbers are allowed."
			wait 2
			Call showMenuEN()
			Exit Function
	End Select
End Function

Function menuXPREN()
	cls
	On Error Resume Next
	printf ""
	printf " Your license status will appear in a few seconds..."
	wait 0.2
	printf " Collecting license data..."
	wait 2
	oWSH.Run "slmgr.vbs /dli"
	oWSH.Run "slmgr.vbs /xpr"
	wait 1
	Call showMenuEN
End Function

Function showBannerWASTEN()
	printf "  __        ___    ____ _____   _____           _              _     _          _ "
	printf "  \ \      / / \  / ___|_   _| | ____|_ __ ___ | |__   ___  __| | __| | ___  __| |"
	printf "   \ \ /\ / / _ \ \___ \ | |   |  _| | '_ ` _ \| '_ \ / _ \/ _` |/ _` |/ _ \/ _` |"
	printf "    \ V  V / ___ \ ___) || |   | |___| | | | | | |_) |  __/ (_| | (_| |  __/ (_| |"
	printf "     \_/\_/_/   \_\____/ |_|   |_____|_| |_| |_|_.__/ \___|\__,_|\__,_|\___|\__,_|"
	printf "                          Windows Advanced Shutdown Tool for DFX Tweaker 1.2"
	printf " "
	End Function

Function shutdownMenuEN()
	cls
	Call showBannerWASTEN()
	printf " "
	printf "  Loading WAST for DFX Tweaker..."
	wait 0.4
	printf "  Loading..."
	wait 3
	cls
	On Error Resume Next
	Call showBannerWASTEN()
	printf " "
	printf " "
	printf " "
	printf " "
	printf " "
	printf "  Select an option:"
	printf "                                            55 = Restart Windows Explorer"
	printf ""
	printf "  1 = Shut down the PC"
	printf " "
	printf "  2 = Restart the PC"
	printf " "
	printf "  3 = Log off from this user"
	printf " "
	printf "  4 = Go to advanced options"
	printf ""
	printf "  5 = Cause a BSOD (Blue Screen Of Death)"
	printf " "
	printf " "
	printf "  0 = Return to main menu"
	printf ""
	printl " > "
	RP = scanf
	If isNumeric(RP) = False Then
		printf ""
		printf " Only numbers are allowed."
		Call shutdownMenuEN()
		Exit Function
	End If
	Select Case RP
		Case 1
			result = MsgBox ("Shut down?", vbYesNo, "WAST Shutdown")
Select Case result
    Case vbYes
	Set objShell = WScript.CreateObject("WScript.Shell")
	objShell.Run "C:\WINDOWS\system32\shutdown.exe -s -t 0"
        Dim objShell
    Case vbNo
	cls
	printf = "  Wait..."
		wait 1
		Call shutdownMenuEN()
End Select
		Case 2
						result = MsgBox ("Restart?", vbYesNo, "WAST Restart")
Select Case result
    Case vbYes
	Set objShell = WScript.CreateObject("WScript.Shell")
	objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
    Case vbNo
	cls
	printf = "  Wait..."
		wait 1
		Call shutdownMenuEN()
End Select
		Case 3
						result = MsgBox ("Log off? Unsaved data will be lost.", vbYesNo, "WAST Logoff")
Select Case result
    Case vbYes
	Set objShell = WScript.CreateObject("WScript.Shell")
	objShell.Run "C:\WINDOWS\system32\shutdown.exe -l"
    Case vbNo
	cls
	printf = "  Wait..."
		wait 1
		Call shutdownMenuEN()
End Select
		Case 4
						result = MsgBox ("Go to advanced options menu? This will close all active user sessions.", vbYesNo, "WAST Advanced")
Select Case result
    Case vbYes
	Set objShell = WScript.CreateObject("WScript.Shell")
	objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -o -t 0"
	wait 1
		Call shutdownMenuEN()
    Case vbNo
	cls
	printf = "  Wait..."
		wait 1
		Call shutdownMenuEN()
End Select
		Case 5
						result = MsgBox ("Cause a BSOD? Make sure you saved ALL the data you were using.", vbYesNo, "WAST BSOD")
Select Case result
    Case vbYes
	Set objShell = WScript.CreateObject("WScript.Shell")
	objShell.Run "taskkill /f /im crss.exe"
	objShell.Run "taskkill /f /im winnit.exe"
	objShell.Run "taskkill /f /im winlogon.exe"
	objShell.Run "taskkill /f /im svchost.exe"
    Case vbNo
	cls
	printf = "  Wait..."
		wait 1
		Call shutdownMenuEN()
End Select
		Case 55
						result = MsgBox ("Restart Windows Explorer?", vbYesNo, "WAST Explorer")
Select Case result
    Case vbYes
	printf = "  Wait..."
		printf " >> Restarting Windows Explorer..."
		oWSH.Run "taskkill.exe /F /IM explorer.exe"
		wait 5
		oWSH.Run "explorer.exe"
		Call shutdownMenuEN()
    Case vbNo
	cls
	printf = "  Wait..."
		wait 1
		Call shutdownMenuEN()
End Select
Case 0
		cls
		printf "  Going back to DFX Tweaker..."
		wait 0.3
		printf "  Wait..."
		wait 2.7
		Call showMenuEN()
	End Select
End Function

Function menuSysTweaksEN()
	cls
	On Error Resume Next
	printf ""
	printf "   ____            _                   _                      _        "
	printf "  / ___| _   _ ___| |_ ___ _ __ ___   | |___      _____  __ _| | _____ "
	printf "  \___ \| | | / __| __/ _ \ '_ ` _ \  | __\ \ /\ / / _ \/ _` | |/ / __|"
	printf "   ___) | |_| \__ \ ||  __/ | | | | | | |_ \ V  V /  __/ (_| |   <\__ \"
	printf "  |____/ \__, |___/\__\___|_| |_| |_|  \__| \_/\_/ \___|\__,_|_|\_\___/"
	printf "         |___/                                                         "
	printf ""
	printf "  Select an option:"
	printf ""
	printf " "
	printf "  1 = Enable Dark mode"
	printf "  2 = Create a 'God Mode' icon on the Desktop"
	printf "  3 = Enable 'Quick Access' on Windows Explorer"
	printf "  4 = Show file extensions" 
	printf "  5 = Enable 'Classic View' on the Control Panel"
	printf "  6 = Enable Classic Volume slider"
	printf "  7 = Open CMD on pressing Win+U (SF)"
	printf "  8 = Enable/Disable User Account Control"
	printf "  9 = Enable/Disable login without password"
	printf " "
	printf ""
	printf "  0 = Back to menu		99 = Restore"
	printf ""
	printl "  > "
	Select Case scanf
		Case 1
			printf ""
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\AppsUseLightTheme", 0, "REG_DWORD"
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\AppsUseLightTheme", 0, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call menuSysTweaksEN()
		Case 2
			printf ""
		godFolder = oWSH.SpecialFolders("Desktop") & "\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
		If oFSO.FolderExists(godFolder) = False Then oFSO.CreateFolder(godFolder)
			printf ""
			printf ""
			wait 1
			Call menuSysTweaksEN()
		Case 3
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\LaunchTo", 1, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call menuSysTweaksEN()
		Case 4
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", 0, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call menuSysTweaksEN()
		Case 5
		oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\ForceClassicControlPanel", 1, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call menuSysTweaksEN()
		Case 6
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC\EnableMtcUvc", 0, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call menuSysTweaksEN()
		Case 7
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\utilman.exe\Debugger", "cmd.exe", "REG_SZ"
			printf ""
			printf ""
			wait 1
			Call menuSysTweaksEN()
		Case 9
			cls
			printf " Uncheck the option: Users must enter their name and password to use the PC"
			printf " Accept changes and restart your PC"
			wait 1
			oWSH.Run "control userpasswords2"
			wait 2
			Call menuSysTweaksEN()
		Case 99
			Call restoreSysTweaksEN()
		Case 0
			Call showMenuEN()
		Case 8
			cls
			printf "  Wait..."
			wait 2
			printf ""
			oWSH.Run "UserAccountControlSettings.exe"
			MsgBox "After changing this setting, you must restart the PC. Do you want to do it now?", vbInformation + vbYesNo, "DFX Tweaker UAC"
	Select Case result
  	  Case vbYes
		Set objShell = WScript.CreateObject("WScript.Shell")
		objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
  	  Case vbNo
		cls
		printf = "  Wait..."
			Call menuSysTweaksEN()
		Case Else
			printf ""
			printf " Only numbers are allowed."
			wait 2
			Call menuSysTweaksEN()
			Exit Function
		End Select
	End Select
End Function

Function restoreSysTweaksEN()
	cls
	On Error Resume Next	
	printf ""
	printf "   ____            _                   _       Restore        _        "
	printf "  / ___| _   _ ___| |_ ___ _ __ ___   | |___      _____  __ _| | _____ "
	printf "  \___ \| | | / __| __/ _ \ '_ ` _ \  | __\ \ /\ / / _ \/ _` | |/ / __|"
	printf "   ___) | |_| \__ \ ||  __/ | | | | | | |_ \ V  V /  __/ (_| |   <\__ \"
	printf "  |____/ \__, |___/\__\___|_| |_| |_|  \__| \_/\_/ \___|\__,_|_|\_\___/"
	printf "         |___/                                                         "
	printf ""
	printf "  Select an option:"
	printf ""
	printf " "
	printf "  1 = Disable Dark mode"
	printf "  2 = Remove the 'God Mode' icon on the Desktop"
	printf "  3 = Disable 'Quick Access' on Windows Explorer"
	printf "  4 = Stop showing file extensions" 
	printf "  5 = Disable 'Classic View' on the Control Panel"
	printf "  6 = Disable Classic Volume slider"
	printf "  7 = Disable CMD on pressing Win+U (SF)"
	printf " "
	printf ""
	printf "  0 = Back to previous menu"
	printf ""
	printl "  > "
	Select Case scanf
		Case 1
			printf ""
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\AppsUseLightTheme", 1, "REG_DWORD"
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\AppsUseLightTheme", 1, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call restoreSysTweaksEN()
		Case 2
			printf ""
		godFolder = oWSH.SpecialFolders("Desktop") & "\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
		If oFSO.FolderExists(godFolder) = True Then oFSO.DeleteFolder(godFolder)
			printf ""
			printf ""
			wait 1
			Call restoreSysTweaksEN()
		Case 3
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\LaunchTo", 2, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call restoreSysTweaksEN()
		Case 4
		oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", 1, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call restoreSysTweaksEN()
		Case 5
		oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\ForceClassicControlPanel", 0, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call restoreSysTweaksEN()
		Case 6
		oWSH.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC\EnableMtcUvc", 1, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call restoreSysTweaksEN()
		Case 7
		oWSH.RegDelete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\utilman.exe\Debugger"
			printf ""
			printf ""
			wait 1
			Call restoreSysTweaksEN()
		Case 0
			Call showMenuEN()
		Case Else
			printf ""
			printf " Only numbers are allowed."
			wait 2
			Call restoreSysTweaksEN()
			Exit Function
		End Select
End Function

Function menuOneDriveEN()
	cls
	On Error Resume Next	
	printf "   __  __ ____     ___             ____       _           "
	printf "  |  \/  / ___|   / _ \ _ __   ___|  _ \ _ __(_)_   _____ "
	printf "  | |\/| \___ \  | | | | '_ \ / _ \ | | | '__| \ \ / / _ \"
	printf "  | |  | |___) | | |_| | | | |  __/ |_| | |  | |\ V /  __/"
	printf "  |_|  |_|____/   \___/|_| |_|\___|____/|_|  |_| \_/ \___|"                                                               
	printf ""
	printf "  Select an option:"
	printf ""
	printf "  1 = Disable MS OneDrive"
	printf "  2 = Enable MS OneDrive"
	printf ""
	printf "  0 = Return to main menu"
	printf ""
	printl "  > "
	Select Case scanf
		Case "1"
			printf ""
			printf " Disabling OneDrive..."
			wait 1
				oWSH.Run "taskkill.exe /F /IM OneDrive.exe /T"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableFileSyncNGSC", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive\DisableFileSyncNGSC", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableLibrariesDefaultSaveToOneDrive", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableMeteredNetworkFileSync", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive\DisableLibrariesDefaultSaveToOneDrive", 1, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive\DisableMeteredNetworkFileSync", 1, "REG_DWORD"
				oWSH.RegWrite "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 0, "REG_DWORD"
				oWSH.RegWrite "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 0, "REG_DWORD"
				oWSH.RegWrite "HKCU\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 0, "REG_DWORD"
				oWSH.RegWrite "HKCU\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 0, "REG_DWORD"
				oWSH.RegDelete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\OneDrive"
			printf ""
			printf " INFO: OneDrive has been disabled"
			wait 2
		Case "2"
			printf ""
			printf " Enabling OneDrive..."
			wait 1
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableFileSyncNGSC", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive\DisableFileSyncNGSC", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableLibrariesDefaultSaveToOneDrive", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableMeteredNetworkFileSync", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive\DisableLibrariesDefaultSaveToOneDrive", 0, "REG_DWORD"
				oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive\DisableMeteredNetworkFileSync", 0, "REG_DWORD"
				oWSH.RegWrite "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 1, "REG_DWORD"
				oWSH.RegWrite "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 1, "REG_DWORD"
				oWSH.RegWrite "HKCU\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 1, "REG_DWORD"
				oWSH.RegWrite "HKCU\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\System.IsPinnedToNameSpaceTree", 1, "REG_DWORD"
			printf ""
			printf " INFO: OneDrive is now enabled"
			wait 2
		Case "0"
			Call showMenuEN()
		Case Else
			printf ""
			printf " Only numbers are allowed."
			wait 2
			Call menuOneDriveEN()
	End Select
	Call menuOneDriveEN()
End Function

Function menuCortanaEN()
	cls
	On Error Resume Next
	printf "   __  __ ____     ____           _                    "
	printf "  |  \/  / ___|   / ___|___  _ __| |_ __ _ _ __   __ _ "
	printf "  | |\/| \___ \  | |   / _ \| '__| __/ _` | '_ \ / _` |"
	printf "  | |  | |___) | | |__| (_) | |  | || (_| | | | | (_| |"
	printf "  |_|  |_|____/   \____\___/|_|   \__\__,_|_| |_|\__,_|"                                                         
	printf " "
	printf "  Select an option:"
	printf ""
	printf "  1 = Disable MS Cortana"
	printf "  2 = Enable MS Cortana"
	printf ""
	printf "  0 = Return to main menu"
	printf ""
	printl "  > "
	Select Case scanf
		Case "1"
			oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\AllowCortana", 0, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\CortanaEnabled", 0, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\SearchboxTaskbarMode", 0, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\BingSearchEnabled", 0, "REG_DWORD"
			printf ""
			printf " >> Restarting Windows Explorer..."
			oWSH.Run "taskkill.exe /F /IM explorer.exe"
			wait 5
			oWSH.Run "explorer.exe"
		Case "2"
			oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\AllowCortana", 1, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\CortanaEnabled", 1, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\SearchboxTaskbarMode", 1, "REG_DWORD"
			oWSH.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\BingSearchEnabled", 1, "REG_DWORD"
			printf ""
			printf " >> Restarting Windows Explorer..."
			oWSH.Run "taskkill.exe /F /IM explorer.exe"
			wait 5
			oWSH.Run "explorer.exe"
		Case "0"
			Call showMenuEN()
		Case Else
			printf ""
			printf " Only numbers are allowed."
			wait 2
			Call menuCortanaEN()
	End Select
	Call menuCortanaEN()
End Function

Function menuTrackingEN()
	cls
	On Error Resume Next
	printf "   _____               _    _             "
	printf "  |_   _| __ __ _  ___| | _(_)_ __   __ _ "
	printf "    | || '__/ _` |/ __| |/ / | '_ \ / _` |"
	printf "    | || | | (_| | (__|   <| | | | | (_| |"
	printf "    |_||_|  \__,_|\___|_|\_\_|_| |_|\__, |"
	printf "                                     |___/" 
	printf ""
	printf "  Select an option:"
	printf ""
	printf "  1 = Disable tracking"
	printf ""
	printf "  2 = Enable tracking"
	printf " "
	printf " "
	printf "  0 = Return to menu"
	printf ""
	printl "  > "
	Select Case scanf
		Case 1
			printf ""
			printf " Disabling tracking services..."
			oWSH.Run "sc stop DiagTrack"
			oWSH.Run "sc config DiagTrack start= disabled"
			oWSH.Run "sc stop dmwappushservice"
			oWSH.Run "sc config dmwappushservice start= disabled"
			wait 2
			Call menuTrackingEN()
		Case 2
			printf ""
			printf " Enabling tracking services..."
			oWSH.Run "sc start DiagTrack"
			oWSH.Run "sc config DiagTrack start= enabled"
			oWSH.Run "sc start dmwappushservice"
			oWSH.Run "sc config dmwappushservice start= enabled"
			wait 2
			Call menuTrackingEN()
		Case 0
			Call showMenuEN()
		Case Else
			printf ""
			printf " Only numbers are allowed."
			wait 2
			Call menuTrackingEN()
	End Select
	Call menuTrackingEN()
End Function

Function menuWindowsDefenderEN()
	cls
	On Error Resume Next
	printf "   __  __ ____    ____        __                _           "
	printf "  |  \/  / ___|  |  _ \  ___ / _| ___ _ __   __| | ___ _ __ "
	printf "  | |\/| \___ \  | | | |/ _ \ |_ / _ \ '_ \ / _` |/ _ \ '__|"
	printf "  | |  | |___) | | |_| |  __/  _|  __/ | | | (_| |  __/ |   "
	printf "  |_|  |_|____/  |____/ \___|_|  \___|_| |_|\__,_|\___|_|   "
	printf ""
	printf "  In Windows 10 and Windows 11 version 2004 and higher, it is recommended to disable MS Defender in Safe Mode"
	printf "  since disabling MS Defender in normal mode will not work."
	printf ""
	printf "  Select an option:"
	printf ""
	printf "  1 = Disable MS Defender"
	printf "  2 = Enable MS Defender"
	printf " "
	printf "  3 = Safe Mode Settings"
	printf ""
	printf "  0 = Return to main menu"
	printf ""
	printl "  > "
	Select Case scanf
		Case "1"
			printf ""
			printf " Disabling MS Defender..."
			wait 1
		oWSH.Run "sc stop WdNisSvc"
		oWSH.Run "sc stop WinDefend"
		oWSH.Run "sc config WdNisSvc start=disabled"
		oWSH.Run "sc config WinDefend start=disabled"	
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" & chr(34) & " /DISABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" & chr(34) & " /DISABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" & chr(34) & " /DISABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Verification" & chr(34) & " /DISABLE"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableBehaviorMonitoring", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableOnAccessProtection", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableScanOnRealtimeEnable", 1, "REG_DWORD"
		oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\NOC_GLOBAL_SETTING_TOASTS_ENABLED", 0, "REG_DWORD"	
			printf ""
			printf " INFO: MS Defender has been disabled"
			wait 2
		Case "2"
			printf ""
			printf " Enabling MS Defender..."
			wait 2
		oWSH.Run "sc config WdNisSvc start=auto"
		oWSH.Run "sc config WinDefend start=auto"	
		oWSH.Run "sc start WdNisSvc"
		oWSH.Run "sc start WinDefend"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" & chr(34) & " /ENABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" & chr(34) & " /ENABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" & chr(34) & " /ENABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Verification" & chr(34) & " /ENABLE"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 0, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 0, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableBehaviorMonitoring", 0, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableOnAccessProtection", 0, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableScanOnRealtimeEnable", 0, "REG_DWORD"
		oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\NOC_GLOBAL_SETTING_TOASTS_ENABLED", 1, "REG_DWORD"
			printf ""
			printf " INFO: MS Defender is now enabled"
			wait 2
		Case 3
			Call safemodesettingsEN()
		Case "0"
			Call showMenuEN()
		Case Else
			printf ""
			printf " Only numbers are allowed."
			wait 2
			Call menuWindowsDefenderEN()
	End Select
	Call menuWindowsDefenderEN()
End Function

Function menuWindowsUpdateEN()
	cls
	On Error Resume Next
	printf "  __        ___           _                     _   _           _       _       "
	printf "  \ \      / (_)_ __   __| | _____      _____  | | | |_ __   __| | __ _| |_ ___ "
	printf "   \ \ /\ / /| | '_ \ / _` |/ _ \ \ /\ / / __| | | | | '_ \ / _` |/ _` | __/ _ \"
	printf "    \ V  V / | | | | | (_| | (_) \ V  V /\__ \ | |_| | |_) | (_| | (_| | ||  __/"
	printf "     \_/\_/  |_|_| |_|\__,_|\___/ \_/\_/ |___/  \___/| .__/ \__,_|\__,_|\__\___|"
	printf "                                                     |_|                        "
	printf " "
	printf " "
	printf "  Select an option:"
	printf " "
	printf " "
	printf "  1 = Disable Windows Update"
	printf " "
	printf "  2 = Enable Windows Update" 
	printf " "
	printf " "
	printf "  0 = Return to menu"
	printl " > "
	RP = scanf
	If isNumeric(RP) = False Then
		printf ""
		printf " Only numbers are allowed."
	Call menuWindowsUpdateEN()
		Exit Function
	End If
	Select Case RP
		Case 1
		oWSH.Run "sc stop wuauserv"
		oWSH.Run "sc config wuauserv start=disabled"
	cls
	printf ""
	printf "  Windows Update is now disabled"
	wait 2
	Call menuWindowsUpdateEN()
		Case 2
		oWSH.Run "sc config wuauserv start=auto"
		oWSH.Run "sc start wuauserv"
	cls
	printf ""
	printf "  Windows Update is now enabled"
	wait 2
	Call menuWindowsUpdateEN()		
		Case 0
	Call showMenuEN()
End Select
End Function

Function menuPerformanceEN()
	cls
	On Error Resume Next	
	printf "   ____            __                                             _                      _        "
	printf "  |  _ \ ___ _ __ / _| ___  _ __ _ __ ___   __ _ _ __   ___ ___  | |___      _____  __ _| | _____ "
	printf "  | |_) / _ \ '__| |_ / _ \| '__| '_ ` _ \ / _` | '_ \ / __/ _ \ | __\ \ /\ / / _ \/ _` | |/ / __|"
	printf "  |  __/  __/ |  |  _| (_) | |  | | | | | | (_| | | | | (_|  __/ | |_ \ V  V /  __/ (_| |   <\__ \"
	printf "  |_|   \___|_|  |_|  \___/|_|  |_| |_| |_|\__,_|_| |_|\___\___|  \__| \_/\_/ \___|\__,_|_|\_\___/"                                                             
	printf ""
	printf ""
	printf ""
	printf "  Select an option:"
	printf ""
	printf ""
	printf "  1 = Disable BitLocker, Encryption and OfflineFiles"
	printf ""
	printf "  2 = Disable WiFi services"
	printf ""
	printf "  3 = Open Windows disk cleaner"
	printf ""
	printf "  4 = Additional Windows Features"
	printf ""
	printf "  5 = Enable all system bandwith"
	printf ""
	printf ""
	printf "  0 = Back to menu			99 = Restore"
	printf ""
	printl "  > "
	Select Case scanf
		Case 1
			printf ""
		oWSH.Run "sc config BDESVC start=disabled"
		oWSH.Run "sc config EFS start=disabled"
		oWSH.Run "sc config CscService start=disabled"
		oWSH.Run "sc stop BDESVC"
		oWSH.Run "sc stop EFS"
		oWSH.Run "sc stop CscService"
			printf ""
			printf ""
			wait 1
			Call menuPerformanceEN()
		Case 2
			printf ""
		oWSH.Run "sc config WlanSvc start=disabled"
		oWSH.Run "sc stop WlanSvc"
			printf ""
			printf ""
			wait 1
			Call menuPerformanceEN()
		Case 3
		oWSH.Run "cleanmgr.exe"
			printf ""
			printf ""
			wait 1
			Call menuPerformanceEN()
		Case 4
		oWSH.Run "optionalfeatures.exe"
			printf ""
			printf ""
			wait 1
			Call menuPerformanceEN()
		Case 5
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched\Psched", 0, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call menuPerformanceEN()
		Case 99
			Call restorePerformanceEN()
		Case 0
			Call showMenuEN()
		Case Else
			printf ""
			printf " Only numbers are allowed."
			wait 2
			Call menuPerformanceEN()
			Exit Function
		End Select
End Function

Function restorePerformanceEN()
	cls
	On Error Resume Next	
	printf "   ____            __                                             _       Restore        _        "
	printf "  |  _ \ ___ _ __ / _| ___  _ __ _ __ ___   __ _ _ __   ___ ___  | |___      _____  __ _| | _____ "
	printf "  | |_) / _ \ '__| |_ / _ \| '__| '_ ` _ \ / _` | '_ \ / __/ _ \ | __\ \ /\ / / _ \/ _` | |/ / __|"
	printf "  |  __/  __/ |  |  _| (_) | |  | | | | | | (_| | | | | (_|  __/ | |_ \ V  V /  __/ (_| |   <\__ \"
	printf "  |_|   \___|_|  |_|  \___/|_|  |_| |_| |_|\__,_|_| |_|\___\___|  \__| \_/\_/ \___|\__,_|_|\_\___/"                                                            
	printf ""
	printf ""
	printf ""
	printf "  Select an option:"
	printf ""
	printf ""
	printf "  1 = Enable BitLocker, Encryption and OfflineFiles"
	printf ""
	printf "  2 = Enable WiFi services"
	printf ""
	printf "  3 = Disable all system bandwith"
	printf ""
	printf ""
	printf "  0 = Back to previous menu"
	printf ""
	printl "  > "
	Select Case scanf
		Case 1
			printf ""
		oWSH.Run "sc config BDESVC start=auto"
		oWSH.Run "sc config EFS start=auto"
		oWSH.Run "sc config CscService start=auto"
		oWSH.Run "sc start BDESVC"
		oWSH.Run "sc start EFS"
		oWSH.Run "sc start CscService"
			printf ""
			printf ""
			wait 1
			Call restorePerformanceEN()
		Case 2
			printf ""
		oWSH.Run "sc config WlanSvc start=auto"
		oWSH.Run "sc start WlanSvc"
			printf ""
			printf ""
			wait 1
			Call restorePerformanceEN()
		Case 3
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched\Psched", 20, "REG_DWORD"
			printf ""
			printf ""
			wait 1
			Call restorePerformanceEN()
		Case 0
			Call menuPerformanceEN()
		Case Else
			printf ""
			printf " Only numbers are allowed."
			wait 2
			Call restorePerformanceEN()
			Exit Function
		End Select
End Function


Function menuCleanAppsEN()
	cls
	On Error Resume Next
	printf "      _                      _   ___        ______  "
	printf "     / \   _ __  _ __  ___  | | | \ \      / /  _ \ "
	printf "    / _ \ | '_ \| '_ \/ __| | | | |\ \ /\ / /| |_) |"
	printf "   / ___ \| |_) | |_) \__ \ | |_| | \ V  V / |  __/ "
	printf "  /_/   \_\ .__/| .__/|___/  \___/   \_/\_/  |_|    "
	printf "          |_|   |_|                                 "
	printf " "
	printf "  This will uninstall the next apps:"
	printf ""
	printf "  > Bing, Zune, Skype, XboxApp"
	printf "  > Getstarted, Messagin, 3D Builder"
	printf "  > Windows Maps, Phone, Camera, Alarms, People"
	printf "  > Windows Communications Apps, Sound Recorder"
	printf "  > Microsoft Office Hub, Office Sway, OneNote"
	printf "  > Solitaire Collection, CandyCrushSaga"
	printf ""
	printl "  This option is NOT reversible. Do you want to continue? (s/n) "
	
	If scanf = "s" Then
		oWSH.Run "powershell get-appxpackage -Name *Bing* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *Zune* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *XboxApp* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *OneNote* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *SkypeApp* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *3DBuilder* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *Getstarted* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *Microsoft.People* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *MicrosoftOfficeHub* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *MicrosoftSolitaireCollection* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *WindowsCamera* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *WindowsAlarms* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *WindowsMaps* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *WindowsPhone* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *WindowsSoundRecorder* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *windowscommunicationsapps* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *CandyCrushSaga* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *Messagin* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *ConnectivityStore* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *CommsPhone* | Remove-AppxPackage", 1, True
		oWSH.Run "powershell get-appxpackage -Name *Office.Sway* | Remove-AppxPackage", 1, True
		printf ""
		printf " > All apps have been successfully uninstalled..."
	Else
		printf ""
		printf " > Operation cancelled."
	End If
	wait 2
	Call showMenuEN(2)
End Function

Function safemodesettingsEN()
	cls
	printf " "
	printf "   ____         __        __  __           _        ____       _   _   _                 "
	printf "  / ___|  __ _ / _| ___  |  \/  | ___   __| | ___  / ___|  ___| |_| |_(_)_ __   __ _ ___ "
	printf "  \___ \ / _` | |_ / _ \ | |\/| |/ _ \ / _` |/ _ \ \___ \ / _ \ __| __| | '_ \ / _` / __|"
	printf "   ___) | (_| |  _|  __/ | |  | | (_) | (_| |  __/  ___) |  __/ |_| |_| | | | | (_| \__ \"
	printf "  |____/ \__,_|_|  \___| |_|  |_|\___/ \__,_|\___| |____/ \___|\__|\__|_|_| |_|\__, |___/"
	printf "                                                                              |___/      "
	printf " "
	printf " "
	printf "  Select an option:"
	printf " "
	printf " "
	printf "  1 = Restart in Safe Mode (Normal)"
	printf " "
	printf "  2 = Restart in Safe Mode (Networking)"
	printf " "
	printf "  3 = Reboot to Standard Windows"
	printf " "
	printf " "
	printf "  0 = Return to menu"
	printf " "
	printl " > "
	RP = scanf
	If isNumeric(RP) = False Then
		printf ""
		printf " Only numbers are allowed."
		wait 2
		Call safemodesettingsEN()
		Exit Function
	End If
	Select Case RP
	Case 1	
		MsgBox "Your PC will reboot right after you close this window, make sure you saved all your data", vbInformation + vbOkOnly, "DFX Tweaker Safe Mode"
		Set objShell = WScript.CreateObject("WScript.Shell")
		oWSH.Run "bcdedit /set {current} safeboot minimal"
		wait 1
		objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
	Case 2
		MsgBox "Your PC will reboot right after you close this window, make sure you saved all your data", vbInformation + vbOkOnly, "DFX Tweaker Safe Mode"
		Set objShell = WScript.CreateObject("WScript.Shell")
		oWSH.Run "bcdedit /set {current} safeboot network"
		wait 1
		objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
	Case 3
		MsgBox "Your PC will reboot right after you close this window, make sure you did all your changes", vbInformation + vbOkOnly, "DFX Tweaker Safe Mode"
		Set objShell = WScript.CreateObject("WScript.Shell")
		oWSH.Run "bcdedit /deletevalue {current} safeboot"
		wait 1
		objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
	Case 0
		cls
		wait 1
		Call showMenuEN()
		Exit Function
	End Select
End Function

Function showKeyboardTipsEN()
	msg = msg & "WIN+A		Open the activity center" & vbcrlf
	msg = msg & "WIN+C		Turn on Cortana's voice recognition" & vbcrlf
	msg = msg & "WIN+D		Show desktop" & vbcrlf
	msg = msg & "WIN+E		Open Windows Explorer" & vbcrlf
	msg = msg & "WIN+G		Activate Game DVR to record the screen" & vbcrlf
	msg = msg & "WIN+H		Share in Modern apps for Windows 10" & vbcrlf
	msg = msg & "WIN+I		Open system settings" & vbcrlf
	msg = msg & "WIN+K		Launch 'Connect' to send data to devices" & vbcrlf
	msg = msg & "WIN+L		Lock the PC" & vbcrlf
	msg = msg & "WIN+R		Run a command" & vbcrlf
	msg = msg & "WIN+S		Open Cortana" & vbcrlf
	msg = msg & "WIN+X		Open advanced options menu" & vbcrlf
	msg = msg & "WIN+TAB		Open the task view" & vbcrlf
	msg = msg & "WIN+Arrows		Move a windows around the screen (Windows Snap)" & vbcrlf
	msg = msg & "WIN+CTRL+D		Create a Virtual Desktop" & vbcrlf
	msg = msg & "WIN+CTRL+F4	Close a Virtual Desktop" & vbcrlf
	msg = msg & "WIN+CTRL+Arrows	Change Virtual Desktop" & vbcrlf
	msg = msg & "WIN+SHIFT+Arrows	Move the actual window to another monitor" & vbcrlf
	
	MsgBox msg, vbOkOnly, "DFX Tweaker: Keyboard shortcuts"
	Call showMenuEN(0)
End Function

Function xpshutEN()
printf " "
printf " "
printf " "
printf " "
printf "________________________________________________________________________________________________________________________"
printf " "
printf " "
printf " "
printf " "
printf " "
printf" 		    ____  _______  __  _____                    _		    "
printf"  		   |  _ \|  ___\ \/ / |_   _|_      _____  __ _| | _____ _ __ "
printf"  		   | | | | |_   \  /    | | \ \ /\ / / _ \/ _` | |/ / _ \ '__|"
printf"  		   | |_| |  _|  /  \    | |  \ V  V /  __/ (_| |   <  __/ |   "
printf"  		   |____/|_|   /_/\_\   |_|   \_/\_/ \___|\__,_|_|\_\___|_| is now closing...  "
printf " "
printf " "
printf " "
printf " 						2022 ivandfx"
printf " "
printf " "
printf " "
printf "________________________________________________________________________________________________________________________"
printf " "
printf " "
printf " "
printf " "
wait 2
WScript.Quit
End Function

Function xpshutES()
printf " "
printf " "
printf " "
printf " "
printf "________________________________________________________________________________________________________________________"
printf " "
printf " "
printf " "
printf " "
printf " "
printf" 		    ____  _______  __  _____                    _		    "
printf"  		   |  _ \|  ___\ \/ / |_   _|_      _____  __ _| | _____ _ __ "
printf"  		   | | | | |_   \  /    | | \ \ /\ / / _ \/ _` | |/ / _ \ '__|"
printf"  		   | |_| |  _|  /  \    | |  \ V  V /  __/ (_| |   <  __/ |   "
printf"  		   |____/|_|   /_/\_\   |_|   \_/\_/ \___|\__,_|_|\_\___|_| se esta cerrando...  "
printf " "
printf " "
printf " "
printf " 						2022 ivandfx"
printf " "
printf " "
printf " "
printf "________________________________________________________________________________________________________________________"
printf " "
printf " "
printf " "
printf " "
wait 2
WScript.Quit
End Function

Function printf(txt)
	WScript.StdOut.WriteLine txt
End Function

Function printl(txt)
	WScript.StdOut.Write txt
End Function

Function scanf()
	scanf = LCase(WScript.StdIn.ReadLine)
End Function

Function wait(n)
	WScript.Sleep Int(n * 1000)
End Function

Function cls()
	For i = 1 To 50
		printf ""
	Next
End Function

Function ForceConsole()
	If InStr(LCase(WScript.FullName), "cscript.exe") = 0 Then
		oWSH.Run "cscript //NoLogo " & Chr(34) & WScript.ScriptFullName & Chr(34)
		WScript.Quit
	End If
End Function

Function checkW10orW11()
	If getNTversion < 10 Then
	cls
	Call archCheck()
	printf " "
	printf "  Loading DFX Tweaker Minimal..."
	wait 0.3
	cls
	printf"   ____  _______  __  _____   Windows 7/8.x    _   Minimal "
	printf"  |  _ \|  ___\ \/ / |_   _|_      _____  __ _| | _____ _ __ "
	printf"  | | | | |_   \  /    | | \ \ /\ / / _ \/ _` | |/ / _ \ '__|"
	printf"  | |_| |  _|  /  \    | |  \ V  V /  __/ (_| |   <  __/ |   "
	printf"  |____/|_|   /_/\_\   |_|   \_/\_/ \___|\__,_|_|\_\___|_|   "
        printf "     Created by ivandfx              		          v" & currentVersion
	printf " "
	printf "  Select an option:			       44 = Reboot to Safe Mode"
	printf " 					       55 = Restart to Standard Windows"
	printf " "
	printf "  1 = Disable Windows Update"
	printf "  2 = Disable Windows Defender (SF)"
	printf "  3 = Create a 'God Mode' icon on the Desktop"
	printf "  4 = Open Windows disk cleaner"
	printf "  5 = Additional Windows Features"
	printf " "
	printf "  88 = DFX Tweaker Web"
	printf "  0 = Close				       99 = Restore"
	printf " "
	printl " > "
	RP = scanf
	If isNumeric(RP) = False Then
		printf ""
		printf " Only numbers are allowed."
		wait 2
		Call checkW10orW11()
		Exit Function
	End If
	Select Case RP
	Case 1
		oWSH.Run "sc stop wuauserv"
		oWSH.Run "sc config wuauserv start=disabled"
		Call checkW10orW11()
	Case 2
		oWSH.Run "sc stop WdNisSvc"
		oWSH.Run "sc stop WinDefend"
		oWSH.Run "sc config WdNisSvc start=disabled"
		oWSH.Run "sc config WinDefend start=disabled"	
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" & chr(34) & " /DISABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" & chr(34) & " /DISABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" & chr(34) & " /DISABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Verification" & chr(34) & " /DISABLE"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableBehaviorMonitoring", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableOnAccessProtection", 1, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableScanOnRealtimeEnable", 1, "REG_DWORD"
		oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\NOC_GLOBAL_SETTING_TOASTS_ENABLED", 0, "REG_DWORD"
		Call checkW10orW11()
	Case 3
		godFolder = oWSH.SpecialFolders("Desktop") & "\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
		If oFSO.FolderExists(godFolder) = False Then oFSO.CreateFolder(godFolder)
			printf ""
			printf ""
			wait 1
			Call checkW10orW11()
		Case 4
		oWSH.Run "cleanmgr.exe"
			printf ""
			printf ""
			wait 1
			Call checkW10orW11()
		Case 5
		oWSH.Run "optionalfeatures.exe"
			printf ""
			printf ""
			wait 1
			Call checkW10orW11()
	Case 44
		MsgBox "Your PC will reboot right after you close this window, make sure you saved all your data", vbInformation + vbOkOnly, "DFX Tweaker Safe Mode"
		Set objShell = WScript.CreateObject("WScript.Shell")
		oWSH.Run "bcdedit /set {current} safeboot minimal"
		wait 1
		objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
	Case 55
		MsgBox "Your PC will reboot right after you close this window, make sure you did all your changes", vbInformation + vbOkOnly, "DFX Tweaker Safe Mode"
		Set objShell = WScript.CreateObject("WScript.Shell")
		oWSH.Run "bcdedit /deletevalue {current} safeboot"
		wait 1
		objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
	Case 88
		Dim url
		Set url= CreateObject("WScript.Shell")
		url.Run "https://ivandfx.github.io/DFXTweaker", 9
		Call checkW10orW11()
	Case 99
		Call dfxlegacyrestore()
	Case 0
		WScript.Quit
	End Select
End If
End Function

Function dfxlegacyrestore()
	cls
	printf"   ____  _______  __  _____   Windows 7/8.x    _   Minimal "
	printf"  |  _ \|  ___\ \/ / |_   _|_      _____  __ _| | _____ _ __ "
	printf"  | | | | |_   \  /    | | \ \ /\ / / _ \/ _` | |/ / _ \ '__|"
	printf"  | |_| |  _|  /  \    | |  \ V  V /  __/ (_| |   <  __/ |   "
	printf"  |____/|_|   /_/\_\   |_|   \_/\_/ \___|\__,_|_|\_\___|_|   "
        printf "     Created by ivandfx           Restore Menu	          v" & currentVersion
	printf " "
	printf "  Select an option:			       44 = Reboot to Safe Mode"
	printf " 					       55 = Restart to Standard Windows"
	printf " "
	printf "  1 = Enable Windows Update"
	printf "  2 = Enable Windows Defender (SF)"
	printf "  3 = Delete the 'God Mode' icon on the Desktop"
	printf " "
	printf "  88 = DFX Tweaker Web"
	printf "  0 = Back to previous menu"
	printf " "
	printl " > "
	RP = scanf
	If isNumeric(RP) = False Then
		printf ""
		printf " Only numbers are allowed."
		wait 2
		Call dfxlegacyrestore()
		Exit Function
	End If
	Select Case RP
	Case 1
		oWSH.Run "sc start wuauserv"
		oWSH.Run "sc config wuauserv start=auto"
		Call dfxlegacyrestore()
	Case 2
		oWSH.Run "sc config WdNisSvc start=auto"
		oWSH.Run "sc config WinDefend start=auto"	
		oWSH.Run "sc start WdNisSvc"
		oWSH.Run "sc start WinDefend"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" & chr(34) & " /ENABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" & chr(34) & " /ENABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" & chr(34) & " /ENABLE"
		oWSH.Run "schtasks /change /TN " & chr(34) & "\Microsoft\Windows\Windows Defender\Windows Defender Verification" & chr(34) & " /ENABLE"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 0, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\DisableAntiSpyware", 0, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableBehaviorMonitoring", 0, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableOnAccessProtection", 0, "REG_DWORD"
		oWSH.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableScanOnRealtimeEnable", 0, "REG_DWORD"
		oWSH.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\NOC_GLOBAL_SETTING_TOASTS_ENABLED", 1, "REG_DWORD"
		Call dfxlegacyrestore()
	Case 3
		godFolder = oWSH.SpecialFolders("Desktop") & "\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
		If oFSO.FolderExists(godFolder) = True Then oFSO.DeleteFolder(godFolder)
			wait 1
			Call dfxlegacyrestore()
	Case 44
		MsgBox "Your PC will reboot right after you close this window, make sure you saved all your data", vbInformation + vbOkOnly, "DFX Tweaker Safe Mode"
		Set objShell = WScript.CreateObject("WScript.Shell")
		oWSH.Run "bcdedit /set {current} safeboot minimal"
		wait 1
		objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
	Case 55
		MsgBox "Your PC will reboot right after you close this window, make sure you did all your changes", vbInformation + vbOkOnly, "DFX Tweaker Safe Mode"
		Set objShell = WScript.CreateObject("WScript.Shell")
		oWSH.Run "bcdedit /deletevalue {current} safeboot"
		wait 1
		objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"
	Case 88
		Dim url
		Set url= CreateObject("WScript.Shell")
		url.Run "https://ivandfx.github.io/DFXTweaker", 9
		Call dfxlegacyrestore()
	Case 0
		Call checkW10orW11()
	End Select
End Function

Function runElevated()
	If isUACRequired Then
		If Not isElevated Then RunAsUAC
	Else
		If Not isAdmin Then
			printf "  You need to run DFX Tweaker as Administrator"
			printf ""
			printf " Press Enter to exit"
			scanf
			WScript.Quit
		End If
	End If
End Function
 
Function isUACRequired()
	r = isUAC()
	If r Then
		intUAC = oWSH.RegRead("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA")
		r = 1 = intUAC
	End If
	isUACRequired = r
End Function

Function isElevated()
	isElevated = CheckCredential("S-1-16-12288")
End Function

Function isAdmin()
	isAdmin = CheckCredential("S-1-5-32-544")
End Function
 
Function CheckCredential(p)
	Set oWhoAmI = oWSH.Exec("whoami /groups")
	Set WhoAmIO = oWhoAmI.StdOut
	WhoAmIO = WhoAmIO.ReadAll
	CheckCredential = InStr(WhoAmIO, p) > 0
End Function
 
Function RunAsUAC()
	If isUAC Then
		printf ""
		printf "  DFX Tweaker needs to be ran with Administrator privileges"
		oAPP.ShellExecute "cscript", "//NoLogo " & Chr(34) & WScript.ScriptFullName & Chr(34), "", "runas", 1
		WScript.Quit
	End If
End Function
 
Function isUAC()
	Set cWin = oWMI.ExecQuery("SELECT * FROM Win32_OperatingSystem")
	r = False
	For Each OS In cWin
		If Split(OS.Version,".")(0) > 5 Then
			r = True
		Else
			r = False
		End If
	Next
	isUAC = r
End Function

Function archCheck()
Dim WshShell
Dim WshProcEnv
Dim system_architecture
Dim process_architecture

Set WshShell =  CreateObject("WScript.Shell")
Set WshProcEnv = WshShell.Environment("Process")

process_architecture= WshProcEnv("PROCESSOR_ARCHITECTURE") 

If process_architecture = "x86" Then    
    system_architecture= WshProcEnv("PROCESSOR_ARCHITEW6432")

    If system_architecture = ""  Then    
        system_architecture = "x86"
    End if    
Else    
    system_architecture = process_architecture    
End If

printf " "
printf "  Detected " & process_architecture & " process, " & system_architecture & " system."
End Function

Function CheckCredential(p)
	Set oWhoAmI = oWSH.Exec("whoami /groups")
	Set WhoAmIO = oWhoAmI.StdOut
	WhoAmIO = WhoAmIO.ReadAll
	CheckCredential = InStr(WhoAmIO, p) > 0
End Function
 
Function RunAsUAC()
	If isUAC Then
		printf ""
		printf "  DFX Tweaker needs to be ran with Administrator privileges..."
		printf "  Wait..."
		oAPP.ShellExecute "cscript", "//NoLogo " & Chr(34) & WScript.ScriptFullName & Chr(34), "", "runas", 1
		WScript.Quit
	End If
End Function
 
Function isUAC()
	Set cWin = oWMI.ExecQuery("SELECT * FROM Win32_OperatingSystem")
	r = False
	For Each OS In cWin
		If Split(OS.Version,".")(0) > 5 Then
			r = True
		Else
			r = False
		End If
	Next
	isUAC = r
End Function

Function getNTversion()
	Set cWin = oWMI.ExecQuery("SELECT * FROM Win32_OperatingSystem")
	For Each OS In cWin
		getNTversion = Split(OS.Version,".")(0)
	Next
End Function
