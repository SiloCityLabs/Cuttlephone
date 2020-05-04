EESchema Schematic File Version 4
LIBS:avr-gamepad-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:R R1
U 1 1 5CDE5E2E
P 2000 6700
F 0 "R1" V 1793 6700 50  0000 C CNN
F 1 "22" V 1884 6700 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 1930 6700 50  0001 C CNN
F 3 "~" H 2000 6700 50  0001 C CNN
	1    2000 6700
	0    1    1    0   
$EndComp
Wire Wire Line
	1600 6700 1750 6700
$Comp
L power:+5V #PWR0106
U 1 1 5CDF3C55
P 1750 5950
F 0 "#PWR0106" H 1750 5800 50  0001 C CNN
F 1 "+5V" H 1765 6123 50  0000 C CNN
F 2 "" H 1750 5950 50  0001 C CNN
F 3 "" H 1750 5950 50  0001 C CNN
	1    1750 5950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0107
U 1 1 5CE2CBD3
P 3550 6750
F 0 "#PWR0107" H 3550 6600 50  0001 C CNN
F 1 "VCC" H 3567 6923 50  0000 C CNN
F 2 "" H 3550 6750 50  0001 C CNN
F 3 "" H 3550 6750 50  0001 C CNN
	1    3550 6750
	1    0    0    -1  
$EndComp
Text Notes 2900 6500 0    50   ~ 0
Power Decoupling
$Comp
L power:+5V #PWR0108
U 1 1 5CE0A7FF
P 2900 6750
F 0 "#PWR0108" H 2900 6600 50  0001 C CNN
F 1 "+5V" H 2915 6923 50  0000 C CNN
F 2 "" H 2900 6750 50  0001 C CNN
F 3 "" H 2900 6750 50  0001 C CNN
	1    2900 6750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0109
U 1 1 5CE0A1B4
P 2900 7100
F 0 "#PWR0109" H 2900 6850 50  0001 C CNN
F 1 "GND" H 2905 6927 50  0000 C CNN
F 2 "" H 2900 7100 50  0001 C CNN
F 3 "" H 2900 7100 50  0001 C CNN
	1    2900 7100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 5CE336BE
P 2900 6950
F 0 "C1" H 3015 6996 50  0000 L CNN
F 1 "0.1uF" H 3015 6905 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 2900 6950 50  0001 C CNN
F 3 "~" H 2900 6950 50  0001 C CNN
	1    2900 6950
	1    0    0    -1  
$EndComp
Connection ~ 2900 7100
$Comp
L Device:C C2
U 1 1 5CE34260
P 3550 6950
F 0 "C2" H 3665 6996 50  0000 L CNN
F 1 "1uF" H 3665 6905 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 3550 6950 50  0001 C CNN
F 3 "~" H 3550 6950 50  0001 C CNN
	1    3550 6950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0117
U 1 1 5CF294FD
P 7400 4500
F 0 "#PWR0117" H 7400 4250 50  0001 C CNN
F 1 "GND" H 7405 4327 50  0000 C CNN
F 2 "" H 7400 4500 50  0001 C CNN
F 3 "" H 7400 4500 50  0001 C CNN
	1    7400 4500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
U 1 1 5CE68646
P 1850 7650
F 0 "#PWR01" H 1850 7400 50  0001 C CNN
F 1 "GND" H 1855 7477 50  0000 C CNN
F 2 "" H 1850 7650 50  0001 C CNN
F 3 "" H 1850 7650 50  0001 C CNN
	1    1850 7650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1600 6300 1650 6300
Wire Wire Line
	1600 6200 1750 6200
$Comp
L Device:R R4
U 1 1 5CE8517A
P 1950 7100
F 0 "R4" H 2020 7146 50  0000 L CNN
F 1 "5.1k" H 2020 7055 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 1880 7100 50  0001 C CNN
F 3 "~" H 1950 7100 50  0001 C CNN
	1    1950 7100
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 5CE91027
P 1650 7100
F 0 "R3" H 1720 7146 50  0000 L CNN
F 1 "5.1k" H 1720 7055 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 1580 7100 50  0001 C CNN
F 3 "~" H 1650 7100 50  0001 C CNN
	1    1650 7100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1750 6850 1950 6850
Wire Wire Line
	1650 6300 1650 6950
Wire Wire Line
	1950 6850 1950 6950
Wire Wire Line
	1650 7250 1650 7350
Wire Wire Line
	1950 7350 1950 7250
Wire Wire Line
	1000 7500 1000 7650
Wire Wire Line
	700  7500 700  7650
Wire Wire Line
	700  7650 1000 7650
$Comp
L Device:R R6
U 1 1 5CF1BD3F
P 10550 4200
F 0 "R6" V 10343 4200 50  0000 C CNN
F 1 "1K" V 10434 4200 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 10480 4200 50  0001 C CNN
F 3 "~" H 10550 4200 50  0001 C CNN
	1    10550 4200
	0    1    1    0   
$EndComp
$Comp
L Device:LED D2
U 1 1 5CF1A9A2
P 10550 4400
F 0 "D2" H 10543 4616 50  0000 C CNN
F 1 "LED" H 10543 4525 50  0000 C CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 10550 4400 50  0001 C CNN
F 3 "~" H 10550 4400 50  0001 C CNN
	1    10550 4400
	-1   0    0    1   
$EndComp
Wire Wire Line
	2900 7100 3550 7100
Wire Wire Line
	2900 6800 3550 6800
Text Label 5600 2650 0    50   ~ 0
JoyRightY
$Comp
L power:GND #PWR0115
U 1 1 5E1C2864
P 6200 2850
F 0 "#PWR0115" H 6200 2600 50  0001 C CNN
F 1 "GND" H 6205 2677 50  0000 C CNN
F 2 "" H 6200 2850 50  0001 C CNN
F 3 "" H 6200 2850 50  0001 C CNN
	1    6200 2850
	1    0    0    1   
