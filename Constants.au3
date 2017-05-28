Global Const $Version = "2.0 Alpha";Версия бота
Global Const $ProgramName = "АС"
Global $Plant = 0; Тип цветка - переменная
Global $flagDontShow = 0; не показывать подсказку
Global $bear;
Global $bearOnce = 0
Global $adHouse = 0
Global $onceRight = 0
Global $flagAttackMob = 1;-----------------------------------------------vot
Global $ok = 0
Global $lastscroll = 0
Global $centerX;
GLobal $centerY;
GLobal 	 $timeDif = 0
Global $hWnd; дескриптор окна
;Global $TimeGO = 17000;время
Global $tempStr ="";
Global $WindowSize; размер окна
Global $RightBottom[2];правая нижняя точка охоты
Global $RememberTheXY[2];для проверки моб двигается или нет
Global $LeftTop[2]; левая верхняя точка охоты
Global $Time = 17000; Время ожидания,зависит от цвета травы
Global $click = 0;координата клика
Global $size = 43; Квадрат проверки
Global $zanoza = 0; Счетчик чтобы определить есть заноза или нет
Global $step = 200;шаг проверки
Global $Paused = False; payza
Global $tip = False;

Global $GatherCounter = 0; сколько собрано ресурсов
Global $ZanozaLimit = 4; предел заноз после которого программа будет прекращена
Global $flagBottomScroll = 1; есть ли скроллинг нижний или нет  - флаг
Global $flagRandomClick = 0; случайный клик - флаг
Global $timeHour = 0; случайный клик - флаг
Global $timeMin = 0; случайный клик - флаг
;Global $flagversion = 1; русская версия клиента или нет.0 - русская, 1 польская
;------------для работы с картой переменные
Global $howManyTimesToScroll=0
Global $timeForScroll = 0
Global $timeForUp = 0
;---------------Заброшенный дом
Global $whatRouteWillBe = ""
Global $usePowerPotion = 0
Global $useAtStartPotion = 0

;---------------
Global $flagRandomWait = 0; флаг ожидания для случайной задержки, 0 - нет, 1 - есть
;Global $flagRuleChat = 0; hide chat
;Global $flagIsSomeone = 1;$IsSomeone on resourse or no
Global $flagF7 = 0; флаг для чата,0 - нет чата, - 1 - есть.
Global $flagattack = 0 ;флаг атаки моба, напал - 1
Global $hListView ;флаг атаки моба, напал - 1
Global $flagsplinter = 0;флаг занозы, заноза - 1
;Global $flagcheckMob = 0;флаг проверять на моба или нет
Global $flagclickonce = 0;флаг для клика 1 раз на область охоты
Global $flagTimeQuant = 0;Дополнительное условие по времени или по колву ресурсов
Global $flagRead = 1;флаг что сейчас еще не работа программа
Global $limitTime;предел на сбор во времени
Global $ruleZanoza = 0;
Global $WhatIsResourse;
;Global $message = ""; это для занозы
Global $isChatOpen = 0;чат
;Global $flagzanoza = 1;
Global $limitGather; в кол-ве
Global $chatredpixel = 0;
Global $timeStart; - время начала работы программы,
Global $TitleName; " Легенда"
Global $answerPlant
Global $mainArray[1]
Global $flagGrey = 1;
Global $randomDelay = 0;
Global $flagRandomDelay = 0;
Global $flagCombination = False;
Global $MacroDelay = 0
Global $MicroDelay = 0;
Global $splinterOnce = 0
;fightwithmob
Global $makeItOnce = 0;
Global $fightField[4];
Global $potionsField[4];
Global $flagDrinkPotions = 1;
Global $flagUseCustomHits = 0;

;zanoza
Global $justfortype =0;
Global $greenSickle = 0xFCFCF1;
Global  $greySickle = 0x5C4735; 0xF9F7F5
Global $green = 0
Global $attackMob = 0
Global $yellow = 0
Global $red = 0
Global $orange = 0
Global $textArray = 0;
Global $sC = 1;
Global $eC = 0;
Global $combArray;




;GUI
Global $advice = 0;
Global $combination
Global $input1 = 0;
Global $input2 = 0;
Global $input3 = 0;
Global $input4 = 0;
;Global $checkMoreThenOnce = 0
Global $inputQuantity = 0
Global $plradio = 0
Global $ruradio = 0
Global $hListView = 0
Global $PlayButton = 0
Global $ruleTQ = 0
Global $inputTime = 0
Global $rulezaderjka = 0
Global $StopButton = 0
Global $ruleRandomClick = 0
Global $inputZanoza = 0
Global $Combo = 0
;Global $noradio = 0
Global $agr = 0
Global $hit = 0
Global $agrG = 0
Global $agrO = 0
Global $agrR = 0
Global $agrY = 0
Global $hit0  =0;
Global $hit1  =0;
Global $hit2  =0;
Global $hit3  =0;
Global $dontshowTip  =0;
Global $hit4  =0;
Global $helpList = 0
Global $helpEdit = 0
;Global $yesradio = 0
Global $labelZanoza = 0
Global $StatButton = 0
Global $sickleGrey = 0;
Global $sickleGreen = 0
Global $sickleZone = 0 ;
Global $nSttngs_Button = 0;
Global $usePotions = 0
Global $superHits = 0;
Global $counter = 0;