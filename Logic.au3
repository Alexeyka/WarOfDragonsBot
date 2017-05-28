;моя жизнь должна быть насыщенной.
#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=C:\favicon.ico
#AutoIt3Wrapper_UseUpx=n
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****
FileInstall("C:\im.dll", @ScriptDir & "\im.dll")
FileInstall("C:\FastFind.au3", @ScriptDir & "\FastFind.au3")
FileInstall("C:\FastFind.dll", @ScriptDir & "\FastFind.dll")
FileInstall("C:\FastFind64.dll", @ScriptDir & "\FastFind64.dll")
FileInstall("C:\settings.ini", @ScriptDir & "\settings.ini")
FileInstall("C:\info.dat", @ScriptDir & "\info.dat")
;teaasda@mail.ru
;battlenet14A

#include "Constants.au3"
#include "GUI.au3"
#include "FastFind.au3"
#include "FF.au3"
If _Singleton("test", 1) = 0 Then
	MsgBox(0, "Предупреждение", "Одна версия бота уже запущена", 5)
	Exit
EndIf
; c 11.12.13	 пишу прогу
;----установка горячих клавиш
HotKeySet("{F1}", "Terminate")
;HotKeySet("{F2}", "Read")
HotKeySet("{F2}", "TogglePause")
HotKeySet("{F3}", "ShowTip")
;-----------------------------
createGUI()
Read()
;
;DllCall("user32.dll", "int", "SendMessage", "hwnd", $handle, "uint", $WM_ACTIVATE, "int", 1, "int", 0) ;  делаем вид что активируем окно с игрой
;DllCall("user32.dll", "int", "SendMessage", "hwnd", $handle, "uint", $WM_SETFOCUS, "int", 1, "int", 0) ;  делаем вид что передаем окну фокус для пользовательского ввода

Func ShowTip()
	$tip = Not $tip
	If $tip Then
		$flagDontShow = 0
		UpdateTip()
	Else
		$flagDontShow = 1
		ToolTip("")
	EndIf
EndFunc   ;==>ShowTip
;+запуск работы программы
Func goStart()
	$flagRead = 0;
	If $ok = 0 Then
		Prepare()
		$timeStart = TimerInit()
		$ok += 1
	Else
		UpdateTip()
	EndIf
	Local $x = Random($LeftTop[0], $RightBottom[0], 1) - 4;
	Local $y = Random($LeftTop[1], $RightBottom[1], 1) - 57;
	ControlClick($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "left", 1, $x, $y)
	;StartLoop()
	;	$click = FFNearestPixel($centerX, $centerY, $Plant, True, $LeftTop[0], $LeftTop[1], $RightBottom[0], $RightBottom[1], 0, $hWnd)
	;FFSaveBMP("hi",false);
	;Sleep(200)
	;Terminate()
	EndlessFarm()
EndFunc   ;==>goStart

Func EndlessFarm()
		While 1
		StartLoop()
		WEnd
EndFunc

