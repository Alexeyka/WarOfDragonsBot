#include <ButtonConstants.au3>
#include <GuiButton.au3>
#include <ComboConstants.au3>
#include <ColorConstants.au3>
#include <GuiListBox.au3>
#include <EditConstants.au3>
#include <Constants.au3>
#include <GuiComboBoxEx.au3>
#include <GuiImageList.au3>
#include <GuiScrollBars.au3>
#include <GUIListView.au3>
#include <Misc.au3>
#include <Array.au3>
#include <Sound.au3>
#include <GUIConstantsEx.au3>
#include <GUIListView.au3>
#include <WindowsConstants.au3>

;создание окна

Func createGUI()
	$hwnd = GUICreate($ProgramName, 400, 430)
	GUISetBkColor(0x00E0FFFF)
	GUISetFont(9, 300)
	$PlayButton = GUICtrlCreateButton("Запустить", 286, 385, 40, 40, $BS_ICON)
	GUICtrlSetTip($PlayButton, "Запустить (Ctrl + W)")
	_GUICtrlButton_SetImage($PlayButton, @ScriptDir & "\im.dll", 1)
	$StopButton = GUICtrlCreateButton("", 80, 385, 40, 40, $BS_ICON)
	_GUICtrlButton_SetImage($StopButton, @ScriptDir & "\im.dll", 0)
	GUICtrlSetTip($StopButton, "Пауза (Ctrl + S)")
	GUICtrlCreateTab(10, 10, 383, 370)
	GUICtrlCreateTabItem("Сбор ресурсов")
	GUISetFont(9, 700)
	GUICtrlCreateLabel("Настройка сбора ресурсов" & @LF & "Версия " & $Version, 30, 50)
	GUISetFont(9, 300)
	$Combo = GUICtrlCreateCombo("Растения", 220, 50, 153, 50, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, "Камни")
	GUICtrlSetData(-1, "События")
	GUICtrlCreateGroup("", 30, 79, 170, 223)
	GUICtrlCreateLabel("АС - бот для онлайн игры ""Легенда"". Программа является эмулятором действий игрока" & _
			", а именно: " & @CR & "• сбор ресурсов " & @CR & "• отбивание атаки моба" & @CR & "• вытаскивание занозы" & @CR & _
			"  Помощь с настройками в соответсвующем разделе. Напоминаем, что подобные программы ЗАПРЕЩЕНЫ правилами " & _
			"игры и Вы испо- льзуете их на свой страх и риск.", 35, 89, 165, 220)
	GUICtrlSetColor(-1, 0x848482)
	$advice = GUICtrlCreateIcon(@ScriptDir & "\im.dll", 17, 183, 333, 40, 40)
	$agr = GUICtrlCreateGroup("Выберите тип мобов, которых будет избегать бот", 30, 315, 340, 60)
	;GUICtrlSetState(-1, $GUI_HIDE)

	$agrR = GUICtrlCreateCheckbox("Агрессивный", 70, 330) ; 0xB00000 0xB30000 0xAE0000 0xAC0000 0xB32300
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($agrR), "wstr", 0, "wstr", 0)
	GUICtrlSetColor($agrR, 0xFF0000)
	;типа охранник 10  - красный
	$agrO = GUICtrlCreateCheckbox("Раздраженный", 70, 349);0xAF6800 0xB06900 0xFB9600 0xB36B00 0xAF6800  0xAF8C00 0xB08C00 0xB38F00
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($agrO), "wstr", 0, "wstr", 0)
	GUICtrlSetColor($agrO, 0xFF9900)
	;типа пес 2 уровня ,скелет 2 уровня   зеленый
	$agrG = GUICtrlCreateCheckbox("Пассивный", 240, 330);  0x47B300 0x46B100    0x46B100 0x46B000
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($agrG), "wstr", 0, "wstr", 0)
	GUICtrlSetColor($agrG, 0x66FF00)
	;типа древень - желтый  ;типа скелета 3 уровня - зеленый
	$agrY = GUICtrlCreateCheckbox("Спокойный", 240, 349); 0xB1B100 0xB3B300 0xADAD00 0x8FB300 0x8DB100 0x8DB100
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($agrY), "wstr", 0, "wstr", 0)
	GUICtrlSetColor($agrY, 0xCCFF00)
	;типа матерый пес - оранжевый  типа желтый - пес демон
	$hListView = GUICtrlCreateListView("", 220, 84, 153, 217, $LVS_NOCOLUMNHEADER + $LVS_ICON); $LVS_LIST)
	$hListView = GUICtrlGetHandle(-1)
	$hImage = _GUIImageList_Create(16, 16, 5, 3)
	For $i = 0 To 15 Step 1
		_GUIImageList_AddIcon($hImage, @ScriptDir & "\im.dll", $i)
	Next
	_GUICtrlListView_SetImageList($hListView, $hImage, 1)
	GUICtrlSetBkColor(-1, 0x00E0FFFF)
	_GUICtrlListView_AddColumn($hListView, "Растения", 130)
	_GUICtrlListView_AddItem($hListView, "Сугроб[0]", 1)
	_GUICtrlListView_AddItem($hListView, "Омела[0]", 9)
	_GUICtrlListView_AddItem($hListView, "Чертополох[0]", 3)
	_GUICtrlListView_AddItem($hListView, "Клевер[0]", 13)
	_GUICtrlListView_AddItem($hListView, "Огневик[0]", 10)
	_GUICtrlListView_AddItem($hListView, "Тысячелистник[30]", 5)
	_GUICtrlListView_AddItem($hListView, "Розмарин[30]", 6)
	_GUICtrlListView_AddItem($hListView, "Ирис[30]", 14)
	_GUICtrlListView_AddItem($hListView, "Анемон[60]", 4)
	_GUICtrlListView_AddItem($hListView, "Лотос[60]", 12)
	_GUICtrlListView_AddItem($hListView, "Мандрагора[60]", 11)
	_GUICtrlListView_AddItem($hListView, "Белладонна[90]", 15)
	_GUICtrlListView_AddItem($hListView, "Вкусноцвет[120]", 7)
	_GUICtrlListView_AddItem($hListView, "Повей-трава[150]", 8)
	GUICtrlCreateTabItem("Задать интервал")
	$ruleTQ = GUICtrlCreateCheckbox("Продолжительность сессии", 30, 150) ;
	GUICtrlCreateLabel("выход после сбора", 30, 173)
	GUICtrlCreateLabel("ресурсов.", 199, 173)
	GUICtrlCreateLabel("минут или", 270, 155)
	$inputTime = GUICtrlCreateInput("0", 210, 155, 55, 20, $ES_NUMBER)
	GUICtrlCreateUpdown(-1)
	$inputQuantity = GUICtrlCreateInput("0", 142, 173, 55, 20, $ES_NUMBER)
	GUICtrlCreateUpdown(-1)
	$randomDelay = GUICtrlCreateCheckbox("Совершать случайную задержку от ", 30, 80) ;
	$input1 = GUICtrlCreateInput("0", 250, 80, 45, 20, $ES_NUMBER)
	GUICtrlCreateUpdown(-1)
	GUICtrlCreateLabel("до", 301, 80)
	$input2 = GUICtrlCreateInput("0", 320, 80, 45, 20, $ES_NUMBER)
	GUICtrlCreateUpdown(-1)
	GUICtrlCreateLabel("мин", 365, 80)
	GUICtrlCreateLabel("В промежутке от", 30, 110)
	$input3 = GUICtrlCreateInput("0", 135, 110, 45, 20, $ES_NUMBER)
	GUICtrlCreateUpdown(-1)
	GUICtrlCreateLabel("до", 185, 110)
	$input4 = GUICtrlCreateInput("0", 210, 110, 45, 20, $ES_NUMBER)
	GUICtrlCreateUpdown(-1)
	$rulezaderjka = GUICtrlCreateCheckbox("Делать случайную задержку перед сбором ресурса", 30, 130) ;
	GUISetFont(9, 700)
	GUICtrlCreateLabel("Настройка интервала сбора ресурсов", 30, 50)
	GUISetFont(9, 300)
	GUICtrlCreateLabel("_________________________________________________", 30, 200)
	GUICtrlSetColor(-1, 0x848482)
	GUICtrlCreateLabel("В данной настройке указывается скорость работы бота. " & @CRLF & _
			"При указании всех пунктов, которые влияют на скорость " & @CRLF & "работы, производительность бота может резко ухудшиться," & @CRLF & _
			"что приведет к меньшему колличеству ресурсов за " & @CRLF & "определенный интервал времени.", 30, 220)
	GUICtrlSetColor(-1, 0x848482)
	GUICtrlCreateTabItem("Разное")
	;$ruleRandomClick = GUICtrlCreateCheckbox("При поиске ресурсов, нажимать на случайное место на", 30, 90)
	;$ruleZanoza = GUICtrlCreateCheckbox("Пытаться избавится от занозы в автоматическом режиме", 30, 130)
	;$labelZanoza = GUICtrlCreateLabel("Введите сообщение, которое бот будет писать бот в чат", 30, 160)
	;$inputZanoza = GUICtrlCreateInput("", 30, 185, 350, 20)

	;GUICtrlCreateLabel(" карте (снижает скорость работы бота) ", 30, 110)
	;$ruradio = GUICtrlCreateRadio("Русская", 40, 65)
	;$plradio = GUICtrlCreateRadio("Польская", 130, 65)
	;$sickleZone = GUICtrlCreateGroup("Укажите цвет серпа", 30, 205, 180, 40)
	;$sickleGreen = GUICtrlCreateRadio("Зеленый", 130, 220)
	;$sickleGrey = GUICtrlCreateRadio("Серый", 40, 220)
	;$usePotions = GUICtrlCreateCheckbox("Разрешать использовать эликсиры", 30, 250)
	$superHits = GUICtrlCreateButton('Установить супер-удар', 30, 180, 135, 20)
	$adHouse = GUICtrlCreateButton('AHOUSE', 30, 140, 135, 20)
	$attackMob = GUICtrlCreateCheckbox("Не совершать проверку на то что это ресурс ", 30, 220)
	;$dontshowTip = GUICtrlCreateCheckbox("Не показывать всплывающую подсказку", 30, 250)
	Local $aAccelKeys[3][2] = [["^w", $PlayButton],["^s", $StopButton]]
	GUISetAccelerators($aAccelKeys)
	GUICtrlSetTip($rulezaderjka, "Перед сбором ресурса будет задержка в пределах 2 секунд")
	GUICtrlSetTip($ruleTQ, "Бот будет собирать ресурсы до необходимого кол-ва, или  до указанного времени")
	GUICtrlSetTip($randomDelay, "При указании, необходимо чтобы значения не были равны нулю")
	;GUICtrlSetTip($ruleRandomClick, "Каждый раз будет совершен случайный клик перед сбором ресурса")
	GUICtrlSetTip($agrG, "Бешеный пес [2],Зигред [2],Дряхлый скелет [2] и др.")
	GUICtrlSetTip($agrO, "Матерый пес демон [4],Гордт [6],Гордт-разбойник [7] и др.")
	GUICtrlSetTip($agrR, "Королевский скорпион [10],Большой скорпион [9]")
	GUICtrlSetTip($agrY, "Пес демон [3],Зомби [4],Кровавый зигред [5] и др.")
	GUICtrlSetTip($advice, "В данном меню можно указать каких мобов будет избегать бот. " & @CR & "Функция полезна, если в локации есть патрульные. " & @CR & _
			"Так же, чтобы настроить собственную комбинацию для пробития и/или" & @CR & _
			"запретить использовать эликсиры в бою, нужно перейти в меню ""Разное"" ", "Подсказка", 1)
	;GUICtrlCreateTabItem("Список изменений")
	;GUICtrlCreateEdit(FileRead("Info.dat"), 30, 50, 350, 280, $WS_VSCROLL + $ES_READONLY)
	GUIRegisterMsg($WM_NOTIFY, 'WM_NOTIFY')
	GUICtrlCreateTabItem("Помощь")
	$helpList = GUICtrlCreateList("", 20, 80, 125, 290)
	GUICtrlSetBkColor(-1, 0x00E0FFFF)
	;подумаем что можно добавить...
	GUICtrlSetData(-1, "Добыча ресурсов|Заноза|Эликсиры|Нападение моба|Список изменений")
	GUISetFont(9, 700)
	GUICtrlCreateLabel("Содержание", 20, 60)
	GUICtrlCreateLabel("Информация", 220, 60)
	GUISetFont(9, 300)
	$helpEdit = GUICtrlCreateEdit("", 155, 80, 225, 280, $WS_VSCROLL + $ES_READONLY)
	$textFile = FileRead('info.dat') ;Читаем файл
	$textArray = StringSplit($textFile, @CRLF, 1)

	$green = IniRead("settings.ini", "settings", "green", "True")
	$yellow = IniRead("settings.ini", "settings", "yellow", "True")
	$red = IniRead("settings.ini", "settings", "red", "True")
	$orange = IniRead("settings.ini", "settings", "orange", "True")
	;$flagRandomClick = IniRead("settings.ini", "settings", "random1", "False")
	$flagRandomWait = IniRead("settings.ini", "settings", "random2", "False")
	$flagRandomDelay = IniRead("settings.ini", "settings", "delay1", "False")
	$flagTimeQuant = IniRead("settings.ini", "settings", "delay2", "False")
	;$flagversion = IniRead("settings.ini", "settings", "version", "True")
	;$flagzanoza = IniRead("settings.ini", "settings", "splinter", "True")
	;$flagDrinkPotions = IniRead("settings.ini", "settings", "potions", "True")
	;$flagGrey = IniRead("settings.ini", "settings", "sickle", "True")
	$input11 = IniRead("settings.ini", "bar", "min1", "0")
	$input21 = IniRead("settings.ini", "bar", "min2", "0")
	$input31 = IniRead("settings.ini", "bar", "max1", "0")
	$input41 = IniRead("settings.ini", "bar", "max2", "0")
	$inputQ = IniRead("settings.ini", "bar", "pick", "0")
	$inputT = IniRead("settings.ini", "bar", "time", "0")
	GUICtrlSetData($input1, $input11)
	GUICtrlSetData($input2, $input21)
	GUICtrlSetData($input3, $input31)
	GUICtrlSetData($input4, $input41)
	GUICtrlSetData($inputQuantity, $inputQ)
	GUICtrlSetData($inputTime, $inputT)
	;If $flagzanoza == True Then
	;	GUICtrlSetState($ruleZanoza, $GUI_CHECKED)
	;Else
	;	GUICtrlSetState($labelZanoza, $GUI_HIDE)
	;	GUICtrlSetState($inputZanoza, $GUI_HIDE)
	;EndIf
	;If $flagRandomClick == True Then GUICtrlSetState($ruleRandomClick, $GUI_CHECKED)
	;If $flagGrey == True Then
	;	GUICtrlSetState($sickleGrey, $GUI_CHECKED)
	;Else
	;	GUICtrlSetState($sickleGreen, $GUI_CHECKED)
	;	EndIf
	If $flagRandomWait == True Then GUICtrlSetState($rulezaderjka, $GUI_CHECKED)
	If $flagRandomDelay == True Then GUICtrlSetState($randomDelay, $GUI_CHECKED)
	If $flagTimeQuant == True Then GUICtrlSetState($ruleTQ, $GUI_CHECKED)
	;If $flagDrinkPotions == True Then GUICtrlSetState($usePotions, $GUI_CHECKED)
	If $green == True Then GUICtrlSetState($agrG, $GUI_CHECKED)
	If $yellow == True Then GUICtrlSetState($agrY, $GUI_CHECKED)
	If $red == True Then GUICtrlSetState($agrR, $GUI_CHECKED)
	If $orange == True Then GUICtrlSetState($agrO, $GUI_CHECKED)
	GUISetState(@SW_SHOW)
