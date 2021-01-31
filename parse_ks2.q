\c 25 188
csvTypes:"****IS***SS******SS**********************************************I***I***I************************************************************************************************************************************************************************************************************************";
desiredCols:`URN`SCHNAME`TOWN`PCODE`RELDENOM`AGERANGE`PTKS1GROUP_L`PTKS1GROUP_H`PTEALGRP2`PTRWM_EXP`PTRWM_HIGH`PTREAD_EXP`PTREAD_HIGH`PTGPS_EXP`PTGPS_HIGH`PTMAT_EXP`PTMAT_HIGH`PTWRITTA_EXP`PTWRITTA_HIGH`READ_AVERAGE`GPS_AVERAGE`MAT_AVERAGE;
stripPercCols:`PTKS1GROUP_L`PTKS1GROUP_H`PTEALGRP2`PTRWM_EXP`PTRWM_HIGH`PTREAD_EXP`PTREAD_HIGH`PTGPS_EXP`PTGPS_HIGH`PTMAT_EXP`PTMAT_HIGH`PTWRITTA_EXP`PTWRITTA_HIGH;
newColMap:.[!]2#enlist desiredCols;
oldColMap:desiredCols!`URN`SCHNAME`TOWN`PCODE`RELDENOM`AGERANGE`PKS1EXP_L`PKS1EXP_H`PTEALGRP2`PTREADWRITTAMAT4B`PTREADWRITTAMATAX`PTREAD4B`PTREADAX`PTGPS4B`PTGPSAX`PTMAT4B`PTMATAX`PTWRITXTA`PTWRITAXTA,3#0Ni;
parseCSV:{[fileName;year;colMap]
    -1 "parsing: ",fileName;
    `year xcols update year:year from ![?[(csvTypes;1#",")0: -1!`$"data/",fileName;();0b;colMap];();0b;stripPercCols!raze {enlist ((';{"I"$ssr[raze enlist x;"%";""]});x)} each stripPercCols]
 };
ks2:raze .[parseCSV;] each (("2012-2013_england_ks2final.csv";2013;oldColMap);("2013-2014_england_ks2final.csv";2014;oldColMap);("2014-2015_england_ks2final.csv";2015;oldColMap);("2015-2016_england_ks2final.csv";2016;newColMap);("2016-2017_england_ks2final.csv";2017;newColMap);("2017-2018_england_ks2final.csv";2018;newColMap);("2018-2019_england_ks2final.csv";2019;newColMap));
-1 "parsed, renaming cols";

ks2:`year`urn`schoolName`town`postCode`religiousAffiliation`ages`low_achivers_ks1_perc`high_achivers_ks1_perc`english_second_language_perc`rwm_avg_perc`rwm_high_perc`reading_avg_perc`reading_high_perc`gps_avg_perc`gps_high_perc`maths_avg_perc`maths_high_perc`writing_avg_perc`writing_high_perc`avg_score_reading`avg_score_gps`avg_score_maths xcol ks2;

show 5?ks2;

-1 "ks2 ready to use";