;+функция отвечающая за файт с мобом.
Func FightWithMob($fightTOP)
	ConsoleWrite("entered fight with mob")
	$sC = 1
	Local $victoryMessage = 0x80C200;0x8EAB00;0x88CE00;0x9EEF00
	;	Local $greyPotion = 0xEE3030;
	;	Local $greenPotion = 0xEF3131;
	;	Local $bluePotion = 0x950003;
	;;	Local $violetPotion = 0x940003;
	;	Local $redPotion = 0xF2292B;
	Local $defeatMessage = 0xF99047;
	Local $33 = 0x3E0003;
	Local $number = 2
	Local $blueIconInFight = 0x1B426C;синий круг в бою типа удар блок и т.д
	;массив банок жизни
	;	Local $potions[5]
	;	$potions[0] = $greyPotion
	;	$potions[1] = $greenPotion
	;;	$potions[2] = $bluePotion
	;$potions[3] = $violetPotion
	;	$potions[4] = $redPotion
	;$rightField = Int($WindowSize[0] / 2);
	;$bottomField = Int($WindowSize[1] / 2)
	;устанавливаем рамки охоты.
	$fightField[0] = $fightTOP[0] + 7;left
	$fightField[1] = $fightTOP[1];top
	$fightField[2] = $fightTOP[0] + 420;right
	$fightField[3] = $fightTOP[1] + 285;bottom
	$potionsField[0] = 0;left
	$potionsField[1] = $fightField[1];top
	$potionsField[2] = 55;right
	$potionsField[3] = $fightField[1] + 262;bottom
	;ждем пока прогрузится удар по мобу.
	$checksum = 0
	While $checksum = 0
		$checksum = FFNearestPixel($fightField[0], $fightField[1], $blueIconInFight, True, $fightField[0], $fightField[1], $fightField[2], $fightField[3], 0, $hwnd)
	WEnd
	;кликаем 1 раз для того чтобы работали кнопки
	Sleep(Random(100, 200, 1))
	ControlClick($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "left", 1, Random($fightField[0], $fightField[0] + 220, 1) - 4, Random($fightField[1] + 100, $fightField[1] + 120, 1) - 57)
	Sleep(Random(100, 200, 1))

	;основная функция. - подождали пока появится удар, проверили нужно ли пить зелье, ударили - в цикле.
	$once = 0
	While 1
		$blue = 0
		While $blue = 0
			Sleep(500)
			$blue = FFNearestPixel($fightField[0], $fightField[1], $blueIconInFight, True, $fightField[0], $fightField[1], $fightField[2], $fightField[3], 0, $hwnd)
			$mobIsDead = FFNearestPixel($fightField[0], $fightField[1], 0x80C200, True, $fightField[0], $fightField[1], $fightField[2], $fightField[3], 1, $hwnd)
			$charIsdead = FFNearestPixel($fightField[0], $fightField[1], $defeatMessage, True, $fightField[0], $fightField[1], $fightField[2], $fightField[3], 1, $hwnd)
			If $mobIsDead <> 0 Then
				$getout = FFNearestPixel($fightField[2], $fightField[3], 0xA60000, True, $fightField[0], $fightField[1], $fightField[2], $fightField[3], 1, $hwnd)
				If $getout = 0 Then Return
				$getout[0] = $getout[0] - Random(50, 30) - 4
				$getout[1] = $getout[1] - Random(-2, 2) - 57
				ControlClick($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "left", 1, $getout[0], $getout[1])
				Sleep(Random(500, 1500))
				ControlClick($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "left", 1, $bear[0] - 4 + Random(-10, 10, 1), $bear[1] - 57 + Random(-10, 10, 1))
				Sleep(Random(500, 1000))
				ControlClick($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "left", 1, Random($LeftTop[0], $RightBottom[0], 1) - 4, Random($LeftTop[1], $RightBottom[1], 1) - 57)
				EndlessFarm()
			EndIf
			If $charIsdead <> 0 Then
				MsgBox(0, "Поражение", "Моб не убит." & @CR & "Завершаем работу")
				Terminate()
			EndIf
		WEnd

		if $once =0 And $useAtStartPotion <> 0 Then
			$once +=1
			ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{" & $useAtStartPotion & "}")
		EndIf

		$lessthen33 = FFNearestPixel($fightField[0], $fightField[1], $33, True, $fightField[0], $fightField[1], $fightField[0] + 78, $fightField[1] + 55, 0, $hwnd)
		If $lessthen33 <> 0 Then
			ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{" & $number & "}")
			$number += 1
			Sleep(Random(3000, 4000))
		EndIf
		If $flagUseCustomHits = 0 Then
			Sleep(Random(300, 500, 1))
			ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{RIGHT}")
		Else
			$attackIs = 0
			While $attackIs = 0
				$attackIs = FFNearestPixel($fightField[0], $fightField[1], 0x960000, True, $fightField[0], $fightField[1], $fightField[2], $fightField[3], 0, $hwnd)
				Sleep(100)
			WEnd
			If $sC > $eC Then $sC = 1
			If $sC = $eC and $usePowerPotion <> 0 Then
				ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "" & $usePowerPotion & "")
			EndIf
			If $combArray[$sC] = "К" Then
				Sleep(Random(200, 300, 1))
				ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{RIGHT}")
			ElseIf $combArray[$sC] = "Г" Then
				Sleep(Random(200, 300, 1))
				ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{UP}")
			ElseIf $combArray[$sC] = "Н" Then
				Sleep(Random(200, 300, 1))
				ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{DOWN}")
			EndIf
			$sC += 1
		EndIf
	WEnd
EndFunc   ;==>FightWithMob

;+обновление подсказки вверху - збс.
Func UpdateTip()
	If $flagDontShow = 1 Then Return
	$counter = $GatherCounter * 60000
	$result = Round($counter / $timeDif, 2)
	If $timeDif = 0 Then $result = 0
	ToolTip("Начало сбора: " & $timeHour & ":" & $timeMin _
			 & " Сейчас: " & @HOUR & ":" & @MIN & @CRLF & _
			" F1 - выход F2 - пауза F3 - подсказка" & @CR & "В среднем  " & $result & " ресурсов в минуту." & @CR & "Собрано " & $GatherCounter & " " & $answerPlant, 0, 0, "", 1, 1)