$EndComp
$Comp
L power:VCC #PWR0116
U 1 1 5E1D50BD
P 6000 2550
F 0 "#PWR0116" H 6000 2400 50  0001 C CNN
F 1 "VCC" H 6017 2723 50  0000 C CNN
F 2 "" H 6000 2550 50  0001 C CNN
F 3 "" H 6000 2550 50  0001 C CNN
	1    6000 2550
	1    0    0    1   
$EndComp
$Comp
L Connector_Generic:Conn_01x05 J3
U 1 1 5DA62D9E
P 5400 2750
F 0 "J3" H 5292 3235 50  0000 C CNN
F 1 "Conn_01x05" H 5292 3144 50  0000 C CNN
F 2 "molex_5051100592:5051100592" H 5400 2750 50  0001 C CNN
F 3 "~" H 5400 2750 50  0001 C CNN
	1    5400 2750
	-1   0    0    -1  
$EndComp
Connection ~ 1750 6700
Wire Wire Line
	1750 6700 1750 6850
Connection ~ 750  1550
Wire Wire Line
	750  1700 750  1550
Wire Wire Line
	750  1550 600  1550
Wire Wire Line
	750  1400 750  1550
$Comp
L power:GND #PWR0105
U 1 1 5CE2A20B
P 600 1600
F 0 "#PWR0105" H 600 1350 50  0001 C CNN
F 1 "GND" H 605 1427 50  0000 C CNN
F 2 "" H 600 1600 50  0001 C CNN
F 3 "" H 600 1600 50  0001 C CNN
	1    600  1600
	1    0    0    -1  
$EndComp
Text Label 3050 4150 0    50   ~ 0
JoyRightY
Text Label 3050 4050 0    50   ~ 0
JoyRightX
Wire Wire Line
	1200 1400 1850 1400
Wire Wire Line
	1200 1950 1200 1700
Wire Wire Line
	1500 1950 1200 1950
Wire Wire Line
	1500 1700 1500 1950
Wire Wire Line
	1850 1700 1500 1700
Wire Wire Line
	1400 1700 1400 1550
$Comp
L power:GND #PWR0114
U 1 1 5D9DC9EB
P 1400 1700
F 0 "#PWR0114" H 1400 1450 50  0001 C CNN
F 1 "GND" H 1405 1527 50  0000 C CNN
F 2 "" H 1400 1700 50  0001 C CNN
F 3 "" H 1400 1700 50  0001 C CNN
	1    1400 1700
	1    0    0    -1  
$EndComp
$Comp
L Device:Crystal_GND24 Y1
U 1 1 5D9AE8A9
P 1200 1550
F 0 "Y1" V 1154 1794 50  0000 L CNN
F 1 "Crystal_GND24" V 1245 1794 50  0000 L CNN
F 2 "Crystal:Crystal_SMD_SeikoEpson_FA238-4Pin_3.2x2.5mm" H 1200 1550 50  0001 C CNN
F 3 "~" H 1200 1550 50  0001 C CNN
	1    1200 1550
	0    1    1    0   
$EndComp
Wire Wire Line
	1050 950  1350 950 
$Comp
L power:GND #PWR02
U 1 1 5D8FA225
P 1050 950
F 0 "#PWR02" H 1050 700 50  0001 C CNN
F 1 "GND" H 1055 777 50  0000 C CNN
F 2 "" H 1050 950 50  0001 C CNN
F 3 "" H 1050 950 50  0001 C CNN
	1    1050 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 950  1750 950 
Wire Wire Line
	1800 1250 1800 950 
$Comp
L Switch:SW_Push SW1
U 1 1 5D8F3544
P 1550 950
F 0 "SW1" H 1550 1235 50  0000 C CNN
F 1 "RESET" H 1550 1144 50  0000 C CNN
F 2 "button-contacts:Small" H 1550 1150 50  0001 C CNN
F 3 "~" H 1550 1150 50  0001 C CNN
	1    1550 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 3400 1250 3450
Wire Wire Line
	1650 3400 1650 3450
Connection ~ 2550 800 
Wire Wire Line
	2550 950  2550 800 
Wire Wire Line
	1800 1250 1850 1250
$Comp
L Device:C C5
U 1 1 5CE3DF92
P 1250 3250
F 0 "C5" H 1365 3296 50  0000 L CNN
F 1 "0.1uF" H 1365 3205 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 1250 3250 50  0001 C CNN
F 3 "~" H 1250 3250 50  0001 C CNN
	1    1250 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 2800 1250 2800
Wire Wire Line
	1250 2800 1250 3100
$Comp
L power:GND #PWR0112
U 1 1 5CE3F8CD
P 1250 3450
F 0 "#PWR0112" H 1250 3200 50  0001 C CNN
F 1 "GND" H 1255 3277 50  0000 C CNN
F 2 "" H 1250 3450 50  0001 C CNN
F 3 "" H 1250 3450 50  0001 C CNN
	1    1250 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 1850 1600 2800
Wire Wire Line
	1850 1850 1600 1850
$Comp
L Device:C C6
U 1 1 5CE37ACD
P 1650 3250
F 0 "C6" H 1765 3296 50  0000 L CNN
F 1 "1uF" H 1765 3205 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 1650 3250 50  0001 C CNN
F 3 "~" H 1650 3250 50  0001 C CNN
	1    1650 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 2550 1850 2550
Wire Wire Line
	1800 3100 1800 2550
