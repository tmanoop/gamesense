INSERT INTO APP.MCSENSE_READINGS (READING_ID, CREATED_TIME, SIGNALLEVEL, FREQUENCY, CAPABILITIES, SSID, BSSID, GPS_LNG, GPS_LAT, USER_ID, SQUARE_ID ) values (1, '2012-04-11 16:43:00',	-91,	2412,	'',	'njit',	'd0-c2-82-f1-fc-d1',	-74.179683,	40.744323,	701, 0);

select count(square_id) from APP.MCSENSE_READINGS group by square_id