EndFunc   ;==>UpdateTip


;+подготовка работы  бота;изменено под анвизибл.
Func Prepare()
	Local $BScroll = 0x950100
	Local $LScroll = 0xD0805D
	Local $LScroll1 = 0xFDF9D4
	Local $Object = 0x710071
	Local $var = WinList()
	Local $isGame = 0
	$timeHour = @HOUR
	$timeMin = @MIN
	If $bearOnce = 0 Then
		FFSetDebugMode(0)
		$LeftTop[0] = 75
		$LeftTop[1] = 212
		Opt("SendKeyDelay", 50)
		Opt("TrayMenuMode", 1);чтобы окно в трее не появлялось
		AutoItSetOption("MouseCoordMode", 2);установка относитньынх координат

		For $i = 1 To $var[0][0]
			If $var[$i][0] = " Legenda" Or $var[$i][0] = " Легенда" Or $var[$i][0] = " Legend" Then
				$chatredpixel = 0xB50005;0xB40000
				$TitleName = $var[$i][0]
				$isGame = 1
				ExitLoop
			EndIf
		Next
		If $isGame = 0 Then
			MsgBox(0, "Сообщение", "Клиент игры не запущен." & @CR & "Бот работает с клиентом " & @CR & "русским или польским. " & @CR & "Завершаем работу бота.")
			Terminate();----------тут надо выход не из игры а обратно в окошко старта
		EndIf
		If WinGetState($TitleName) = 37 Then
			MsgBox(0, "Сообщение", " Для работы бота необходимо," & @CR & "чтобы окно с игрой было развернуто " _
					 & @CR & "(но не обязательно активным)" & @CR & "Завершаем работу бота.")
			Terminate();----------тут надо выход не из игры а обратно в окошко старта
		EndIf

		$hWnd = WinGetHandle($TitleName)
		FFSetWnd($hWnd)
		$WindowSize = WinGetClientSize($TitleName)
		$isChatOpen = FFNearestPixel(0, $WindowSize[1], $chatredpixel, True, 0, $WindowSize[1] - 70, 85, $WindowSize[1])
		If $isChatOpen <> 0 Then
			$flagF7 = 1
			ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{F7}")
		EndIf
		If $flagRandomDelay = 1 Then
			Delay()
		EndIf
		;цвета иконки охоты
		FFAddColor(0x723D28)
		FFAddColor(0x4C2319)
		FFAddColor(0x7B453A)
		FFAddColor(0x79422E)
		FFAddColor(0x270B0A)
		FFAddColor(0x8C452B)
		FFAddColor(0x86402C)
		FFAddColor(0x784233)
		FFAddColor(0x7C382A)
		FFAddColor(0x7B462F)
		FFAddColor(0x683627)
		FFAddColor(0x6E3C28)
		FFAddColor(0x612B1D)
		FFAddColor(0x693826)
		FFAddColor(0x2C0C0A)
		FFAddColor(0x360A0D)
		$bear = FFNearestPixel(350, 50, -1, True, 350, 50, $WindowSize[0], $WindowSize[1] * 0.2, 0, $hWnd)
		If $bear <> 0 Then
			ControlClick($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "left", 1, $bear[0] - 4 + Random(-10, 10, 1), $bear[1] - 57 + Random(-10, 10, 1))
		Else
			MsgBox(0, 'Сообщение', 'Иконка медведя не найдена, прерываем работу программы.')
			FFResetColors()
			Terminate()
		EndIf
		$bearOnce += 1
	Else
		ControlClick($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "left", 1, $bear[0] - 4 + Random(-10, 10, 1), $bear[1] - 57 + Random(-10, 10, 1))
	EndIf
	Local $checksum = 0
	Local $checksum1 = 0
	$error = 0
	While $checksum = 0 And $checksum1 = 0
		If ($error > 20) Then
			MsgBox(0, "Ошибка 01", "Критическая ошибка")
			Terminate();
		EndIf
		Sleep(500);
		$checksum = FFNearestPixel($LeftTop[0] + 200, $LeftTop[1] - 50, $Object, True, $LeftTop[0] + 200, $LeftTop[1] - 50, $LeftTop[0] + 750, $LeftTop[1] - 5, 0, $hWnd)
		$checksum1 = FFNearestPixel($LeftTop[0] + 200, $LeftTop[1] - 50, 0xA6E43E, False, $LeftTop[0] + 200, $LeftTop[1] - 50, $LeftTop[0] + 750, $LeftTop[1] - 5, 0, $hWnd)
		$error += 1
	WEnd
	If $onceRight = 0 Then
		$RightBottom = FFNearestPixel($WindowSize[0] - 150, $WindowSize[1] - $WindowSize[1] / 2, 0x980001, True, $WindowSize[0] - 150, _
				$WindowSize[1] - $WindowSize[1] / 2, $WindowSize[0], $WindowSize[1], 0, $hWnd)
		If $RightBottom = 0 Then
			MsgBox(0, "Ошибка 02", "Критическая ошибка")
			Terminate();
		EndIf
		ControlClick($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "left", 1, Random($LeftTop[0], $RightBottom[0], 1) - 4, Random($LeftTop[1], $RightBottom[1], 1) - 57)
		ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{UP Down}")
		$error = 0
		While 1
			If ($error > 20) Then
				MsgBox(0, "Ошибка 03", "Критическая ошибка")
				Terminate();
			EndIf
			$error += 1
			$s = FFNearestPixel($RightBottom[0] - 8, 237, 0xFFFBD5, True, $RightBottom[0] - 8, 237, $RightBottom[0] + 8, $RightBottom[1] - 10, 0, $hWnd)
			If $s = 0 Then
				Sleep(100)
				ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{UP Up}")
				ExitLoop
			EndIf
			Sleep(300)
		WEnd
		$drag = Random(100, 200, 1)
		ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{DOWN Down}")
		Sleep($drag)
		ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{DOWN Up}")
		Sleep(50)
		$topScroll = FFNearestPixel($RightBottom[0] - 8, 237, $LScroll1, True, $RightBottom[0] - 8, 237, $RightBottom[0] + 8, $RightBottom[1] - 10, 0, $hWnd)
		If $topScroll = 0 Then
			MsgBox(0, "Ошибка 04", "Критическая ошибка")
			Terminate();
		EndIf
		$Topborder = FFNearestPixel($RightBottom[0] - 8, 220, 0x503325, True, $RightBottom[0] - 8, 220, $RightBottom[0] + 8, $RightBottom[1] - 10, 0, $hWnd)
		If $Topborder = 0 Then
			MsgBox(0, "Ошибка 05", "Критическая ошибка")
			Terminate();
		EndIf
		$howmuchDidIDrag = $topScroll[1] - $Topborder[1]
		$botomScroll = FFNearestPixel($RightBottom[0]+8, $RightBottom[1]-10, 0xFFE2A8, True, $RightBottom[0] - 8, 255, $RightBottom[0] + 8, $RightBottom[1] - 10, 0, $hWnd)
		If $botomScroll = 0 Then
			MsgBox(0, "Ошибка 06", "Критическая ошибка")
			Terminate();
		EndIf
		$scrollSize = $botomScroll[1] - $topScroll[1]
		$BottomBorder = $RightBottom[1] - 8
		$totalLength = $BottomBorder - $Topborder[1]
		$koef = $scrollSize / $howmuchDidIDrag
		$timeForScroll = $drag * $koef
		$howManyTimesToScroll = Ceiling(($totalLength - $scrollSize) / $scrollSize)
		;ConsoleWrite("$howManyTimesToScroll - >" & $howManyTimesToScroll & @CRLF)
		;if $scrollSize * ($howManyTimesToScroll+1) > $totalLength Then
		;	if $howManyTimesToScroll = 1 Then $howManyTimesToScroll = 2
		;$lastscrollSize = $totalLength - $scrollSize * ($howManyTimesToScroll -1)
		;$k =$timeForScroll/$scrollSize
		;$lastscroll = $lastscrollSize * $k
		;$timeForUp = $howManyTimesToScroll  * $timeForScroll + $lastscroll
		;ConsoleWrite("$scrollSize - >" & $scrollSize & @CRLF)
		;ConsoleWrite("$scroll - >" & $timeForScroll & @CRLF)
		;ConsoleWrite("$lastscrollSize - >" & $lastscrollSize & @CRLF)
		;ConsoleWrite("$lastscroll - >" & $lastscroll & @CRLF)
		;Else
			$lastscroll = $timeForScroll
			$timeForUp = $howManyTimesToScroll * $timeForScroll
		;EndIf


		$centerX = ($LeftTop[0] + $RightBottom[0]) / 2
		$centerY = ($LeftTop[1] + $RightBottom[1]) / 2
		$BottomScroll = FFNearestPixel($RightBottom[0] - 25, $RightBottom[1], $BScroll, True, $RightBottom[0] - 25, $RightBottom[1], $RightBottom[0] - 10, $RightBottom[1] + 20, 0, $hWnd)
		If $BottomScroll = 0 Then
			$flagBottomScroll = 0; нет нижнего скролла
		Else
			ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{LEFT Down}")
			Sleep(Random(300, 500, 1))
			ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{LEFT Up}")
		EndIf
		AddShadowMobColors()
		ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{UP Down}")
		Sleep($drag + Random(50, 70))
		ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{UP Up}")
		Sleep(50)
		$RightBottom[0] -= 10 ;устанавливаем границы
		$RightBottom[1] += 5
		$timeStart = TimerInit()
		$onceRight += 1
		$pixelLeftTop = 0x655D46
		$attackMob = FFNearestPixel($LeftTop[0], $LeftTop[1] - 70, $pixelLeftTop, True, $LeftTop[0], $LeftTop[1] - 70, $LeftTop[0] + 850, $LeftTop[1] - 5, 1, $hWnd)
	Else
		ControlClick($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "left", 1, Random($LeftTop[0], $RightBottom[0], 1) - 4, Random($LeftTop[1], $RightBottom[1], 1) - 57)
		AddShadowMobColors()
		ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{UP Down}")
		$error = 0
		While 1
			If ($error > 50) Then
				MsgBox(0, "Ошибка 07", "Критическая ошибка")
				Terminate();
			EndIf
			$error += 1
			$s = FFNearestPixel($RightBottom[0] - 8, 237, 0xFFFBD5, True, $RightBottom[0] - 8, 237, $RightBottom[0] + 8, $RightBottom[1] - 10, 0, $hWnd)
			If $s = 0 Then
				ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{UP Up}")
				Sleep(100)
				ExitLoop
			EndIf
			Sleep(300)
		WEnd
	EndIf
	UpdateTip()
	ConsoleWrite("Prepare end" & @CR)