EndFunc   ;==>createGUI

;функция для чтения что выбрал пользователь.
Func WM_NOTIFY($hwnd, $iMsg, $wParam, $lParam)
	Local $tNMITEMACTIVATE = DllStructCreate($tagNMITEMACTIVATE, $lParam)
	Local $hWndFrom = DllStructGetData($tNMITEMACTIVATE, 'hWndFrom')
	Local $Index = DllStructGetData($tNMITEMACTIVATE, 'Index')
	Local $Code = DllStructGetData($tNMITEMACTIVATE, 'Code')

	Switch $hWndFrom
		Case $hListView
			Switch $Code
				Case $LVN_ITEMCHANGED
					If (BitAND(DllStructGetData($tNMITEMACTIVATE, 'NewState'), $LVIS_SELECTED)) And (Not BitAND(DllStructGetData($tNMITEMACTIVATE, 'OldState'), $LVIS_FOCUSED)) Then
						;ConsoleWrite(_GUICtrlListView_GetItemText($hListView, $Index & ' has been selected.') & @CR)
						$answerPlant = _GUICtrlListView_GetItemText($hListView, $Index)
					EndIf
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

;функция чтения сообщений из ГУИ
Func Read()
	ToolTip("")
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				Terminate()
			Case $helpList
				$search = GUICtrlRead($helpList)
				If $search == $tempStr Then ContinueLoop
				$tempStr = $search
				For $i = 1 To $textArray[0]
					If StringInStr($textArray[$i], $search) Then
						GUICtrlSetData($helpEdit, "")
						$i += 1
						If $tempStr = "Список изменений" Then
							While $textArray[$i] <> "@"
								GUICtrlSetData($helpEdit, $textArray[$i] & @CRLF, 1)
								$i += 1

							WEnd
						Else
							While $textArray[$i] <> "@"
								GUICtrlSetData($helpEdit, $textArray[$i] & @CR, 1)
								$i += 1
							WEnd
						EndIf
						ExitLoop
					EndIf
				Next


			Case $PlayButton

				;ConsoleWrite($answerPlant & " " & @CR)
				Sleep(5)
				If $answerPlant = "Омела[0]" Then
					$Plant = 0x0001B1
				ElseIf $answerPlant = "Сугроб[0]" Then
					$Plant = 0x9BAFB9

					;$TimeGO = 17000
				ElseIf $answerPlant = "Чертополох[0]" Then
					$Plant = 0xB70906
					;$TimeGO = 17000
				ElseIf $answerPlant = "Клевер[0]" Then
					$Plant = 0xFF006F
					;$TimeGO = 17000
				ElseIf $answerPlant = "Огневик[0]" Then
					$Plant = 0x823481;  semena 04.15-----0x410409; poka eto yeti0x410409;ognevik
					;$TimeGO = 60000
				ElseIf $answerPlant = "Тысячелистник[30]" Then
					$Plant = 0x5C97D1;1000list
					;$TimeGO = 39000
				ElseIf $answerPlant = "Розмарин[30]" Then
					$Plant = 0x3A85CC;rozmarin
					;$TimeGO = 39000
				ElseIf $answerPlant = "Ирис[30]" Then
					$Plant = 0xE8BD00;iris
					;$TimeGO = 39000
				ElseIf $answerPlant = "Анемон[60]" Then
					$Plant = 0x37297D;anemon
					;$TimeGO = 56000
				ElseIf $answerPlant = "Лотос[60]" Then
					$Plant = 0x662B38;lotos
					;$TimeGO = 56000
				ElseIf $answerPlant = "Мандрагора[60]" Then
					$Plant = 0xEF1601;mandra
					;$TimeGO = 56000
				ElseIf $answerPlant = "Белладонна[90]" Then
					$Plant = 0x4AC407;bella
					;$TimeGO = 47000
				ElseIf $answerPlant = "Вкусноцвет[120]" Then
					$Plant = 0x07004C;vkusno 0x24086C  0x753EC6 0x5944B8
					;$TimeGO = 48000
				ElseIf $answerPlant = "Повей-трава[150]" Then
					$Plant = 0xE33789;povei
					;Изумруд[60] 0x15BAB4
					;Топаз[60] 0xFFFFD7
					;Рубин[60] 0xFF36C0
					;Красный камень[120] 0xB50700
					;Драконовая кровь[150] 0xE8A6BD
					;Аквамарин[0] 0x099585
					;Бирюза[0] 0x71FFFF
					;Агат[0] 0x0036CD
					;Обсидиан[30] 0x9CD482
					;Сапфир[30] 0x212B7E
					;Аметист[30] 0xBC2081
					;Алмаз[90] 0xC5C5C5
				ElseIf $answerPlant = "Агат[0]" Then
					$Plant = 0x0036CD
				ElseIf $answerPlant = "Бирюза[0]" Then
					$Plant = 0x71FFFF
				ElseIf $answerPlant = "Аквамарин[0]" Then
					$Plant = 0x099585
				ElseIf $answerPlant = "Обсидиан[30]" Then
					$Plant = 0x9CD482
				ElseIf $answerPlant = "Сапфир[30]" Then
					$Plant = 0x212B7E
				ElseIf $answerPlant = "Аметист[30]" Then
					$Plant = 0xBC2081
				ElseIf $answerPlant = "Рубин[60]" Then
					$Plant = 0xFF36C0
				ElseIf $answerPlant = "Топаз[60]" Then
					$Plant = 0xFFFFD7
				ElseIf $answerPlant = "Изумруд[60]" Then
					$Plant = 0x15BAB4
				ElseIf $answerPlant = "Алмаз[90]" Then
					$Plant = 0xC5C5C5
				ElseIf $answerPlant = "Огн сердолик[120]" Then
					$Plant = 0xB50700
				ElseIf $answerPlant = "Янтарь[120]" Then
					$Plant = 0xB50700
				ElseIf $answerPlant = "Едкий некр.[0]" Then
					$Plant = 0xF1ACE4
				ElseIf $answerPlant = "Огоньки[0]" Then
					$Plant = 0xD4FFF7
				ElseIf $answerPlant = "Капканы[0]" Then
					$Plant = 0x5A6A4D
				ElseIf $answerPlant = "Драк кровь [150]" Then
					$Plant = 0xE8A6BD
				ElseIf $answerPlant = "Яд. плющ[0]" Then
					$Plant = 0x774564
				EndIf

				If $Plant = 0 Then
					MsgBox(0, "Ошибка", "Вы не указали ресурс")
					Read()
				EndIf
				;запускаем счетчик времени узнаем что выбрал пользователь.
				$GatherCounter = 0

				$stringS = "Начало сбора: " & @HOUR & ":" & @MIN

				$temp = (GUICtrlRead($ruleTQ) = $GUI_CHECKED)
				If Not ($temp == $flagTimeQuant) Then IniWrite("settings.ini", "settings", "delay2", $temp)
				If $temp = True Then
					$limitTime = GUICtrlRead($inputTime) * 60
					If $limitTime <= 0 Then
						MsgBox(0, "Ошибка", "Указанное время меньше либо равно 0.")
						ContinueCase
					EndIf

					$limitGather = GUICtrlRead($inputQuantity)
					If $limitGather <= 0 Then
						MsgBox(0, "Ошибка", "Указанное кол-во ресурсов меньше либо равно 0.")
						ContinueCase
					EndIf
					IniWrite("settings.ini", "bar", "pick", GUICtrlRead($inputQuantity))
					IniWrite("settings.ini", "bar", "time", GUICtrlRead($inputTime))
					$flagTimeQuant = 1
				EndIf


				$temp = (GUICtrlRead($rulezaderjka) = $GUI_CHECKED)
				If Not ($temp == $flagRandomWait) Then IniWrite("settings.ini", "settings", "random2", $temp)
				If $temp = True Then
					$flagRandomWait = 1
				Else
					$flagRandomWait = 0
				EndIf

				;$temp = (GUICtrlRead($ruleRandomClick) = $GUI_CHECKED)
				;	If Not ($temp == $flagRandomClick) Then IniWrite("settings.ini", "settings", "random1", $temp)
				;	;If $temp = True Then
				;		$flagRandomClick = 1
				;	Else
				;		$flagRandomClick = 0
				;	EndIf

				$temp = (GUICtrlRead($agrG) = $GUI_CHECKED)
				If Not ($temp == $green) Then IniWrite("settings.ini", "settings", "green", $temp)
				If $temp = True Then
					$green = 1
				Else
					$green = 0
				EndIf

				$temp = (GUICtrlRead($agrO) = $GUI_CHECKED)
				If Not ($temp == $orange) Then IniWrite("settings.ini", "settings", "orange", $temp)
				If $temp == True Then
					$orange = 1
				Else
					$orange = 0
				EndIf

				$temp = (GUICtrlRead($attackMob) = $GUI_CHECKED)
				If $temp = True Then
					$flagAttackMob = 1;
				EndIf
				;$temp = (GUICtrlRead($dontshowTip) = $GUI_CHECKED)
				;If $temp = True Then
				;	$flagDontShow = 1;
				;EndIf
				$temp = (GUICtrlRead($agrR) = $GUI_CHECKED)
				If Not ($temp == $red) Then IniWrite("settings.ini", "settings", "red", $temp)
				If $temp = True Then
					$red = 1
				Else
					$red = 0
				EndIf

				$temp = (GUICtrlRead($agrY) = $GUI_CHECKED)
				If Not ($temp == $yellow) Then IniWrite("settings.ini", "settings", "yellow", $temp)
				If $temp = True Then
					$yellow = 1
				Else
					$yellow = 0
				EndIf




				;$temp = (GUICtrlRead($sickleGrey) = $GUI_CHECKED)
				;If Not ($temp == $flagGrey) Then IniWrite("settings.ini", "settings", "sickle", $temp);
				;If $temp = True Then
				;	$flagGrey = 1
				;Else
				;		$flagGrey = 0
				;	EndIf
				;
				$temp = (GUICtrlRead($usePotions) = $GUI_CHECKED)
				;If Not ($temp == $flagDrinkPotions) Then IniWrite("settings.ini", "settings", "potions", $temp)
				;If $temp = True Then
				;	$flagDrinkPotions = 1
				;Else
				;	$flagDrinkPotions = 0
				;EndIf

				;$message = GUICtrlRead($inputZanoza)
				$temp = (GUICtrlRead($randomDelay) = $GUI_CHECKED)
				If Not ($temp == $flagRandomDelay) Then IniWrite("settings.ini", "settings", "delay1", $temp)
				If $temp = True Then
					$flagRandomDelay = 1
					If (GUICtrlRead($input1) > GUICtrlRead($input2) Or GUICtrlRead($input1) <= 0 Or GUICtrlRead($input2) <= _
							0 Or GUICtrlRead($input3) <= 0 Or GUICtrlRead($input4) <= 0 Or GUICtrlRead($input3) > GUICtrlRead($input4)) Then
						MsgBox(0, "Ошибка", "Введены не правильно данные" & @CR & "В поле ввода случайной задержки")
						Read()
					EndIf
					IniWrite("settings.ini", "bar", "min1", GUICtrlRead($input1))
					IniWrite("settings.ini", "bar", "min2", GUICtrlRead($input2))
					IniWrite("settings.ini", "bar", "max1", GUICtrlRead($input3))
					IniWrite("settings.ini", "bar", "max2", GUICtrlRead($input4))

					$MacroDelay = (Random(GUICtrlRead($input3), GUICtrlRead($input4), 1)) / 60 * 1000
					$MicroDelay = Random(GUICtrlRead($input1), GUICtrlRead($input2), 1) / 60 * 1000
					;ConsoleWrite(@CR & "Macro -> " & $MacroDelay & @CR & "Micro -> " & $MicroDelay)
				Else
					$flagRandomDelay = 0
				EndIf

				WinSetState($ProgramName, '', @SW_MINIMIZE)
				goStart()
			Case $StopButton
				TogglePause()

			Case $Combo
				$WhatIsResourse = _GUICtrlComboBox_GetCurSel($Combo)
				If $WhatIsResourse = 1 Then
					_GUICtrlListView_DeleteAllItems($hListView)
					_GUICtrlListView_DeleteColumn($hListView, 0)
					$answerPlant = 0
					_GUICtrlListView_AddColumn($hListView, "Камни", 130)
					_GUICtrlListView_AddItem($hListView, "Агат[0]", 1)
					_GUICtrlListView_AddItem($hListView, "Бирюза[0]", 1)
					_GUICtrlListView_AddItem($hListView, "Аквамарин[0]", 1)
					_GUICtrlListView_AddItem($hListView, "Сапфир[30]", 1)
					_GUICtrlListView_AddItem($hListView, "Аметист[30]", 1)
					_GUICtrlListView_AddItem($hListView, "Обсидиан[30]", 1)
					_GUICtrlListView_AddItem($hListView, "Рубин[60]", 1)
					_GUICtrlListView_AddItem($hListView, "Топаз[60]", 1)
					_GUICtrlListView_AddItem($hListView, "Изумруд[60]", 1)
					_GUICtrlListView_AddItem($hListView, "Алмаз[90]", 1)
					_GUICtrlListView_AddItem($hListView, "Огн сердолик[120]", 1)
					_GUICtrlListView_AddItem($hListView, "Янтарь[120]", 1)
					_GUICtrlListView_AddItem($hListView, "Драк кровь [150]", 1)

				ElseIf $WhatIsResourse = 0 Then
					_GUICtrlListView_DeleteAllItems($hListView)
					_GUICtrlListView_DeleteColumn($hListView, 0)
					$answerPlant = 0
					_GUICtrlListView_AddColumn($hListView, "Растения", 130)
					_GUICtrlListView_AddItem($hListView, "Сугроб[0]", 1)
					_GUICtrlListView_AddItem($hListView, "Омела[0]", 9)
					_GUICtrlListView_AddItem($hListView, "Чертополох[0]", 3)
					_GUICtrlListView_AddItem($hListView, "Клевер[0]", 13)
					_GUICtrlListView_AddItem($hListView, "Огневик[0]", 10)
					_GUICtrlListView_AddItem($hListView, "Тысячелистник[30]", 5)
					_GUICtrlListView_AddItem($hListView, "Розмарин[30]", 6)
					_GUICtrlListView_AddItem($hListView, "Ирис[30]", 14)
					_GUICtrlListView_AddItem($hListView, "Анемон[60]", 4)
					_GUICtrlListView_AddItem($hListView, "Лотос[60]", 12)
					_GUICtrlListView_AddItem($hListView, "Мандрагора[60]", 11)
					_GUICtrlListView_AddItem($hListView, "Белладонна[90]", 15)
					_GUICtrlListView_AddItem($hListView, "Вкусноцвет[120]", 7)
					_GUICtrlListView_AddItem($hListView, "Жар-цвет[120]", 1)
					_GUICtrlListView_AddItem($hListView, "Повей-трава[150]", 8)
				Else
					_GUICtrlListView_DeleteAllItems($hListView)
					_GUICtrlListView_DeleteColumn($hListView, 0)
					$answerPlant = 0
					_GUICtrlListView_AddColumn($hListView, "Особые ресурсы", 130)
					_GUICtrlListView_AddItem($hListView, "Едкий некр.[0]", 1);0xF1ACE4
					_GUICtrlListView_AddItem($hListView, "Огоньки[0]", 1);0xD4FFF7
					_GUICtrlListView_AddItem($hListView, "Капканы[0]", 9);0x5A6A4D
					_GUICtrlListView_AddItem($hListView, "Яд. плющ[0]", 9);0x774564

				EndIf
			Case $adHouse
				AHgui($hwnd)
			Case $superHits
				;MsgBox(0,"В разработке","В ближайшем будущем")
				super($hwnd)

				;Case $ruleZanoza
				;$temp = (GUICtrlRead($ruleZanoza) = $GUI_CHECKED)
				;If Not ($temp == $flagzanoza) Then IniWrite("settings.ini", "settings", "splinter", $temp)
				;If $temp = True Then
				;GUICtrlSetState($labelZanoza, $GUI_SHOW)
				;GUICtrlSetState($inputZanoza, $GUI_SHOW)
				;GUICtrlSetState($sickleGrey, $GUI_SHOW)
				;GUICtrlSetState($sickleGreen, $GUI_SHOW)
				;GUICtrlSetState($sickleZone, $GUI_SHOW)
				;$flagzanoza = 1 ;
				;Else
				;GUICtrlSetState($labelZanoza, $GUI_HIDE)
				;GUICtrlSetState($inputZanoza, $GUI_HIDE)
				;GUICtrlSetState($sickleGrey, $GUI_HIDE)
				;GUICtrlSetState($sickleGreen, $GUI_HIDE)
				;GUICtrlSetState($sickleZone, $GUI_HIDE)
				;$flagzanoza = 0;
				;EndIf
		EndSwitch
	WEnd