$Comp
L power:GND #PWR0111
U 1 1 5CE3BD00
P 1650 3450
F 0 "#PWR0111" H 1650 3200 50  0001 C CNN
F 1 "GND" H 1655 3277 50  0000 C CNN
F 2 "" H 1650 3450 50  0001 C CNN
F 3 "" H 1650 3450 50  0001 C CNN
	1    1650 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 3100 1650 3100
$Comp
L Device:C C4
U 1 1 5CE373C9
P 900 1700
F 0 "C4" V 1150 1700 50  0000 C CNN
F 1 "22pF" V 1050 1700 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 900 1700 50  0001 C CNN
F 3 "~" H 900 1700 50  0001 C CNN
	1    900  1700
	0    1    1    0   
$EndComp
$Comp
L Device:C C3
U 1 1 5CE36ECF
P 900 1400
F 0 "C3" V 648 1400 50  0000 C CNN
F 1 "22pF" V 739 1400 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 900 1400 50  0001 C CNN
F 3 "~" H 900 1400 50  0001 C CNN
	1    900  1400
	0    1    1    0   
$EndComp
Wire Wire Line
	2450 800  2550 800 
Wire Wire Line
	2450 950  2450 800 
$Comp
L power:VCC #PWR0110
U 1 1 5CE323B8
P 2550 800
F 0 "#PWR0110" H 2550 650 50  0001 C CNN
F 1 "VCC" H 2567 973 50  0000 C CNN
F 2 "" H 2550 800 50  0001 C CNN
F 3 "" H 2550 800 50  0001 C CNN
	1    2550 800 
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 1450 1850 1400
Wire Wire Line
	1850 1650 1850 1700
Wire Wire Line
	2350 800  2350 950 
$Comp
L power:+5V #PWR0104
U 1 1 5CDF79E3
P 2350 800
F 0 "#PWR0104" H 2350 650 50  0001 C CNN
F 1 "+5V" H 2365 973 50  0000 C CNN
F 2 "" H 2350 800 50  0001 C CNN
F 3 "" H 2350 800 50  0001 C CNN
	1    2350 800 
	1    0    0    -1  
$EndComp
Connection ~ 2450 4850
Wire Wire Line
	2350 4850 2450 4850
Wire Wire Line
	2350 4550 2350 4850
Wire Wire Line
	2450 4850 2450 4550
$Comp
L power:GND #PWR0103
U 1 1 5CDF715B
P 2450 4850
F 0 "#PWR0103" H 2450 4600 50  0001 C CNN
F 1 "GND" H 2455 4677 50  0000 C CNN
F 2 "" H 2450 4850 50  0001 C CNN
F 3 "" H 2450 4850 50  0001 C CNN
	1    2450 4850
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0101
U 1 1 5CDF4CB6
P 1300 2100
F 0 "#PWR0101" H 1300 1950 50  0001 C CNN
F 1 "+5V" H 1315 2273 50  0000 C CNN
F 2 "" H 1300 2100 50  0001 C CNN
F 3 "" H 1300 2100 50  0001 C CNN
	1    1300 2100
	-1   0    0    1   
$EndComp
Wire Wire Line
	1750 6200 1750 6700
$Comp
L Device:R R2
U 1 1 5CDE68D4
P 2000 6400
F 0 "R2" V 1793 6400 50  0000 C CNN
F 1 "22" V 1884 6400 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 1930 6400 50  0001 C CNN
F 3 "~" H 2000 6400 50  0001 C CNN
	1    2000 6400
	0    1    1    0   
$EndComp
Wire Wire Line
	1850 6700 1750 6700
Wire Wire Line
	1850 6400 1850 6500
Wire Wire Line
	1850 6500 1600 6500
Text Label 2250 6400 0    50   ~ 0
D-
Text Label 2250 6700 0    50   ~ 0
D+
Text Label 1700 2350 0    50   ~ 0
D-
Text Label 1700 2250 0    50   ~ 0
D+
Wire Wire Line
	1850 2250 1700 2250
Wire Wire Line
	1850 2350 1700 2350
Wire Wire Line
	2250 6400 2150 6400
Wire Wire Line
	2250 6700 2150 6700
Wire Wire Line
	1200 1400 1050 1400
Connection ~ 1200 1400
Wire Wire Line
	1050 1700 1200 1700
Connection ~ 1200 1700
Wire Wire Line
	1750 5950 1750 6000
Wire Wire Line
	1750 6000 1600 6000
Connection ~ 1000 7650
Text Label 10000 3500 0    50   ~ 0
RowL1
Text Label 10000 3600 0    50   ~ 0
RowL2
Text Label 10000 3700 0    50   ~ 0
RowL3
Text Label 10000 3800 0    50   ~ 0
ColL1
Text Label 10000 3900 0    50   ~ 0
ColL2
Text Label 10000 4000 0    50   ~ 0
ColL3
$Comp
L Connector_Generic:Conn_01x06 J1
U 1 1 5CF089CD
P 8750 2550
F 0 "J1" H 8830 2542 50  0000 L CNN
F 1 "Conn_01x06" H 8830 2451 50  0000 L CNN
F 2 "Connector_FFC-FPC:Hirose_FH12-6S-0.5SH_1x06-1MP_P0.50mm_Horizontal" H 8750 2550 50  0001 C CNN
F 3 "~" H 8750 2550 50  0001 C CNN
	1    8750 2550
	-1   0    0    -1  
$EndComp
Wire Wire Line
	10750 4200 10700 4200
Wire Wire Line
	5600 2850 6200 2850
Wire Wire Line
	5600 2550 6000 2550
Text Label 10000 4100 0    50   ~ 0
L3
$Comp
L Connector_Generic:Conn_01x05 J4
U 1 1 5F28DB4F
P 10700 2800
F 0 "J4" H 10592 3285 50  0000 C CNN
F 1 "Conn_01x05" H 10592 3194 50  0000 C CNN
F 2 "molex_5051100592:5051100592" H 10700 2800 50  0001 C CNN
F 3 "~" H 10700 2800 50  0001 C CNN
	1    10700 2800
	1    0    0    -1  