EndFunc   ;==>Prepare



;+выбор действия если цветок найден
Func ChooseAction($left,$top,$right,$bottom)
	ConsoleWrite("Вошли в ChooseAction " & @CR)
	$click = FFNearestPixel($centerX, $centerY, $Plant, True, $LeftTop[0] + $left , $LeftTop[1] + $top, $RightBottom[0] + $right, $RightBottom[1] + $bottom, 3, $hWnd)
	If $click = 0 Then
		ConsoleWrite("Вышли  ChooseAction $click = 0   " & @CR)
	Return;
	EndIf
	While 1
		Sleep(100)
		$click = FFNearestPixel($centerX, $centerY, $Plant, False, $LeftTop[0], $LeftTop[1] + 30, $RightBottom[0], $RightBottom[1] - 30, 3, $hWnd)
		If $click = 0 Then ExitLoop
		FFSetPixel($click[0], $click[1], 0xFFFFFF, 3)
		;собирает ли кто то траву
		$someoneOnFlower = FFNearestPixel($click[0], $click[1], 0x900000, True, $click[0] - 40, $click[1] - 40, $click[0], $click[1], 1, $hWnd)
		If $someoneOnFlower <> 0 Then ContinueLoop;
		;ConsoleWrite("На цветке никого нет,проверяем если ли моб рядом" & @CR)
		AddMobColors()
		$IsMobNear = CheckMobNear($click)
		If $IsMobNear = 1 Then
			$click[0] = $click[0] + Random(-3, 3, 1) ;указываем рандомность клика
			$click[1] = $click[1] + Random(-3, 3, 1) ;4-57 dlya controlclick
			;ConsoleWrite("Мобов нет, нажимаем на цветок" & @CR)
			FindMob($click)
		EndIf
	WEnd
	ConsoleWrite("Вышли из ChooseAction" & @CR)