EndFunc   ;==>Read


Func AHgui($hParent = 0, $param = 0)
	Local $hSettings, $iGOEM_Opt
	;Предотвращение проблем в случае если главный GUI использует режим событий
	$iGOEM_Opt = Opt("GUIOnEventMode", 0)
	If $param = 0 Then
		$hSettings_GUI = GUICreate('Настройка', 200, 200, -1, -1, -1, -1, $hParent)
		GUISetFont(9, 700)
		$var = GUICtrlCreateLabel("Для корректной работы бота необходимо проверить запас банок, корма и находиться в локации с портретами в доме.", 10, 57, 180, 70)
		GUISetFont(9, 300)
		$buttonNext = GUICtrlCreateButton("Далее", 70, 150, 60, 30)
	EndIf

	If $param = 1 Then
		$hSettings_GUI = GUICreate('Настройка', 200, 200, -1, -1, -1, -1, $hParent)
		GUISetFont(9, 700)
		$var = GUICtrlCreateLabel("Выберите боссов которых необходимо убить", 10, 17, 180, 30)
		GUISetFont(9, 300)

		$firstmob = GUICtrlCreateCheckbox("Фантом мертвеца", 10, 47)
		$revr = GUICtrlCreateCheckbox("Реврат", 10, 67)
		$galm = GUICtrlCreateCheckbox("Галмахар", 10, 87)
		$zerm = GUICtrlCreateCheckbox("Зермерх", 10, 107)
		$ling = GUICtrlCreateCheckbox("Линграонц", 10, 127)
		$buttonNext = GUICtrlCreateButton("Далее", 70, 150, 60, 30)
	EndIf


	GUISetState(@SW_SHOW, $hSettings_GUI)
	GUISetState(@SW_DISABLE, $hParent)
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				Opt("GUIOnEventMode", $iGOEM_Opt)
				GUISetState(@SW_ENABLE, $hParent)
				GUIDelete($hSettings_GUI)
				ExitLoop
			Case $buttonNext
				If $param = 0 Then
					$param += 1
					Opt("GUIOnEventMode", $iGOEM_Opt)
					GUISetState(@SW_ENABLE, $hParent)
					GUIDelete($hSettings_GUI)
					AHgui($hParent, $param)
					ExitLoop
				EndIf
				If $param = 1 Then
					$param += 1
					If (GUICtrlRead($firstmob) = $GUI_CHECKED) = True Then
						$whatRouteWillBe &= "1"
					Else
						$whatRouteWillBe &= "0"
					EndIf

					If (GUICtrlRead($revr) = $GUI_CHECKED) = True Then
						$whatRouteWillBe &= "1"
					Else
						$whatRouteWillBe &= "0"
					EndIf

					If (GUICtrlRead($galm) = $GUI_CHECKED) = True Then
						$whatRouteWillBe &= "1"
					Else
						$whatRouteWillBe &= "0"
					EndIf

					If (GUICtrlRead($zerm) = $GUI_CHECKED) = True Then
						$whatRouteWillBe &= "1"
					Else
						$whatRouteWillBe &= "0"
					EndIf

					If (GUICtrlRead($ling) = $GUI_CHECKED) = True Then
						$whatRouteWillBe &= "1"
					Else
						$whatRouteWillBe &= "0"
					EndIf

					Opt("GUIOnEventMode", $iGOEM_Opt)
					GUISetState(@SW_ENABLE, $hParent)
					GUIDelete($hSettings_GUI)
					super($hParent,1)
					ExitLoop
				EndIf
		EndSwitch
	WEnd