$EndComp
Text Label 10400 4400 2    50   ~ 0
GND_L
Text Label 10500 2900 2    50   ~ 0
GND_L
Text Label 5600 2950 0    50   ~ 0
JoyRightX
$Comp
L avr-gamepad-rescue:ATmega32U4-AU-MCU_Microchip_ATmega U1
U 1 1 5CDCD708
P 2450 2750
F 0 "U1" H 2450 861 50  0000 C CNN
F 1 "ATmega32U4-AU" H 2450 770 50  0000 C CNN
F 2 "Package_QFP:TQFP-44_10x10mm_P0.8mm" H 2450 2750 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-7766-8-bit-AVR-ATmega16U4-32U4_Datasheet.pdf" H 2450 2750 50  0001 C CNN
	1    2450 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	750  1550 1000 1550
Wire Wire Line
	1850 2050 1300 2050
Wire Wire Line
	3550 6800 3550 6750
Connection ~ 3550 6800
Wire Wire Line
	2900 6800 2900 6750
Connection ~ 2900 6800
Wire Wire Line
	1300 2050 1300 2100
$Comp
L Connector:USB_C_Plug_USB2.0 P1
U 1 1 5CDE15F9
P 1000 6600
F 0 "P1" H 1107 7467 50  0000 C CNN
F 1 "USB_C_Plug_USB2.0" H 1107 7376 50  0000 C CNN
F 2 "Connector_USB:USB_C_Plug_Molex_105444" H 1150 6600 50  0001 C CNN
F 3 "https://www.usb.org/sites/default/files/documents/usb_type-c.zip" H 1150 6600 50  0001 C CNN
	1    1000 6600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1650 7350 1800 7350
Wire Wire Line
	1800 7650 1800 7350
Wire Wire Line
	1000 7650 1800 7650
Connection ~ 1800 7350
Wire Wire Line
	1800 7350 1950 7350
Wire Wire Line
	1800 7650 1850 7650
Connection ~ 1800 7650
NoConn ~ 3050 1250
NoConn ~ 3050 1350
NoConn ~ 3050 1450
NoConn ~ 3050 1550
NoConn ~ 3050 3650
NoConn ~ 3050 3750
NoConn ~ 3050 3050
Wire Wire Line
	600  1550 600  1600
$Comp
L Interface_Expansion:PCF8574 U2
U 1 1 5E9291BD
P 9500 3900
F 0 "U2" H 9500 4781 50  0000 C CNN
F 1 "PCF8574" H 9500 4690 50  0000 C CNN
F 2 "pcf8574:SO16W" H 9500 3900 50  0001 C CNN
F 3 "http://www.nxp.com/documents/data_sheet/PCF8574_PCF8574A.pdf" H 9500 3900 50  0001 C CNN
	1    9500 3900
	1    0    0    -1  
$EndComp
$Comp
L Interface_Expansion:PCF8574 U3
U 1 1 5E985F9A
P 6650 4000
F 0 "U3" H 6650 4881 50  0000 C CNN
F 1 "PCF8574" H 6650 4790 50  0000 C CNN
F 2 "pcf8574:SO16W" H 6650 4000 50  0001 C CNN
F 3 "http://www.nxp.com/documents/data_sheet/PCF8574_PCF8574A.pdf" H 6650 4000 50  0001 C CNN
	1    6650 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	7100 2750 7100 2850
Wire Wire Line
	7400 2750 7100 2750
$Comp
L power:VCC #PWR0118
U 1 1 5F5AE1F9
P 7100 2850
F 0 "#PWR0118" H 7100 2700 50  0001 C CNN
F 1 "VCC" H 7117 3023 50  0000 C CNN
F 2 "" H 7100 2850 50  0001 C CNN
F 3 "" H 7100 2850 50  0001 C CNN
	1    7100 2850
	1    0    0    1   
$EndComp
Wire Wire Line
	7400 2850 7300 2850
$Comp
L power:GND #PWR0113
U 1 1 5D9668CC
P 7300 2850
F 0 "#PWR0113" H 7300 2600 50  0001 C CNN
F 1 "GND" H 7305 2677 50  0000 C CNN
F 2 "" H 7300 2850 50  0001 C CNN
F 3 "" H 7300 2850 50  0001 C CNN
	1    7300 2850
	-1   0    0    -1  
$EndComp
Wire Wire Line
	10750 4200 10750 4400
Wire Wire Line
	10750 4400 10700 4400
Text Label 10500 3000 2    50   ~ 0
JoyLeftX_L
Wire Wire Line
	10400 4200 10000 4200
Text Label 8600 3700 3    50   ~ 0
SDA_L
Text Label 8500 3700 3    50   ~ 0
SCL_L
$Comp
L Device:R R5
U 1 1 5F000D96
P 7700 4300
F 0 "R5" V 7493 4300 50  0000 C CNN
F 1 "1K" V 7584 4300 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 7630 4300 50  0001 C CNN
F 3 "~" H 7700 4300 50  0001 C CNN
	1    7700 4300
	0    1    1    0   
$EndComp
$Comp
L Device:LED D1
U 1 1 5F000D9C
P 7700 4500
F 0 "D1" H 7693 4716 50  0000 C CNN
F 1 "LED" H 7693 4625 50  0000 C CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 7700 4500 50  0001 C CNN
F 3 "~" H 7700 4500 50  0001 C CNN
	1    7700 4500
	-1   0    0    1   
$EndComp
Wire Wire Line
	7900 4300 7850 4300
Wire Wire Line
	7900 4300 7900 4500
Wire Wire Line
	7900 4500 7850 4500