EndFunc   ;==>ChooseAction


;Return -> 0 - добыча удалась, 1 - не удалась.
Func ActionFailed()
	$check = FFNearestPixel($LeftTop[0], $RightBottom[1], 0x955C4A, True, $LeftTop[0], $LeftTop[1], $RightBottom[0], $RightBottom[1], 0, $hWnd)
	If $check <> 0 Then
		$checkX = $check[0] + Random(-30, 30, 1) - 4;
		$checkY = $check[1] + Random(-7, 7, 1) - 57;
		ControlClick($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "left", 1, $checkX, $checkY)
		Sleep(Random(300, 400, 1))
		ControlClick($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "left", 1, $checkX, $checkY)
		Sleep(Random(50, 100, 1))
		$zanoza += 1;
		If ($ZanozaLimit <= $zanoza) Then
			;If $flagzanoza = True Then
			;	playSound()
			;	SplinterOff()
			;Else
			playSound()
			MsgBox(0, "Заноза", "Обнаружена заноза" & @CR & "Удалите ее и нажмите ОК")
			$zanoza = 0
			Return;
		EndIf
		Return 0
	Else
		Return 1
	EndIf

EndFunc   ;==>ActionFailed

;+поиск цветка;.под вопросом ActionFailed.может быть лишних пока не решил.
Func StartLoop()
	ConsoleWrite("Startloop start:" & $howManyTimesToScroll &"<-" & @CR)
	Local $leftright = 1;переменная для сдигва нижнего скроллинга
	For $i = 1 To $howManyTimesToScroll
		;двигать ползунок влево-право(для маленького разрешения) если он есть
		If $flagBottomScroll = 1 Then
			If $leftright = 1 Then
				if $i = 1 Then
				ChooseAction(0,0,-25,-40)
				Else
				ChooseAction(0,15,-25,-40)
				EndIf
				ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{RIGHT Down}")
				Sleep(Random(600, 850, 1))
				ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{RIGHT Up}")
				$leftright = 0
				if $i = 1 Then
				ChooseAction(25,0,0,-40)
				Else
				ChooseAction(25,15,0,-40)
				EndIf
			Else
				ChooseAction(25,15,0,-40)
				ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{LEFT Down}")
				Sleep(Random(600, 850, 1))
				ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{LEFT Up}")
				$leftright = 1
				ChooseAction(0,15,-25,-40)
			EndIf
		Else
			if $i = 1 Then
				ChooseAction(0,0,0,-40)
				Else
				ChooseAction(0,15,0,-40)
				EndIf
		EndIf
		ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{DOWN Down}")
		Sleep($timeForScroll + Random(-99, 50));
		ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{DOWN Up}")
		;Delay()
		Sleep(Random(150, 300, 1))
		;ConsoleWrite($i & @Cr)
	Next
	;$lastscroll
	If $flagBottomScroll = 1 Then
		ChooseAction(25,15,0,-40)
		ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{LEFT Down}")
		Sleep(Random(600, 800, 1))
		ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{LEFT Up}")
		ChooseAction(0,15,-25,0)
	EndIf
	;$skillcheck = FFNearestPixel($LeftTop[0], $LeftTop[1] + 40, 0xB07A42, True, $LeftTop[0], $LeftTop[1] + 40, $RightBottom[0], $RightBottom[1] - 60, 0, $hWnd)
	;If $skillcheck <> 0 Then
	;	playSound()
	;	MsgBox(0, "", "Пройдите проверку мастерства" & @CR & "и нажмите ОК")
	;EndIf
	$attackMob = FFNearestPixel($LeftTop[0], $LeftTop[1] - 70, 0x655D46, True, $LeftTop[0], $LeftTop[1] - 70, $LeftTop[0] + 850, $LeftTop[1] - 5, 1, $hWnd)
	If $attackMob <> 0 Then
		;playSound()
		FightWithMob($attackMob)
	EndIf
	ActionFailed()
	ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{Up Down}")
	Sleep($timeForUp + Random(100, 200));
	ControlSend($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "{Up Up}")
	;Sleep(Random(100, 200, 1))
	;ControlClick($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "left", 1, Random($LeftTop[0], $RightBottom[0], 1) - 4, Random($LeftTop[1], $RightBottom[1], 1) - 57)
	ConsoleWrite("Startloop end" & @CR)