EndFunc   ;==>AHgui

Func super($hParent = 0,$house = 0)
	Local $hSettings, $iGOEM_Opt
	;Предотвращение проблем в случае если главный GUI использует режим событий
	$iGOEM_Opt = Opt("GUIOnEventMode", 0)
	$hSettings_GUI = GUICreate('Настройка', 200, 200, -1, -1, -1, -1, $hParent)

	GUICtrlCreateLabel("Атака в голову ", 10, 37)
	GUICtrlCreateLabel("Атака в корпус", 10, 67)
	GUICtrlCreateLabel("Атака в ноги", 10, 97)

	GUICtrlCreateLabel("Настройте комбинацию супер-ударов в бою. Для продолжения нажмите ОК", 5, 5, 195, 25)
	;GUICtrlSetColor(-1, 0x848482)
	$buttonTOP = GUICtrlCreateButton("", 90, 30, 30, 30, $BS_ICON)
	$buttonMID = GUICtrlCreateButton("", 90, 60, 30, 30, $BS_ICON)
	$buttonBOT = GUICtrlCreateButton("", 90, 90, 30, 30, $BS_ICON)
	$buttonOK = GUICtrlCreateButton("OK", 130, 30, 60, 40)
	$buttonCancel = GUICtrlCreateButton("Отмена", 130, 80, 60, 40)
	$check1 = GUICtrlCreateCheckbox("В конце серии исп. слот №", 5,150)
	$ComboPower = GUICtrlCreateCombo("1", 165, 150, 30, 15, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, "2|3|4|5|6")
	$check2 = GUICtrlCreateCheckbox("В  начале боя  исп. слот №", 5,170)
	$ComboPots = GUICtrlCreateCombo("1", 165, 170, 30, 15, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, "2|3|4|5|6")
	_GUICtrlButton_SetImage($buttonTOP, @ScriptDir & "\im.dll", 17)
	_GUICtrlButton_SetImage($buttonMID, @ScriptDir & "\im.dll", 19)
	_GUICtrlButton_SetImage($buttonBOT, @ScriptDir & "\im.dll", 18)
	GUICtrlCreateLabel("Созданная комбинация:", 30, 120, 200, 20)
	GUISetFont(12, 700)
	$hit = GUICtrlCreateLabel(" ", 60, 135, 90, 20)
	GUISetState(@SW_SHOW, $hSettings_GUI)
	GUISetState(@SW_DISABLE, $hParent)
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $buttonTOP
				createComb("Г")
			Case $buttonMID
				createComb("К")
			Case $buttonBOT
				createComb("Н")
			Case $buttonOK
				If (GUICtrlRead($check1) = $GUI_CHECKED) = True Then $usePowerPotion =  _GUICtrlComboBox_GetCurSel($ComboPower) +1
				If (GUICtrlRead($check2) = $GUI_CHECKED) = True Then $useAtStartPotion =  _GUICtrlComboBox_GetCurSel($ComboPots) +1
				ConsoleWrite($usePowerPotion & " " & $useAtStartPotion)
				$flagUseCustomHits = 1
				$combArray = StringSplit($combination, '', 2)
				$eC = UBound($combArray) - 1
				ExitLoop
			Case $buttonCancel
				createComb(-1)
		EndSwitch
	WEnd
	Opt("GUIOnEventMode", $iGOEM_Opt)
	GUISetState(@SW_ENABLE, $hParent)
	GUIDelete($hSettings_GUI)
EndFunc   ;==>super

Func createComb($choose)
	If $choose = -1 Then
		If StringLen($combination) < 2 Then Return
		$combination = StringTrimRight($combination, 1)
		GUICtrlSetData($hit, $combination)
		Return
	EndIf
	If StringLen($combination) > 7 Then
		MsgBox(0, "Ошибка", "Слишком длинная комбинация")
		Return
	EndIf
	$combination = GUICtrlRead($hit)
	$combination &= $choose
	GUICtrlSetData($hit, $combination)

	;	ConsoleWrite("Зашли в функцию ")
	;	If $counter = 6 Then
	;
	;		Return
	;	EndI
EndFunc   ;==>createComb