Wire Wire Line
	7550 4300 7150 4300
Wire Wire Line
	7550 4500 7400 4500
Wire Wire Line
	8250 1400 8250 1900
Connection ~ 8250 1400
Wire Wire Line
	8250 900  8250 1400
Connection ~ 9100 1400
Wire Wire Line
	9100 900  9100 1400
Connection ~ 9950 1400
Wire Wire Line
	9950 900  9950 1400
$Comp
L Switch:SW_Push SW3
U 1 1 5CE36F95
P 9300 900
F 0 "SW3" H 9300 1185 50  0000 C CNN
F 1 "Up" H 9300 1094 50  0000 C CNN
F 2 "button-contacts:Large_tapered" H 9300 1100 50  0001 C CNN
F 3 "~" H 9300 1100 50  0001 C CNN
	1    9300 900 
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW4
U 1 1 5CE3B249
P 9300 1400
F 0 "SW4" H 9300 1685 50  0000 C CNN
F 1 "Down" H 9300 1594 50  0000 C CNN
F 2 "button-contacts:Large_tapered" H 9300 1600 50  0001 C CNN
F 3 "~" H 9300 1600 50  0001 C CNN
	1    9300 1400
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW2
U 1 1 5CE355F4
P 10150 1400
F 0 "SW2" H 10150 1685 50  0000 C CNN
F 1 "Right" H 10150 1594 50  0000 C CNN
F 2 "button-contacts:Large_tapered" H 10150 1600 50  0001 C CNN
F 3 "~" H 10150 1600 50  0001 C CNN
	1    10150 1400
	1    0    0    -1  
$EndComp
$Comp
L Diode:1N4148 D7
U 1 1 5EA4B7C7
P 10550 1400
F 0 "D7" H 10550 1184 50  0000 C CNN
F 1 "1N4148" H 10550 1275 50  0000 C CNN
F 2 "Diode_SMD:D_0603_1608Metric" H 10550 1225 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 10550 1400 50  0001 C CNN
	1    10550 1400
	-1   0    0    1   
$EndComp
$Comp
L Diode:1N4148 D8
U 1 1 5EA4B7CD
P 9700 900
F 0 "D8" H 9700 684 50  0000 C CNN
F 1 "1N4148" H 9700 775 50  0000 C CNN
F 2 "Diode_SMD:D_0603_1608Metric" H 9700 725 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 9700 900 50  0001 C CNN
	1    9700 900 
	-1   0    0    1   
$EndComp
$Comp
L Diode:1N4148 D9
U 1 1 5EA4B7D3
P 9700 1400
F 0 "D9" H 9700 1184 50  0000 C CNN
F 1 "1N4148" H 9700 1275 50  0000 C CNN
F 2 "Diode_SMD:D_0603_1608Metric" H 9700 1225 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 9700 1400 50  0001 C CNN
	1    9700 1400
	-1   0    0    1   
$EndComp
Wire Wire Line
	10400 1400 10350 1400
Wire Wire Line
	9550 900  9500 900 
Wire Wire Line
	9550 1400 9500 1400
Text Label 10800 2050 0    50   ~ 0
RowL3
Text Label 10800 1550 0    50   ~ 0
RowL2
Text Label 10800 1050 0    50   ~ 0
RowL1
$Comp
L Switch:SW_Push SW13
U 1 1 5E9D17DF
P 8450 1400
F 0 "SW13" H 8450 1685 50  0000 C CNN
F 1 "Left" H 8450 1594 50  0000 C CNN
F 2 "button-contacts:Large_tapered" H 8450 1600 50  0001 C CNN
F 3 "~" H 8450 1600 50  0001 C CNN
	1    8450 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8700 1900 8650 1900
Wire Wire Line
	8700 1400 8650 1400
Wire Wire Line
	8700 900  8650 900 
Wire Wire Line
	10400 900  10350 900 
$Comp
L Diode:1N4148 D6
U 1 1 5EA52B8D
P 8850 1900
F 0 "D6" H 8850 1684 50  0000 C CNN
F 1 "1N4148" H 8850 1775 50  0000 C CNN
F 2 "Diode_SMD:D_0603_1608Metric" H 8850 1725 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 8850 1900 50  0001 C CNN
	1    8850 1900
	-1   0    0    1   
$EndComp
$Comp
L Diode:1N4148 D5
U 1 1 5EA52B87
P 8850 1400
F 0 "D5" H 8850 1184 50  0000 C CNN
F 1 "1N4148" H 8850 1275 50  0000 C CNN
F 2 "Diode_SMD:D_0603_1608Metric" H 8850 1225 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 8850 1400 50  0001 C CNN
	1    8850 1400
	-1   0    0    1   
$EndComp
$Comp
L Diode:1N4148 D4
U 1 1 5EA52B81
P 8850 900
F 0 "D4" H 8850 684 50  0000 C CNN
F 1 "1N4148" H 8850 775 50  0000 C CNN
F 2 "Diode_SMD:D_0603_1608Metric" H 8850 725 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 8850 900 50  0001 C CNN
	1    8850 900 
	-1   0    0    1   
$EndComp
$Comp
L Diode:1N4148 D3
U 1 1 5EA52B7B
P 10550 900
F 0 "D3" H 10550 684 50  0000 C CNN
F 1 "1N4148" H 10550 775 50  0000 C CNN
F 2 "Diode_SMD:D_0603_1608Metric" H 10550 725 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 10550 900 50  0001 C CNN
	1    10550 900 
	-1   0    0    1   