EndFunc   ;==>StartLoop

;+поиск моба - оптимизирован, улушен;Return -> 0 - моб рядом, 1 - моба нет.
Func CheckMobNear($click)
		$IsMobNear = FFNearestPixel($click[0], $click[1], -1, True, $click[0] - $size, $click[1] - $size, $click[0] + $size, $click[1] + 90, 0, $hWnd)
	If $IsMobNear <> 0 Then
		Sleep(250)
		$IsMobNear1 = FFNearestPixel($click[0], $click[1], -1, True, $click[0] - $size, $click[1] - $size, $click[0] + $size, $click[1] + 2 * $size, 0, $hWnd)
		If $IsMobNear1 <> 0 Then
			If $IsMobNear[0] < $click[0] And $IsMobNear[1] < $click[1]  Then
				if $IsMobNear[0] < $IsMobNear1[0] And $IsMobNear[1] < $IsMobNear1[1]  Then Return 0
				Return 1
			ElseIf $IsMobNear[0] > $click[0] And $IsMobNear[1] < $click[1] Then
				if $IsMobNear[0] > $IsMobNear1[0] And $IsMobNear[1] < $IsMobNear1[1]  Then Return 0
				Return 1
			ElseIf $IsMobNear[0] < $click[0] And $IsMobNear[1] > $click[1] Then
				if $IsMobNear[0] < $IsMobNear1[0] And $IsMobNear[1] > $IsMobNear1[1]  Then Return 0
				Return 1
			ElseIf $IsMobNear[0] > $click[0] And $IsMobNear[1] > $click[1] Then
				if $IsMobNear[0] > $IsMobNear1[0] And $IsMobNear[1] > $IsMobNear1[1]  Then Return 0
				Return 1
			EndIf
			;If $IsMobNear1[0] = $IsMobNear[0] And $IsMobNear1[1] = $IsMobNear[1] Then Return 1
			Return 0
		Else
			Return 0
		EndIf
	Else
		Return 1
	EndIf
