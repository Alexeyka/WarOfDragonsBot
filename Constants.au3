Global Const $Version = "2.0 Alpha";������ ����
Global Const $ProgramName = "��"
Global $Plant = 0; ��� ������ - ����������
Global $flagDontShow = 0; �� ���������� ���������
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
Global $hWnd; ���������� ����
;Global $TimeGO = 17000;�����
Global $tempStr ="";
Global $WindowSize; ������ ����
Global $RightBottom[2];������ ������ ����� �����
Global $RememberTheXY[2];��� �������� ��� ��������� ��� ���
Global $LeftTop[2]; ����� ������� ����� �����
Global $Time = 17000; ����� ��������,������� �� ����� �����
Global $click = 0;���������� �����
Global $size = 43; ������� ��������
Global $zanoza = 0; ������� ����� ���������� ���� ������ ��� ���
Global $step = 200;��� ��������
Global $Paused = False; payza
Global $tip = False;

Global $GatherCounter = 0; ������� ������� ��������
Global $ZanozaLimit = 4; ������ ����� ����� �������� ��������� ����� ����������
Global $flagBottomScroll = 1; ���� �� ��������� ������ ��� ���  - ����
Global $flagRandomClick = 0; ��������� ���� - ����
Global $timeHour = 0; ��������� ���� - ����
Global $timeMin = 0; ��������� ���� - ����
;Global $flagversion = 1; ������� ������ ������� ��� ���.0 - �������, 1 ��������
;------------��� ������ � ������ ����������
Global $howManyTimesToScroll=0
Global $timeForScroll = 0
Global $timeForUp = 0
;---------------����������� ���
Global $whatRouteWillBe = ""
Global $usePowerPotion = 0
Global $useAtStartPotion = 0

;---------------
Global $flagRandomWait = 0; ���� �������� ��� ��������� ��������, 0 - ���, 1 - ����
;Global $flagRuleChat = 0; hide chat
;Global $flagIsSomeone = 1;$IsSomeone on resourse or no
Global $flagF7 = 0; ���� ��� ����,0 - ��� ����, - 1 - ����.
Global $flagattack = 0 ;���� ����� ����, ����� - 1
Global $hListView ;���� ����� ����, ����� - 1
Global $flagsplinter = 0;���� ������, ������ - 1
;Global $flagcheckMob = 0;���� ��������� �� ���� ��� ���
Global $flagclickonce = 0;���� ��� ����� 1 ��� �� ������� �����
Global $flagTimeQuant = 0;�������������� ������� �� ������� ��� �� ����� ��������
Global $flagRead = 1;���� ��� ������ ��� �� ������ ���������
Global $limitTime;������ �� ���� �� �������
Global $ruleZanoza = 0;
Global $WhatIsResourse;
;Global $message = ""; ��� ��� ������
Global $isChatOpen = 0;���
;Global $flagzanoza = 1;
Global $limitGather; � ���-��
Global $chatredpixel = 0;
Global $timeStart; - ����� ������ ������ ���������,
Global $TitleName; " �������"
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