$EndComp
$Comp
L Switch:SW_Push SW14
U 1 1 5E9D17D9
P 8450 1900
F 0 "SW14" H 8450 2185 50  0000 C CNN
F 1 "L2" H 8450 2094 50  0000 C CNN
F 2 "right-angle-tact:TL3330" H 8450 2100 50  0001 C CNN
F 3 "~" H 8450 2100 50  0001 C CNN
	1    8450 1900
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW6
U 1 1 5CE3C552
P 10150 900
F 0 "SW6" H 10150 1185 50  0000 C CNN
F 1 "Select" H 10150 1094 50  0000 C CNN
F 2 "button-contacts:Small" H 10150 1100 50  0001 C CNN
F 3 "~" H 10150 1100 50  0001 C CNN
	1    10150 900 
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW7
U 1 1 5CE3CA1D
P 8450 900
F 0 "SW7" H 8450 1185 50  0000 C CNN
F 1 "L1" H 8450 1094 50  0000 C CNN
F 2 "right-angle-tact:TL3330" H 8450 1100 50  0001 C CNN
F 3 "~" H 8450 1100 50  0001 C CNN
	1    8450 900 
	1    0    0    -1  
$EndComp
Wire Wire Line
	10800 1050 10700 1050
Wire Wire Line
	9000 1050 9000 900 
Wire Wire Line
	9850 900  9850 1050
Connection ~ 9850 1050
Wire Wire Line
	9850 1050 9000 1050
Wire Wire Line
	10700 900  10700 1050
Connection ~ 10700 1050
Wire Wire Line
	10700 1050 9850 1050
Wire Wire Line
	10800 1550 10700 1550
Wire Wire Line
	9000 1550 9000 1400
Wire Wire Line
	9000 2050 9000 1900
Wire Wire Line
	10700 1400 10700 1550
Connection ~ 10700 1550
Wire Wire Line
	10700 1550 9850 1550
Wire Wire Line
	9850 1400 9850 1550
Connection ~ 9850 1550
Wire Wire Line
	9850 1550 9000 1550
Wire Wire Line
	4900 1400 4900 1900
Connection ~ 4900 1400
Connection ~ 4900 1900
Wire Wire Line
	4900 900  4900 1400
Connection ~ 5750 1400
Wire Wire Line
	5750 900  5750 1400
Connection ~ 6600 1400
Wire Wire Line
	6600 900  6600 1400
Text Label 6600 2150 0    50   ~ 0
Col3
$Comp
L Switch:SW_Push SW11
U 1 1 5F40F887
P 5950 900
F 0 "SW11" H 5950 1185 50  0000 C CNN
F 1 "A" H 5950 1094 50  0000 C CNN
F 2 "button-contacts:Large_tapered" H 5950 1100 50  0001 C CNN
F 3 "~" H 5950 1100 50  0001 C CNN
	1    5950 900 
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW16
U 1 1 5F40F88D
P 5950 1400
F 0 "SW16" H 5950 1685 50  0000 C CNN
F 1 "B" H 5950 1594 50  0000 C CNN
F 2 "button-contacts:Large_tapered" H 5950 1600 50  0001 C CNN
F 3 "~" H 5950 1600 50  0001 C CNN
	1    5950 1400
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW18
U 1 1 5F40F899
P 6800 1400
F 0 "SW18" H 6800 1685 50  0000 C CNN
F 1 "Y" H 6800 1594 50  0000 C CNN
F 2 "button-contacts:Large_tapered" H 6800 1600 50  0001 C CNN
F 3 "~" H 6800 1600 50  0001 C CNN
	1    6800 1400
	1    0    0    -1  
$EndComp
$Comp
L Diode:1N4148 D18
U 1 1 5F40F89F
P 7200 1400
F 0 "D18" H 7200 1184 50  0000 C CNN
F 1 "1N4148" H 7200 1275 50  0000 C CNN
F 2 "Diode_SMD:D_0603_1608Metric" H 7200 1225 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 7200 1400 50  0001 C CNN
	1    7200 1400
	-1   0    0    1   
$EndComp
$Comp
L Diode:1N4148 D14
U 1 1 5F40F8A5
P 6350 900
F 0 "D14" H 6350 684 50  0000 C CNN
F 1 "1N4148" H 6350 775 50  0000 C CNN
F 2 "Diode_SMD:D_0603_1608Metric" H 6350 725 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 6350 900 50  0001 C CNN
	1    6350 900 
	-1   0    0    1   
$EndComp
$Comp
L Diode:1N4148 D15
U 1 1 5F40F8AB
P 6350 1400
F 0 "D15" H 6350 1184 50  0000 C CNN
F 1 "1N4148" H 6350 1275 50  0000 C CNN
F 2 "Diode_SMD:D_0603_1608Metric" H 6350 1225 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 6350 1400 50  0001 C CNN
	1    6350 1400
	-1   0    0    1   
$EndComp
Wire Wire Line
	7050 1400 7000 1400
Wire Wire Line
	6200 900  6150 900 
Wire Wire Line
	6200 1400 6150 1400
Text Label 5750 2150 0    50   ~ 0
Col2
Text Label 7450 2050 0    50   ~ 0
Row3
Text Label 7450 1550 0    50   ~ 0
Row2
Text Label 7450 1050 0    50   ~ 0
Row1
$Comp
L Switch:SW_Push SW8
U 1 1 5F40F8C0
P 5100 1400
F 0 "SW8" H 5100 1685 50  0000 C CNN
F 1 "R1" H 5100 1594 50  0000 C CNN
F 2 "right-angle-tact:TL3330" H 5100 1600 50  0001 C CNN
F 3 "~" H 5100 1600 50  0001 C CNN
	1    5100 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 1900 4900 2150
Wire Wire Line
	5350 1900 5300 1900
Wire Wire Line
	5350 1400 5300 1400
Wire Wire Line
	5350 900  5300 900 
Wire Wire Line
	7050 900  7000 900 