EndFunc   ;==>CheckMobNear

;----av==
Func FindMob($click)
	ConsoleWrite("Зашли в файнд моб" & @CR)
	Local $x = $click[0] - 4
	Local $y = $click[1] - 57
	ControlClick($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "left", 1, $x, $y)
	;это типа проверка на то что это реально цветок.
	If $flagAttackMob = 0 Then
		Sleep(Random(400,600))
		;иконка газер.
		$checksum = FFNearestPixel($LeftTop[0] + 150, $LeftTop[1] - 25, 0xA6E43E, True, $LeftTop[0], $LeftTop[1] - 50, $LeftTop[0] + 850, $LeftTop[1] - 5, 1, $hWnd)
		If $checksum = 0 Then
			ConsoleWrite("$Нажали 1 раз на цветок проверили есть ли газер. Его нет.Выходим.")
			Return
		EndIf
	EndIf

	;тут мы 2 раза нажимаем и садимся на цветок
	If $flagRandomWait = 1 Then Sleep(Random(500, 2000, 1))
	ControlClick($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "left", 2, $x, $y)
	;спими проверяем не напал ли на нас моб
	ConsoleWrite("Заходим в вечный цикл свеженький" & @CR)
	$error = 0
	While 1
		if $error > 50 Then
			ConsoleWrite("Ошибка, уходим в бесконечный фарм")
			EndlessFarm()
		EndIf
		$error+=1
		Sleep(Random(200, 300))
		$attackMob = FFNearestPixel($LeftTop[0], $LeftTop[1] - 70, 0x655D46, True, $LeftTop[0], $LeftTop[1] - 60, $LeftTop[0] + 850, $LeftTop[1] - 5, 1, $hWnd)
		$actionfailed = FFNearestPixel($LeftTop[0], $RightBottom[1], 0x955C4A, True, $LeftTop[0], $LeftTop[1], $RightBottom[0], $RightBottom[1], 1, $hWnd)
		$gathering1 = FFNearestPixel($LeftTop[0], $LeftTop[1] + 40, 0xBB3232, True, $LeftTop[0], $LeftTop[1] + 40, $RightBottom[0], $RightBottom[1] - 60, 0, $hWnd)
		$skillcheck = FFNearestPixel($LeftTop[0], $LeftTop[1] + 40, 0xB07A42, True, $LeftTop[0], $LeftTop[1] + 40, $RightBottom[0], $RightBottom[1] - 60, 0, $hWnd)
		If $gathering1 <> 0 Then
			ConsoleWrite("Erondondonon")
			ExitLoop
		EndIf
		If $skillcheck <> 0 Then
			playSound()
			MsgBox(0, "", "Пройдите проверку мастерства" & @CR & "и нажмите ОК")
			Return
		EndIf
		If $actionfailed <> 0 Then
			ActionFailed()
			Return;
		EndIf
		If $attackMob <> 0 Then FightWithMob($attackMob)
	WEnd
	Local $youAreFirst = FFNearestPixel($centerX, $centerY, 0x148B0B, True, $LeftTop[0], $LeftTop[1] + 40, $RightBottom[0], $RightBottom[1] - 60, 0, $hWnd)
	If $youAreFirst = 0 Then ;GETOUТ тут все понятно
		$getout = FFNearestPixel(($LeftTop[0] + $RightBottom[0]) / 2, $RightBottom[1] - 60, 0x980000, True, $LeftTop[0], $LeftTop[1] + 40, _
				$RightBottom[0], $RightBottom[1] - 60, 0, $hWnd)
		If $getout <> 0 Then
			$getout[0] += Random(-10, 10)
			$getout[0] -= 4;
			$getout[1] -= 57;
			ControlClick($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "left", 1, $getout[0], $getout[1])
			Return;
		EndIf
	EndIf
	$gathering = 1
	AddShadowMobColors()
	;тут уже пошла проверка на мобов,смотрим есть ли живность какая рядом.
	ConsoleWrite("Входим в цикл $gathering. Тут мы ждем пока не словится." & @CR)
	While $gathering <> 0
		$gathering = FFNearestPixel($LeftTop[0], $LeftTop[1] + 40, 0xBB3232, True, $LeftTop[0], $LeftTop[1] + 40, $RightBottom[0], $RightBottom[1] - 60, 0, $hWnd)
		If $gathering <> 0 Then
			If $gathering[0] <> $gathering1[0] Or $gathering[1] <> $gathering1[1] Then
				;Если первое значение  окна не совпадает со вторым то мы проверям напал ли моб.
				$attackMob = FFNearestPixel($LeftTop[0], $LeftTop[1] - 70, 0x655D46, True, $LeftTop[0], $LeftTop[1] - 70, $LeftTop[0] + 850, $LeftTop[1] - 5, 1, $hWnd)
				If $attackMob <> 0 Then
					;playSound()
					FightWithMob($attackMob)
				EndIf
				ConsoleWrite("Значение ху не совпадает с hello считаем что ловля удалась и он нашел другую точку,просто выходим из цикла." & @CR)
				ExitLoop
			EndIf
			$IsMobNear = CheckMobNear($click)
			If $IsMobNear = 0 Then
				$getout = FFNearestPixel(($LeftTop[0] + $RightBottom[0]) / 2, $RightBottom[1] - 60, 0x980000, True, $LeftTop[0], $LeftTop[1] + 40, $RightBottom[0], $RightBottom[1] - 60, 0, $hWnd)
				If $getout <> 0 Then
					ConsoleWrite("Нажимаем отмену из-за того что моб рядом.");
					$getout[0] += Random(-10, 10)
					$getout[0] -= 4;
					$getout[1] -= 57;
					ControlClick($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "left", 1, $getout[0], $getout[1])
					Sleep(100)
					ControlClick($TitleName, "", "[CLASS:WebViewHost; INSTANCE:1]", "left", 1, $getout[0], $getout[1])
					Return;
				EndIf
			EndIf
		EndIf
	WEnd
	ConsoleWrite("Вышли из цикла $gathering" & @CR)
	Sleep(Random(100, 200))
	;затем проверяем заноза есть?
	$answer = ActionFailed()
	If $answer = 1 Then
		$zanoza = 0
		$GatherCounter += 1
		$timeDif = TimerDiff($timeStart);
		UpdateTip()
		If $flagTimeQuant = 1 Then checkTimeLimit()
	EndIf
	Sleep(Random(1500, 2000))
	$attackMob = FFNearestPixel($LeftTop[0], $LeftTop[1] - 70, 0x655D46, True, $LeftTop[0], $LeftTop[1] - 70, $LeftTop[0] + 850, $LeftTop[1] - 5, 1, $hWnd)
	If $attackMob <> 0 Then
		;playSound()
		ConsoleWrite("Значит мы словили моба в газере & @CR")
		FightWithMob($attackMob)
	EndIf
	ConsoleWrite("---------------------------------------------------" & @CR)
EndFunc   ;==>FindMob
; +проигрывание звука
Func playSound()
	Local $aSound = _SoundOpen(@WindowsDir & "\media\Windows Balloon.wav")
	If @error = 2 Then
		MsgBox(0, "Ошибка", "Файл не существует.")
		Terminate()
	ElseIf @extended <> 0 Then
		Local $iExtended = @extended
		Local $tText = DllStructCreate("char[128]")
		DllCall("winmm.dll", "short", "mciGetErrorStringA", "str", $iExtended, "ptr", DllStructGetPtr($tText), "int", 128)
		MsgBox(0, "Ошибка", "Открытие файла не удалось." & @CRLF & "Код ошибки: " & _
				$iExtended & @CRLF & "Описание: " & DllStructGetData($tText, 1) & _
				@CRLF & "Учтите, звук может все равно воспроизводиться.")
	Else
		$MsgAnswer = 0
		While $MsgAnswer < 3
			_SoundPlay($aSound, 1)
			$MsgAnswer += 1
		WEnd
		_SoundClose($aSound)
	EndIf
EndFunc   ;==>playSound

;+пауза - вроде норм.