$Comp
L Diode:1N4148 D13
U 1 1 5F40F8CB
P 5500 1900
F 0 "D13" H 5500 1684 50  0000 C CNN
F 1 "1N4148" H 5500 1775 50  0000 C CNN
F 2 "Diode_SMD:D_0603_1608Metric" H 5500 1725 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 5500 1900 50  0001 C CNN
	1    5500 1900
	-1   0    0    1   
$EndComp
$Comp
L Diode:1N4148 D12
U 1 1 5F40F8D1
P 5500 1400
F 0 "D12" H 5500 1184 50  0000 C CNN
F 1 "1N4148" H 5500 1275 50  0000 C CNN
F 2 "Diode_SMD:D_0603_1608Metric" H 5500 1225 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 5500 1400 50  0001 C CNN
	1    5500 1400
	-1   0    0    1   
$EndComp
$Comp
L Diode:1N4148 D11
U 1 1 5F40F8D7
P 5500 900
F 0 "D11" H 5500 684 50  0000 C CNN
F 1 "1N4148" H 5500 775 50  0000 C CNN
F 2 "Diode_SMD:D_0603_1608Metric" H 5500 725 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 5500 900 50  0001 C CNN
	1    5500 900 
	-1   0    0    1   
$EndComp
$Comp
L Diode:1N4148 D17
U 1 1 5F40F8DD
P 7200 900
F 0 "D17" H 7200 684 50  0000 C CNN
F 1 "1N4148" H 7200 775 50  0000 C CNN
F 2 "Diode_SMD:D_0603_1608Metric" H 7200 725 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 7200 900 50  0001 C CNN
	1    7200 900 
	-1   0    0    1   
$EndComp
$Comp
L Switch:SW_Push SW10
U 1 1 5F40F8E3
P 5100 1900
F 0 "SW10" H 5100 2185 50  0000 C CNN
F 1 "R2" H 5100 2094 50  0000 C CNN
F 2 "right-angle-tact:TL3330" H 5100 2100 50  0001 C CNN
F 3 "~" H 5100 2100 50  0001 C CNN
	1    5100 1900
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW19
U 1 1 5F40F8E9
P 6800 900
F 0 "SW19" H 6800 1185 50  0000 C CNN
F 1 "X" H 6800 1094 50  0000 C CNN
F 2 "button-contacts:Large_tapered" H 6800 1100 50  0001 C CNN
F 3 "~" H 6800 1100 50  0001 C CNN
	1    6800 900 
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW17
U 1 1 5F40F8EF
P 5100 900
F 0 "SW17" H 5100 1185 50  0000 C CNN
F 1 "Start" H 5100 1094 50  0000 C CNN
F 2 "button-contacts:Small" H 5100 1100 50  0001 C CNN
F 3 "~" H 5100 1100 50  0001 C CNN
	1    5100 900 
	1    0    0    -1  
$EndComp
Text Label 4900 2150 0    50   ~ 0
Col1
Wire Wire Line
	7450 1050 7350 1050
Wire Wire Line
	5650 1050 5650 900 
Wire Wire Line
	6500 900  6500 1050
Connection ~ 6500 1050
Wire Wire Line
	6500 1050 5650 1050
Wire Wire Line
	7350 900  7350 1050
Connection ~ 7350 1050
Wire Wire Line
	7350 1050 6500 1050
Wire Wire Line
	7450 1550 7350 1550
Wire Wire Line
	5650 1550 5650 1400
Wire Wire Line
	5650 2050 5650 1900
Wire Wire Line
	7350 1400 7350 1550
Connection ~ 7350 1550
Wire Wire Line
	7350 1550 6500 1550
Wire Wire Line
	6500 1400 6500 1550
Connection ~ 6500 1550
Wire Wire Line
	6500 1550 5650 1550
$Comp
L Connector_Generic:Conn_01x06 J2
U 1 1 5D94373B
P 7600 2550
F 0 "J2" H 7680 2542 50  0000 L CNN
F 1 "Conn_01x06" H 7680 2451 50  0000 L CNN
F 2 "Connector_FFC-FPC:Hirose_FH12-6S-0.5SH_1x06-1MP_P0.50mm_Horizontal" H 7600 2550 50  0001 C CNN
F 3 "~" H 7600 2550 50  0001 C CNN
	1    7600 2550
	1    0    0    -1  
$EndComp
Text Label 7150 3600 0    50   ~ 0
Row1
Text Label 7150 3700 0    50   ~ 0
Row2
Text Label 7150 3800 0    50   ~ 0
Row3
Text Label 7150 3900 0    50   ~ 0
Col1
Text Label 7150 4000 0    50   ~ 0
Col2
Text Label 7150 4100 0    50   ~ 0
Col3
Text Label 7150 4200 0    50   ~ 0
R3
Text Label 8250 2150 0    50   ~ 0
ColL1
Text Label 9100 2150 0    50   ~ 0
ColL2
Text Label 9950 2150 0    50   ~ 0
ColL3
Wire Wire Line
	8250 1900 8250 2150
Connection ~ 8250 1900
$Comp
L Device:R R7
U 1 1 5F64E308
P 5850 3400
F 0 "R7" V 5643 3400 50  0000 C CNN
F 1 "1K" V 5734 3400 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 5780 3400 50  0001 C CNN
F 3 "~" H 5850 3400 50  0001 C CNN
	1    5850 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 5F653BB0
P 5550 3400
F 0 "R8" V 5343 3400 50  0000 C CNN
F 1 "1K" V 5434 3400 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 5480 3400 50  0001 C CNN
F 3 "~" H 5550 3400 50  0001 C CNN
	1    5550 3400
	1    0    0    -1  
$EndComp
Text Label 5750 3800 3    50   ~ 0
SDA
Text Label 5650 3800 3    50   ~ 0
SCL
Text Label 9500 4600 3    50   ~ 0
GND_L
Text Label 8900 3050 2    50   ~ 0
VCC_L
$Comp
L power:GND #PWR0102
U 1 1 5F7797AA
P 6650 4700
F 0 "#PWR0102" H 6650 4450 50  0001 C CNN
F 1 "GND" H 6655 4527 50  0000 C CNN
F 2 "" H 6650 4700 50  0001 C CNN
F 3 "" H 6650 4700 50  0001 C CNN
	1    6650 4700
	-1   0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0119
U 1 1 5F7797A4
P 6050 3200
F 0 "#PWR0119" H 6050 3050 50  0001 C CNN
F 1 "VCC" H 6067 3373 50  0000 C CNN
F 2 "" H 6050 3200 50  0001 C CNN
F 3 "" H 6050 3200 50  0001 C CNN
	1    6050 3200
	-1   0    0    -1  
$EndComp
Wire Wire Line
	6650 3300 6050 3300
Wire Wire Line
	6050 3200 6050 3250
Wire Wire Line
	5550 3250 5850 3250
Connection ~ 6050 3250
Wire Wire Line
	6050 3250 6050 3300
Connection ~ 5850 3250
Wire Wire Line
	5850 3250 6050 3250
Wire Wire Line
	6150 3600 5850 3600
Wire Wire Line
	5850 3600 5850 3550
Wire Wire Line
	6150 3700 5750 3700
Wire Wire Line
	5550 3700 5550 3550
Wire Wire Line
	5850 3600 5650 3600
Wire Wire Line
	5650 3600 5650 3800
Connection ~ 5850 3600
Wire Wire Line
	5750 3800 5750 3700
Connection ~ 5750 3700
Wire Wire Line
	5750 3700 5550 3700
$Comp
L Device:R R10
U 1 1 5FA04417
P 8700 3300
F 0 "R10" V 8493 3300 50  0000 C CNN
F 1 "1K" V 8584 3300 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 8630 3300 50  0001 C CNN
F 3 "~" H 8700 3300 50  0001 C CNN
	1    8700 3300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R9
U 1 1 5FA0441D
P 8400 3300
F 0 "R9" V 8193 3300 50  0000 C CNN
F 1 "1K" V 8284 3300 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 8330 3300 50  0001 C CNN
F 3 "~" H 8400 3300 50  0001 C CNN
	1    8400 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	8400 3150 8700 3150
Connection ~ 8700 3150
Wire Wire Line
	8700 3150 8900 3150
Wire Wire Line
	9000 3500 8700 3500
Wire Wire Line
	8700 3500 8700 3450
Wire Wire Line
	9000 3600 8600 3600
Wire Wire Line
	8400 3600 8400 3450
Wire Wire Line
	8700 3500 8500 3500
Wire Wire Line
	8500 3500 8500 3700
Connection ~ 8700 3500
Wire Wire Line
	8600 3700 8600 3600
Connection ~ 8600 3600
Wire Wire Line
	8600 3600 8400 3600
Wire Wire Line
	9500 3200 8900 3200
Wire Wire Line
	8900 3200 8900 3150
Connection ~ 8900 3150
Wire Wire Line
	8900 3150 8900 3050
Wire Wire Line
	6150 3900 6150 4000
Connection ~ 6150 4000
Wire Wire Line
	6150 4000 6150 4100
Wire Wire Line
	6150 4000 6050 4000
Wire Wire Line
	6050 4000 6050 4700
Wire Wire Line
	6050 4700 6650 4700
Connection ~ 6650 4700
Text Label 3050 2550 0    50   ~ 0
SDA
Text Label 3050 2450 0    50   ~ 0
SCL
NoConn ~ 3050 2250
NoConn ~ 3050 2150
NoConn ~ 3050 1950
NoConn ~ 3050 1850
NoConn ~ 3050 1750
NoConn ~ 3050 1650
NoConn ~ 3050 3150
NoConn ~ 3050 3450
NoConn ~ 3050 3350
NoConn ~ 3050 2950
NoConn ~ 3050 2850
NoConn ~ 9000 3800
NoConn ~ 9000 3900
NoConn ~ 9000 4000
NoConn ~ 9000 4300
NoConn ~ 6150 4400
Text Label 3050 3950 0    50   ~ 0
JoyLeftY
Text Label 3050 3850 0    50   ~ 0
JoyLeftX
Text Label 7400 2350 2    50   ~ 0
SDA
Text Label 7400 2450 2    50   ~ 0
SCL
Text Label 7400 2550 2    50   ~ 0
JoyLeftX
Text Label 8950 2650 0    50   ~ 0
JoyLeftY_L
Text Label 8950 2550 0    50   ~ 0
JoyLeftX_L
Text Label 8950 2450 0    50   ~ 0
SCL_L
Text Label 8950 2350 0    50   ~ 0
SDA_L
NoConn ~ 3050 2750
NoConn ~ 3050 2650
Text Label 8950 2750 0    50   ~ 0
VCC_L
Text Label 8950 2850 0    50   ~ 0
GND_L
Text Label 10500 2600 2    50   ~ 0
VCC_L
Text Label 10500 2700 2    50   ~ 0
JoyLeftY_L
Text Label 10500 2800 2    50   ~ 0
L3
Text Label 5600 2750 0    50   ~ 0
R3
Text Label 7400 2650 2    50   ~ 0
JoyLeftY
Wire Wire Line
	6600 1400 6600 2150
Wire Wire Line
	5750 1400 5750 2150
Wire Wire Line
	9950 1400 9950 2150
Wire Wire Line
	9100 1400 9100 2150
Wire Wire Line
	5650 2050 7450 2050
Wire Wire Line
	9000 2050 10800 2050
$EndSCHEMATC
