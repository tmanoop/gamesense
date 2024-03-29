create table App.Area (sqaure_id integer PRIMARY KEY, square_desc varchar(32), floor_num integer, room_num varchar(16), tile_x double, tile_y double, gps_lat double, gps_lng double, covered_ind varchar(32));
create table App.Users (user_id integer PRIMARY KEY, user_access varchar(10), user_email varchar(255), bullets integer, score integer, status_level integer, user_meid varchar(255), aliens_killed integer);
create table App.Sensor_Readings (reading_id integer PRIMARY KEY, user_id integer, square_id integer, gps_lat double, gps_lng double,  BSSID varchar(255), SSID varchar(255), Capabilities varchar(255), Frequency integer, SignalLevel integer);
create table App.Reading_values (reading_value_id integer PRIMARY KEY, reading_id integer, mac_id char(12), mac_signal_strength double);
create table App.Aliens (alien_id integer PRIMARY KEY, square_id integer, shot_count integer);
create table App.Player_Aliens (player_alien_id integer PRIMARY KEY, shot_alien_id integer, user_id integer, shot_square_id integer, gps_lat double, gps_lng double);
create table App.Bullets (bullet_id integer PRIMARY KEY, bullet_count integer,  square_id integer, gps_lat double, gps_lng double);
create table App.Sentinels (sentinel_id integer PRIMARY KEY, user_email varchar(255), user_meid varchar(255), gps_lat double, gps_lng double);

C:\Users\Sups\Documents\McSense_validation\user_groups.csv

CALL SYSCS_UTIL.SYSCS_IMPORT_TABLE (null,'APP.Mcsense_Readings','C:\Users\E0197060\Downloads\mcsense_wifi.csv',';',null,null,0);

create table App.Mcsense_Readings (reading_id integer PRIMARY KEY, user_id integer, square_id integer, gps_lat double, gps_lng double,  BSSID varchar(255), SSID varchar(255), Capabilities varchar(255), Frequency integer, SignalLevel integer);

ALTER TABLE APP.Mcsense_Readings ADD CREATED_TIME TIMESTAMP;

select count(*) from APP.Mcsense_Readings where square_id = 0;

ALTER TABLE APP.Sensor_Readings ADD CREATED_TIME TIMESTAMP;

ALTER TABLE APP.Sensor_Readings ADD altitude integer;

ALTER TABLE APP.Aliens ADD user_id integer;

ALTER TABLE APP.Area ALTER square_desc SET DATA TYPE varchar(200);

ALTER TABLE APP.Area ADD rutgers_ind varchar(10);

update APP.area
set rutgers_ind = 'N'
where tile_x = 1
and tile_y = 1

drop table App.Area;
drop table App.Users;
drop table App.Reading_values;
drop table App.Aliens;
drop table App.Player_Aliens;
drop table App.Bullets;
drop table App.Sentinels;
p.getStatusLevel()
drop table Area;
drop table Users;
drop table Sensor_Readings;
drop table Reading_values;
drop table Aliens;
drop table Player_Aliens;
drop table Bullets;
drop table Sentinels;

delete from App.Sentinels where sentinel_id = 96496;

delete from App.Aliens;
delete from App.Sensor_Readings;
delete from App.Users;
select * from App.Users;
select * from App.Users where status_level = '1' and score>0;
select status_level, count(*) from App.Users group by status_level;
select * from App.Aliens where shot_count=2;

select square_id, count(*) from App.Aliens group by square_id

select count(*) from App.Aliens where shot_count<2;

update APP.Users
set BULLETS = 100
where STATUS_LEVEL is NULL;

update APP.Users
set STATUS_LEVEL = '1'
where STATUS_LEVEL is NULL;

select user_email from APP.USERS
where USER_ACCESS is not NULL;

update APP.Users
set USER_ACCESS = 'Y'
where user_email = 'tmanoop@gmail.com'
select count(*) from APP.AREA where COVERED_IND = 'Y'
update APP.Sensor_Readings
set CREATED_TIME = '2014-03-30 08:00:00'

select * from SENSOR_READINGS sr where sr.READING_ID in (select MAX(READING_ID) from SENSOR_READINGS group by USER_ID) 

select min(reading_id) from APP.SENSOR_READINGS -- 99807

select max(reading_id) from APP.SENSOR_READINGS -- 1317232

select * from APP.SENSOR_READINGS where square_id = 0 and (SSID like ('%NJIT%') or SSID like ('%njit%'))
update APP.SENSOR_READINGS 
set square_id = -1 
where square_id = 0
select min(SIGNALLEVEL) from APP.SENSOR_READINGS order by reading_id desc

--below query to check the max min of overall squares
select max(A.avg_signal_level)
	from
	(select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			group by square_id) A
			
--below query to get max signal of all squares
select square_id, max(SIGNALLEVEL) from APP.SENSOR_READINGS 
	where square_id >= 0
		group by square_id
		order by square_id;
			
-- below query to get max signal of each square having NJIT signal
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2014-04-01 00:00:00' and '2014-04-29 00:00:00'
			group by square_id
			order by square_id;
			
-- below query to get max signal of each square having NJIT signal from mcsense data
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2012-04-02 00:00:00' and '2012-04-16 00:00:00'
			group by square_id
			order by square_id;

--results for MASS 14 paper
-- get number of squares covered grouped by date
	
select A.date_part, count(*) from (
select DATE(created_time) as date_part, square_id from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
) A
group by A.date_part
	
select DATE(created_time) from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
-- Total number of squares at floor 0 are 868 
select count(*) from APP.AREA a where a.rutgers_ind = 'N' and floor_num = 0
			
			select * from APP.AREA where rutgers_ind = 'N' and tile_x = 616470 and tile_y = 788258
-- no NJIT WiFI reading - red -- TODO verify the query to subtract
select square_id from APP.SENSOR_READINGS 
	where square_id > 0
		group by square_id
EXCEPT
select square_id as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			group by square_id
	
-- verify the no NJIT WiFi readings square
select * from APP.SENSOR_READINGS 
where square_id = 77
-- 0 - 109
-- 0 - 35 - Strong -  green
select * from APP.SENSOR_READINGS 
	where (SSID like ('%NJIT%') or SSID like ('%njit%'))
		and SIGNALLEVEL between -35 and 0;
-- 36 - 70 - medium -  blue
select * from APP.SENSOR_READINGS 
	where (SSID like ('%NJIT%') or SSID like ('%njit%'))
		and SIGNALLEVEL between -70 and -36;
-- 71 or higher - low -  yellow
select * from APP.SENSOR_READINGS 
	where (SSID like ('%NJIT%') or SSID like ('%njit%'))
		and SIGNALLEVEL > -71
		group by square_id;
		

ALTER TABLE APP.Aliens
ADD FOREIGN KEY (sqaure_id) 
REFERENCES APP.Area(sqaure_id)
ON DELETE CASCADE;

update APP.AREA
set COVERED_IND = 'N'
delete from App.Aliens;
update App.Aliens
set SHOT_COUNT = 0, square_id = 1 where alien_id = 1551;

select * from App.Aliens 

insert into "APP"."ALIENS" ("ALIEN_ID", "NEXT_GPS_LAT", "NEXT_GPS_LNG", "CURRENT_SQUARE_ID", "SHOT_COUNT") values(1, 0.0, 0.0, 0, 0)

--in new schema or database, below table is needed for JPA to generate keys 
--also set jdbc/MyDB in datasources and datapool settings in admin console
drop table APP.SEQUENCE

CREATE TABLE APP.SEQUENCE (SEQ_NAME VARCHAR(50) NOT NULL, SEQ_COUNT DECIMAL(15), PRIMARY KEY (SEQ_NAME));

INSERT INTO APP.SEQUENCE (SEQ_NAME, SEQ_COUNT) VALUES ('SEQ_GEN',500);
INSERT INTO APP.SEQUENCE (SEQ_NAME, SEQ_COUNT) VALUES ('SEQ_GEN_TABLE',0);

Select * from App.Users

Select sum(aliens_killed) from App.Users
order by score

select distinct square_id, altitude from APP.Sensor_Readings where altitude <> 0 and square_id > 0;
select distinct square_id from APP.Sensor_Readings where altitude > 20 and square_id > 0;

--find number of squares covered in upper floors

select * from APP.AREA A where A.sqaure_id in (select distinct S.square_id from APP.Sensor_Readings S where S.altitude > 20 and S.square_id > 0)
                                              and A.floor_num > 0;

select * from APP.Sensor_Readings where altitude <> 0 and square_id > 0 and user_id = 2286757 and created_time > '2014-04-12 12:00:00';

select * from APP.Sensor_Readings where altitude <> 0 and square_id > 0 and user_id = 2848035 and created_time > '2014-04-13 17:55:00';

select * from APP.AREA where floor_num > 0 and COVERED_IND = 'Y'

order by reading_id desc
select * from APP.AREA where floor_num > 0 and TILE_X = 616449 and TILE_Y = 788246

update App.AREA 
set SQUARE_DESC = 'Student Mall / Parking Deck'
where SQUARE_DESC = 'Guttenberg Information Technologies Center'

select count(*) from App.ALIENS where shot_count

select * from APP.AREA where GPS_LAT is NULL;
select count(*) from APP.AREA where COVERED_IND = 'Y'
select count(*) from APP.AREA where COVERED_IND = 'N'
--day1  5pm--160 sq cov  
--delete existing squares
delete from APP.AREA;

----insert squares
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1, 'NJIT', 0, '0', 616446.0, 788243.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(2, 'NJIT', 0, '0', 616447.0, 788243.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(3, 'NJIT', 0, '0', 616448.0, 788243.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(4, 'NJIT', 0, '0', 616446.0, 788244.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(5, 'NJIT', 0, '0', 616447.0, 788244.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(6, 'NJIT', 0, '0', 616448.0, 788244.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(7, 'NJIT', 0, '0', 616449.0, 788244.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(8, 'NJIT', 0, '0', 616450.0, 788244.0, 'N');


insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(9, 'HOME', 0, '0', 614191.0, 789883.0, 'N');

-----------------------------NJIT Tiles
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1, 'NJIT', 0, '0',616446.0,788243.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(2, 'NJIT', 0, '0',616447.0,788243.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(3, 'NJIT', 0, '0',616448.0,788243.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(4, 'NJIT', 0, '0',616446.0,788244.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(5, 'NJIT', 0, '0',616447.0,788244.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(6, 'NJIT', 0, '0',616448.0,788244.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(7, 'NJIT', 0, '0',616449.0,788244.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(8, 'NJIT', 0, '0',616450.0,788244.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(9, 'NJIT', 0, '0',616446.0,788245.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(10, 'NJIT', 0, '0',616447.0,788245.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(11, 'NJIT', 0, '0',616448.0,788245.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(12, 'NJIT', 0, '0',616449.0,788245.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(13, 'NJIT', 0, '0',616450.0,788245.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(14, 'NJIT', 0, '0',616451.0,788245.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(15, 'NJIT', 0, '0',616452.0,788245.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(16, 'NJIT', 0, '0',616453.0,788245.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(17, 'NJIT', 0, '0',616445.0,788246.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(18, 'NJIT', 0, '0',616446.0,788246.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(19, 'NJIT', 0, '0',616447.0,788246.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(20, 'NJIT', 0, '0',616448.0,788246.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(21, 'NJIT', 0, '0',616449.0,788246.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(22, 'NJIT', 0, '0',616450.0,788246.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(23, 'NJIT', 0, '0',616451.0,788246.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(24, 'NJIT', 0, '0',616452.0,788246.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(25, 'NJIT', 0, '0',616453.0,788246.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(26, 'NJIT', 0, '0',616454.0,788246.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(27, 'NJIT', 0, '0',616455.0,788246.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(28, 'NJIT', 0, '0',616445.0,788247.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(29, 'NJIT', 0, '0',616446.0,788247.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(30, 'NJIT', 0, '0',616447.0,788247.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(31, 'NJIT', 0, '0',616448.0,788247.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(32, 'NJIT', 0, '0',616449.0,788247.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(33, 'NJIT', 0, '0',616450.0,788247.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(34, 'NJIT', 0, '0',616451.0,788247.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(35, 'NJIT', 0, '0',616452.0,788247.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(36, 'NJIT', 0, '0',616453.0,788247.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(37, 'NJIT', 0, '0',616454.0,788247.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(38, 'NJIT', 0, '0',616455.0,788247.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(39, 'NJIT', 0, '0',616456.0,788247.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(40, 'NJIT', 0, '0',616457.0,788247.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(41, 'NJIT', 0, '0',616445.0,788248.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(42, 'NJIT', 0, '0',616446.0,788248.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(43, 'NJIT', 0, '0',616447.0,788248.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(44, 'NJIT', 0, '0',616448.0,788248.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(45, 'NJIT', 0, '0',616449.0,788248.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(46, 'NJIT', 0, '0',616450.0,788248.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(47, 'NJIT', 0, '0',616451.0,788248.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(48, 'NJIT', 0, '0',616452.0,788248.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(49, 'NJIT', 0, '0',616453.0,788248.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(50, 'NJIT', 0, '0',616454.0,788248.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(51, 'NJIT', 0, '0',616455.0,788248.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(52, 'NJIT', 0, '0',616456.0,788248.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(53, 'NJIT', 0, '0',616457.0,788248.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(54, 'NJIT', 0, '0',616458.0,788248.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(55, 'NJIT', 0, '0',616459.0,788248.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(56, 'NJIT', 0, '0',616460.0,788248.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(57, 'NJIT', 0, '0',616444.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(58, 'NJIT', 0, '0',616445.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(59, 'NJIT', 0, '0',616446.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(60, 'NJIT', 0, '0',616447.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(61, 'NJIT', 0, '0',616448.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(62, 'NJIT', 0, '0',616449.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(63, 'NJIT', 0, '0',616450.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(64, 'NJIT', 0, '0',616451.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(65, 'NJIT', 0, '0',616452.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(66, 'NJIT', 0, '0',616453.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(67, 'NJIT', 0, '0',616454.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(68, 'NJIT', 0, '0',616455.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(69, 'NJIT', 0, '0',616456.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(70, 'NJIT', 0, '0',616457.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(71, 'NJIT', 0, '0',616458.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(72, 'NJIT', 0, '0',616459.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(73, 'NJIT', 0, '0',616460.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(74, 'NJIT', 0, '0',616461.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(75, 'NJIT', 0, '0',616462.0,788249.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(76, 'NJIT', 0, '0',616444.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(77, 'NJIT', 0, '0',616445.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(78, 'NJIT', 0, '0',616446.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(79, 'NJIT', 0, '0',616447.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(80, 'NJIT', 0, '0',616448.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(81, 'NJIT', 0, '0',616449.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(82, 'NJIT', 0, '0',616450.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(83, 'NJIT', 0, '0',616451.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(84, 'NJIT', 0, '0',616452.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(85, 'NJIT', 0, '0',616453.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(86, 'NJIT', 0, '0',616454.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(87, 'NJIT', 0, '0',616455.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(88, 'NJIT', 0, '0',616456.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(89, 'NJIT', 0, '0',616457.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(90, 'NJIT', 0, '0',616458.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(91, 'NJIT', 0, '0',616459.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(92, 'NJIT', 0, '0',616460.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(93, 'NJIT', 0, '0',616461.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(94, 'NJIT', 0, '0',616462.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(95, 'NJIT', 0, '0',616463.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(96, 'NJIT', 0, '0',616464.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(97, 'NJIT', 0, '0',616465.0,788250.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(98, 'NJIT', 0, '0',616443.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(99, 'NJIT', 0, '0',616444.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(100, 'NJIT', 0, '0',616445.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(101, 'NJIT', 0, '0',616446.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(102, 'NJIT', 0, '0',616447.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(103, 'NJIT', 0, '0',616448.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(104, 'NJIT', 0, '0',616449.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(105, 'NJIT', 0, '0',616450.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(106, 'NJIT', 0, '0',616451.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(107, 'NJIT', 0, '0',616452.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(108, 'NJIT', 0, '0',616453.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(109, 'NJIT', 0, '0',616454.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(110, 'NJIT', 0, '0',616455.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(111, 'NJIT', 0, '0',616456.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(112, 'NJIT', 0, '0',616457.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(113, 'NJIT', 0, '0',616458.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(114, 'NJIT', 0, '0',616459.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(115, 'NJIT', 0, '0',616460.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(116, 'NJIT', 0, '0',616461.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(117, 'NJIT', 0, '0',616462.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(118, 'NJIT', 0, '0',616463.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(119, 'NJIT', 0, '0',616464.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(120, 'NJIT', 0, '0',616465.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(121, 'NJIT', 0, '0',616466.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(122, 'NJIT', 0, '0',616467.0,788251.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(123, 'NJIT', 0, '0',616443.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(124, 'NJIT', 0, '0',616444.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(125, 'NJIT', 0, '0',616445.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(126, 'NJIT', 0, '0',616446.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(127, 'NJIT', 0, '0',616447.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(128, 'NJIT', 0, '0',616448.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(129, 'NJIT', 0, '0',616449.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(130, 'NJIT', 0, '0',616450.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(131, 'NJIT', 0, '0',616451.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(132, 'NJIT', 0, '0',616452.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(133, 'NJIT', 0, '0',616453.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(134, 'NJIT', 0, '0',616454.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(135, 'NJIT', 0, '0',616455.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(136, 'NJIT', 0, '0',616456.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(137, 'NJIT', 0, '0',616457.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(138, 'NJIT', 0, '0',616458.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(139, 'NJIT', 0, '0',616459.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(140, 'NJIT', 0, '0',616460.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(141, 'NJIT', 0, '0',616461.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(142, 'NJIT', 0, '0',616462.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(143, 'NJIT', 0, '0',616463.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(144, 'NJIT', 0, '0',616464.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(145, 'NJIT', 0, '0',616465.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(146, 'NJIT', 0, '0',616466.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(147, 'NJIT', 0, '0',616467.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(148, 'NJIT', 0, '0',616468.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(149, 'NJIT', 0, '0',616469.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(150, 'NJIT', 0, '0',616470.0,788252.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(151, 'NJIT', 0, '0',616443.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(152, 'NJIT', 0, '0',616444.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(153, 'NJIT', 0, '0',616445.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(154, 'NJIT', 0, '0',616446.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(155, 'NJIT', 0, '0',616447.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(156, 'NJIT', 0, '0',616448.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(157, 'NJIT', 0, '0',616449.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(158, 'NJIT', 0, '0',616450.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(159, 'NJIT', 0, '0',616451.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(160, 'NJIT', 0, '0',616452.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(161, 'NJIT', 0, '0',616453.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(162, 'NJIT', 0, '0',616454.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(163, 'NJIT', 0, '0',616455.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(164, 'NJIT', 0, '0',616456.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(165, 'NJIT', 0, '0',616457.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(166, 'NJIT', 0, '0',616458.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(167, 'NJIT', 0, '0',616459.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(168, 'NJIT', 0, '0',616460.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(169, 'NJIT', 0, '0',616461.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(170, 'NJIT', 0, '0',616462.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(171, 'NJIT', 0, '0',616463.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(172, 'NJIT', 0, '0',616464.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(173, 'NJIT', 0, '0',616465.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(174, 'NJIT', 0, '0',616466.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(175, 'NJIT', 0, '0',616467.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(176, 'NJIT', 0, '0',616468.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(177, 'NJIT', 0, '0',616469.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(178, 'NJIT', 0, '0',616470.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(179, 'NJIT', 0, '0',616471.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(180, 'NJIT', 0, '0',616472.0,788253.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(181, 'NJIT', 0, '0',616442.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(182, 'NJIT', 0, '0',616443.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(183, 'NJIT', 0, '0',616444.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(184, 'NJIT', 0, '0',616445.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(185, 'NJIT', 0, '0',616446.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(186, 'NJIT', 0, '0',616447.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(187, 'NJIT', 0, '0',616448.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(188, 'NJIT', 0, '0',616449.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(189, 'NJIT', 0, '0',616450.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(190, 'NJIT', 0, '0',616451.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(191, 'NJIT', 0, '0',616452.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(192, 'NJIT', 0, '0',616453.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(193, 'NJIT', 0, '0',616454.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(194, 'NJIT', 0, '0',616455.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(195, 'NJIT', 0, '0',616456.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(196, 'NJIT', 0, '0',616457.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(197, 'NJIT', 0, '0',616458.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(198, 'NJIT', 0, '0',616459.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(199, 'NJIT', 0, '0',616460.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(200, 'NJIT', 0, '0',616461.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(201, 'NJIT', 0, '0',616462.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(202, 'NJIT', 0, '0',616463.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(203, 'NJIT', 0, '0',616464.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(204, 'NJIT', 0, '0',616465.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(205, 'NJIT', 0, '0',616466.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(206, 'NJIT', 0, '0',616467.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(207, 'NJIT', 0, '0',616468.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(208, 'NJIT', 0, '0',616469.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(209, 'NJIT', 0, '0',616470.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(210, 'NJIT', 0, '0',616471.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(211, 'NJIT', 0, '0',616472.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(212, 'NJIT', 0, '0',616473.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(213, 'NJIT', 0, '0',616474.0,788254.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(214, 'NJIT', 0, '0',616442.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(215, 'NJIT', 0, '0',616443.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(216, 'NJIT', 0, '0',616444.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(217, 'NJIT', 0, '0',616445.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(218, 'NJIT', 0, '0',616446.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(219, 'NJIT', 0, '0',616447.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(220, 'NJIT', 0, '0',616448.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(221, 'NJIT', 0, '0',616449.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(222, 'NJIT', 0, '0',616450.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(223, 'NJIT', 0, '0',616451.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(224, 'NJIT', 0, '0',616452.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(225, 'NJIT', 0, '0',616453.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(226, 'NJIT', 0, '0',616454.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(227, 'NJIT', 0, '0',616455.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(228, 'NJIT', 0, '0',616456.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(229, 'NJIT', 0, '0',616457.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(230, 'NJIT', 0, '0',616458.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(231, 'NJIT', 0, '0',616459.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(232, 'NJIT', 0, '0',616460.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(233, 'NJIT', 0, '0',616461.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(234, 'NJIT', 0, '0',616462.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(235, 'NJIT', 0, '0',616463.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(236, 'NJIT', 0, '0',616464.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(237, 'NJIT', 0, '0',616465.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(238, 'NJIT', 0, '0',616466.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(239, 'NJIT', 0, '0',616467.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(240, 'NJIT', 0, '0',616468.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(241, 'NJIT', 0, '0',616469.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(242, 'NJIT', 0, '0',616470.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(243, 'NJIT', 0, '0',616471.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(244, 'NJIT', 0, '0',616472.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(245, 'NJIT', 0, '0',616473.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(246, 'NJIT', 0, '0',616474.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(247, 'NJIT', 0, '0',616475.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(248, 'NJIT', 0, '0',616476.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(249, 'NJIT', 0, '0',616477.0,788255.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(250, 'NJIT', 0, '0',616441.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(251, 'NJIT', 0, '0',616442.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(252, 'NJIT', 0, '0',616443.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(253, 'NJIT', 0, '0',616444.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(254, 'NJIT', 0, '0',616445.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(255, 'NJIT', 0, '0',616446.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(256, 'NJIT', 0, '0',616447.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(257, 'NJIT', 0, '0',616448.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(258, 'NJIT', 0, '0',616449.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(259, 'NJIT', 0, '0',616450.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(260, 'NJIT', 0, '0',616451.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(261, 'NJIT', 0, '0',616452.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(262, 'NJIT', 0, '0',616453.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(263, 'NJIT', 0, '0',616454.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(264, 'NJIT', 0, '0',616455.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(265, 'NJIT', 0, '0',616456.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(266, 'NJIT', 0, '0',616457.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(267, 'NJIT', 0, '0',616458.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(268, 'NJIT', 0, '0',616459.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(269, 'NJIT', 0, '0',616460.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(270, 'NJIT', 0, '0',616461.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(271, 'NJIT', 0, '0',616462.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(272, 'NJIT', 0, '0',616463.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(273, 'NJIT', 0, '0',616464.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(274, 'NJIT', 0, '0',616465.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(275, 'NJIT', 0, '0',616466.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(276, 'NJIT', 0, '0',616467.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(277, 'NJIT', 0, '0',616468.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(278, 'NJIT', 0, '0',616469.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(279, 'NJIT', 0, '0',616470.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(280, 'NJIT', 0, '0',616471.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(281, 'NJIT', 0, '0',616472.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(282, 'NJIT', 0, '0',616473.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(283, 'NJIT', 0, '0',616474.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(284, 'NJIT', 0, '0',616475.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(285, 'NJIT', 0, '0',616476.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(286, 'NJIT', 0, '0',616477.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(287, 'NJIT', 0, '0',616478.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(288, 'NJIT', 0, '0',616479.0,788256.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(289, 'NJIT', 0, '0',616441.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(290, 'NJIT', 0, '0',616442.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(291, 'NJIT', 0, '0',616443.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(292, 'NJIT', 0, '0',616444.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(293, 'NJIT', 0, '0',616445.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(294, 'NJIT', 0, '0',616446.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(295, 'NJIT', 0, '0',616447.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(296, 'NJIT', 0, '0',616448.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(297, 'NJIT', 0, '0',616449.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(298, 'NJIT', 0, '0',616450.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(299, 'NJIT', 0, '0',616451.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(300, 'NJIT', 0, '0',616452.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(301, 'NJIT', 0, '0',616453.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(302, 'NJIT', 0, '0',616454.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(303, 'NJIT', 0, '0',616455.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(304, 'NJIT', 0, '0',616456.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(305, 'NJIT', 0, '0',616457.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(306, 'NJIT', 0, '0',616458.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(307, 'NJIT', 0, '0',616459.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(308, 'NJIT', 0, '0',616460.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(309, 'NJIT', 0, '0',616461.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(310, 'NJIT', 0, '0',616462.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(311, 'NJIT', 0, '0',616463.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(312, 'NJIT', 0, '0',616464.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(313, 'NJIT', 0, '0',616465.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(314, 'NJIT', 0, '0',616466.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(315, 'NJIT', 0, '0',616467.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(316, 'NJIT', 0, '0',616468.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(317, 'NJIT', 0, '0',616469.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(318, 'NJIT', 0, '0',616470.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(319, 'NJIT', 0, '0',616471.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(320, 'NJIT', 0, '0',616472.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(321, 'NJIT', 0, '0',616473.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(322, 'NJIT', 0, '0',616474.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(323, 'NJIT', 0, '0',616475.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(324, 'NJIT', 0, '0',616476.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(325, 'NJIT', 0, '0',616477.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(326, 'NJIT', 0, '0',616478.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(327, 'NJIT', 0, '0',616479.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(328, 'NJIT', 0, '0',616480.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(329, 'NJIT', 0, '0',616481.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(330, 'NJIT', 0, '0',616482.0,788257.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(331, 'NJIT', 0, '0',616441.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(332, 'NJIT', 0, '0',616442.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(333, 'NJIT', 0, '0',616443.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(334, 'NJIT', 0, '0',616444.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(335, 'NJIT', 0, '0',616445.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(336, 'NJIT', 0, '0',616446.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(337, 'NJIT', 0, '0',616447.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(338, 'NJIT', 0, '0',616448.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(339, 'NJIT', 0, '0',616449.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(340, 'NJIT', 0, '0',616450.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(341, 'NJIT', 0, '0',616451.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(342, 'NJIT', 0, '0',616452.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(343, 'NJIT', 0, '0',616453.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(344, 'NJIT', 0, '0',616454.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(345, 'NJIT', 0, '0',616455.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(346, 'NJIT', 0, '0',616456.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(347, 'NJIT', 0, '0',616457.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(348, 'NJIT', 0, '0',616458.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(349, 'NJIT', 0, '0',616459.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(350, 'NJIT', 0, '0',616460.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(351, 'NJIT', 0, '0',616461.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(352, 'NJIT', 0, '0',616462.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(353, 'NJIT', 0, '0',616463.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(354, 'NJIT', 0, '0',616464.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(355, 'NJIT', 0, '0',616465.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(356, 'NJIT', 0, '0',616466.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(357, 'NJIT', 0, '0',616467.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(358, 'NJIT', 0, '0',616468.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(359, 'NJIT', 0, '0',616469.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(360, 'NJIT', 0, '0',616470.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(361, 'NJIT', 0, '0',616471.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(362, 'NJIT', 0, '0',616472.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(363, 'NJIT', 0, '0',616473.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(364, 'NJIT', 0, '0',616474.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(365, 'NJIT', 0, '0',616475.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(366, 'NJIT', 0, '0',616476.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(367, 'NJIT', 0, '0',616477.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(368, 'NJIT', 0, '0',616478.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(369, 'NJIT', 0, '0',616479.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(370, 'NJIT', 0, '0',616480.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(371, 'NJIT', 0, '0',616481.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(372, 'NJIT', 0, '0',616482.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(373, 'NJIT', 0, '0',616483.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(374, 'NJIT', 0, '0',616484.0,788258.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(375, 'NJIT', 0, '0',616440.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(376, 'NJIT', 0, '0',616441.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(377, 'NJIT', 0, '0',616442.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(378, 'NJIT', 0, '0',616443.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(379, 'NJIT', 0, '0',616444.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(380, 'NJIT', 0, '0',616445.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(381, 'NJIT', 0, '0',616446.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(382, 'NJIT', 0, '0',616447.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(383, 'NJIT', 0, '0',616448.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(384, 'NJIT', 0, '0',616449.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(385, 'NJIT', 0, '0',616450.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(386, 'NJIT', 0, '0',616451.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(387, 'NJIT', 0, '0',616452.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(388, 'NJIT', 0, '0',616453.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(389, 'NJIT', 0, '0',616454.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(390, 'NJIT', 0, '0',616455.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(391, 'NJIT', 0, '0',616456.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(392, 'NJIT', 0, '0',616457.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(393, 'NJIT', 0, '0',616458.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(394, 'NJIT', 0, '0',616459.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(395, 'NJIT', 0, '0',616460.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(396, 'NJIT', 0, '0',616461.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(397, 'NJIT', 0, '0',616462.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(398, 'NJIT', 0, '0',616463.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(399, 'NJIT', 0, '0',616464.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(400, 'NJIT', 0, '0',616465.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(401, 'NJIT', 0, '0',616466.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(402, 'NJIT', 0, '0',616467.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(403, 'NJIT', 0, '0',616468.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(404, 'NJIT', 0, '0',616469.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(405, 'NJIT', 0, '0',616470.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(406, 'NJIT', 0, '0',616471.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(407, 'NJIT', 0, '0',616472.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(408, 'NJIT', 0, '0',616473.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(409, 'NJIT', 0, '0',616474.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(410, 'NJIT', 0, '0',616475.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(411, 'NJIT', 0, '0',616476.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(412, 'NJIT', 0, '0',616477.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(413, 'NJIT', 0, '0',616478.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(414, 'NJIT', 0, '0',616479.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(415, 'NJIT', 0, '0',616480.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(416, 'NJIT', 0, '0',616481.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(417, 'NJIT', 0, '0',616482.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(418, 'NJIT', 0, '0',616483.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(419, 'NJIT', 0, '0',616484.0,788259.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(420, 'NJIT', 0, '0',616440.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(421, 'NJIT', 0, '0',616441.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(422, 'NJIT', 0, '0',616442.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(423, 'NJIT', 0, '0',616443.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(424, 'NJIT', 0, '0',616444.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(425, 'NJIT', 0, '0',616445.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(426, 'NJIT', 0, '0',616446.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(427, 'NJIT', 0, '0',616447.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(428, 'NJIT', 0, '0',616448.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(429, 'NJIT', 0, '0',616449.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(430, 'NJIT', 0, '0',616450.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(431, 'NJIT', 0, '0',616451.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(432, 'NJIT', 0, '0',616452.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(433, 'NJIT', 0, '0',616453.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(434, 'NJIT', 0, '0',616454.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(435, 'NJIT', 0, '0',616455.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(436, 'NJIT', 0, '0',616456.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(437, 'NJIT', 0, '0',616457.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(438, 'NJIT', 0, '0',616458.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(439, 'NJIT', 0, '0',616459.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(440, 'NJIT', 0, '0',616460.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(441, 'NJIT', 0, '0',616461.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(442, 'NJIT', 0, '0',616462.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(443, 'NJIT', 0, '0',616463.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(444, 'NJIT', 0, '0',616464.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(445, 'NJIT', 0, '0',616465.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(446, 'NJIT', 0, '0',616466.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(447, 'NJIT', 0, '0',616467.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(448, 'NJIT', 0, '0',616468.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(449, 'NJIT', 0, '0',616469.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(450, 'NJIT', 0, '0',616470.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(451, 'NJIT', 0, '0',616471.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(452, 'NJIT', 0, '0',616472.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(453, 'NJIT', 0, '0',616473.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(454, 'NJIT', 0, '0',616474.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(455, 'NJIT', 0, '0',616475.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(456, 'NJIT', 0, '0',616476.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(457, 'NJIT', 0, '0',616477.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(458, 'NJIT', 0, '0',616478.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(459, 'NJIT', 0, '0',616479.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(460, 'NJIT', 0, '0',616480.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(461, 'NJIT', 0, '0',616481.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(462, 'NJIT', 0, '0',616482.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(463, 'NJIT', 0, '0',616483.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(464, 'NJIT', 0, '0',616484.0,788260.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(465, 'NJIT', 0, '0',616440.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(466, 'NJIT', 0, '0',616441.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(467, 'NJIT', 0, '0',616442.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(468, 'NJIT', 0, '0',616443.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(469, 'NJIT', 0, '0',616444.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(470, 'NJIT', 0, '0',616445.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(471, 'NJIT', 0, '0',616446.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(472, 'NJIT', 0, '0',616447.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(473, 'NJIT', 0, '0',616448.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(474, 'NJIT', 0, '0',616449.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(475, 'NJIT', 0, '0',616450.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(476, 'NJIT', 0, '0',616451.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(477, 'NJIT', 0, '0',616452.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(478, 'NJIT', 0, '0',616453.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(479, 'NJIT', 0, '0',616454.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(480, 'NJIT', 0, '0',616455.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(481, 'NJIT', 0, '0',616456.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(482, 'NJIT', 0, '0',616457.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(483, 'NJIT', 0, '0',616458.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(484, 'NJIT', 0, '0',616459.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(485, 'NJIT', 0, '0',616460.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(486, 'NJIT', 0, '0',616461.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(487, 'NJIT', 0, '0',616462.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(488, 'NJIT', 0, '0',616463.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(489, 'NJIT', 0, '0',616464.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(490, 'NJIT', 0, '0',616465.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(491, 'NJIT', 0, '0',616466.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(492, 'NJIT', 0, '0',616467.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(493, 'NJIT', 0, '0',616468.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(494, 'NJIT', 0, '0',616469.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(495, 'NJIT', 0, '0',616470.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(496, 'NJIT', 0, '0',616471.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(497, 'NJIT', 0, '0',616472.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(498, 'NJIT', 0, '0',616473.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(499, 'NJIT', 0, '0',616474.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(500, 'NJIT', 0, '0',616475.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(501, 'NJIT', 0, '0',616476.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(502, 'NJIT', 0, '0',616477.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(503, 'NJIT', 0, '0',616478.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(504, 'NJIT', 0, '0',616479.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(505, 'NJIT', 0, '0',616480.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(506, 'NJIT', 0, '0',616481.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(507, 'NJIT', 0, '0',616482.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(508, 'NJIT', 0, '0',616483.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(509, 'NJIT', 0, '0',616484.0,788261.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(510, 'NJIT', 0, '0',616439.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(511, 'NJIT', 0, '0',616440.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(512, 'NJIT', 0, '0',616441.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(513, 'NJIT', 0, '0',616442.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(514, 'NJIT', 0, '0',616443.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(515, 'NJIT', 0, '0',616444.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(516, 'NJIT', 0, '0',616445.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(517, 'NJIT', 0, '0',616446.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(518, 'NJIT', 0, '0',616447.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(519, 'NJIT', 0, '0',616448.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(520, 'NJIT', 0, '0',616449.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(521, 'NJIT', 0, '0',616450.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(522, 'NJIT', 0, '0',616451.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(523, 'NJIT', 0, '0',616452.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(524, 'NJIT', 0, '0',616453.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(525, 'NJIT', 0, '0',616454.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(526, 'NJIT', 0, '0',616455.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(527, 'NJIT', 0, '0',616456.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(528, 'NJIT', 0, '0',616457.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(529, 'NJIT', 0, '0',616458.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(530, 'NJIT', 0, '0',616459.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(531, 'NJIT', 0, '0',616460.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(532, 'NJIT', 0, '0',616461.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(533, 'NJIT', 0, '0',616462.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(534, 'NJIT', 0, '0',616463.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(535, 'NJIT', 0, '0',616464.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(536, 'NJIT', 0, '0',616465.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(537, 'NJIT', 0, '0',616466.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(538, 'NJIT', 0, '0',616467.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(539, 'NJIT', 0, '0',616468.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(540, 'NJIT', 0, '0',616469.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(541, 'NJIT', 0, '0',616470.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(542, 'NJIT', 0, '0',616471.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(543, 'NJIT', 0, '0',616472.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(544, 'NJIT', 0, '0',616473.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(545, 'NJIT', 0, '0',616474.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(546, 'NJIT', 0, '0',616475.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(547, 'NJIT', 0, '0',616476.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(548, 'NJIT', 0, '0',616477.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(549, 'NJIT', 0, '0',616478.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(550, 'NJIT', 0, '0',616479.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(551, 'NJIT', 0, '0',616480.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(552, 'NJIT', 0, '0',616481.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(553, 'NJIT', 0, '0',616482.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(554, 'NJIT', 0, '0',616483.0,788262.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(555, 'NJIT', 0, '0',616439.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(556, 'NJIT', 0, '0',616440.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(557, 'NJIT', 0, '0',616441.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(558, 'NJIT', 0, '0',616442.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(559, 'NJIT', 0, '0',616443.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(560, 'NJIT', 0, '0',616444.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(561, 'NJIT', 0, '0',616445.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(562, 'NJIT', 0, '0',616446.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(563, 'NJIT', 0, '0',616447.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(564, 'NJIT', 0, '0',616448.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(565, 'NJIT', 0, '0',616449.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(566, 'NJIT', 0, '0',616450.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(567, 'NJIT', 0, '0',616451.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(568, 'NJIT', 0, '0',616452.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(569, 'NJIT', 0, '0',616453.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(570, 'NJIT', 0, '0',616454.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(571, 'NJIT', 0, '0',616455.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(572, 'NJIT', 0, '0',616456.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(573, 'NJIT', 0, '0',616457.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(574, 'NJIT', 0, '0',616458.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(575, 'NJIT', 0, '0',616459.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(576, 'NJIT', 0, '0',616460.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(577, 'NJIT', 0, '0',616461.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(578, 'NJIT', 0, '0',616462.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(579, 'NJIT', 0, '0',616463.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(580, 'NJIT', 0, '0',616464.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(581, 'NJIT', 0, '0',616465.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(582, 'NJIT', 0, '0',616466.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(583, 'NJIT', 0, '0',616467.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(584, 'NJIT', 0, '0',616468.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(585, 'NJIT', 0, '0',616469.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(586, 'NJIT', 0, '0',616470.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(587, 'NJIT', 0, '0',616471.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(588, 'NJIT', 0, '0',616472.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(589, 'NJIT', 0, '0',616473.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(590, 'NJIT', 0, '0',616474.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(591, 'NJIT', 0, '0',616475.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(592, 'NJIT', 0, '0',616476.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(593, 'NJIT', 0, '0',616477.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(594, 'NJIT', 0, '0',616478.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(595, 'NJIT', 0, '0',616479.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(596, 'NJIT', 0, '0',616480.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(597, 'NJIT', 0, '0',616481.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(598, 'NJIT', 0, '0',616482.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(599, 'NJIT', 0, '0',616483.0,788263.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(600, 'NJIT', 0, '0',616438.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(601, 'NJIT', 0, '0',616439.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(602, 'NJIT', 0, '0',616440.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(603, 'NJIT', 0, '0',616441.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(604, 'NJIT', 0, '0',616442.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(605, 'NJIT', 0, '0',616443.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(606, 'NJIT', 0, '0',616444.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(607, 'NJIT', 0, '0',616445.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(608, 'NJIT', 0, '0',616446.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(609, 'NJIT', 0, '0',616447.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(610, 'NJIT', 0, '0',616448.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(611, 'NJIT', 0, '0',616449.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(612, 'NJIT', 0, '0',616450.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(613, 'NJIT', 0, '0',616451.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(614, 'NJIT', 0, '0',616452.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(615, 'NJIT', 0, '0',616453.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(616, 'NJIT', 0, '0',616454.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(617, 'NJIT', 0, '0',616455.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(618, 'NJIT', 0, '0',616456.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(619, 'NJIT', 0, '0',616457.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(620, 'NJIT', 0, '0',616458.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(621, 'NJIT', 0, '0',616459.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(622, 'NJIT', 0, '0',616460.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(623, 'NJIT', 0, '0',616461.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(624, 'NJIT', 0, '0',616462.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(625, 'NJIT', 0, '0',616463.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(626, 'NJIT', 0, '0',616464.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(627, 'NJIT', 0, '0',616465.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(628, 'NJIT', 0, '0',616466.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(629, 'NJIT', 0, '0',616467.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(630, 'NJIT', 0, '0',616468.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(631, 'NJIT', 0, '0',616469.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(632, 'NJIT', 0, '0',616470.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(633, 'NJIT', 0, '0',616471.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(634, 'NJIT', 0, '0',616472.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(635, 'NJIT', 0, '0',616473.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(636, 'NJIT', 0, '0',616474.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(637, 'NJIT', 0, '0',616475.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(638, 'NJIT', 0, '0',616476.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(639, 'NJIT', 0, '0',616477.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(640, 'NJIT', 0, '0',616478.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(641, 'NJIT', 0, '0',616479.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(642, 'NJIT', 0, '0',616480.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(643, 'NJIT', 0, '0',616481.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(644, 'NJIT', 0, '0',616482.0,788264.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(645, 'NJIT', 0, '0',616438.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(646, 'NJIT', 0, '0',616439.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(647, 'NJIT', 0, '0',616440.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(648, 'NJIT', 0, '0',616441.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(649, 'NJIT', 0, '0',616442.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(650, 'NJIT', 0, '0',616443.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(651, 'NJIT', 0, '0',616444.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(652, 'NJIT', 0, '0',616445.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(653, 'NJIT', 0, '0',616446.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(654, 'NJIT', 0, '0',616447.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(655, 'NJIT', 0, '0',616448.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(656, 'NJIT', 0, '0',616449.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(657, 'NJIT', 0, '0',616450.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(658, 'NJIT', 0, '0',616451.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(659, 'NJIT', 0, '0',616452.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(660, 'NJIT', 0, '0',616453.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(661, 'NJIT', 0, '0',616454.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(662, 'NJIT', 0, '0',616455.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(663, 'NJIT', 0, '0',616456.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(664, 'NJIT', 0, '0',616457.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(665, 'NJIT', 0, '0',616458.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(666, 'NJIT', 0, '0',616459.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(667, 'NJIT', 0, '0',616460.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(668, 'NJIT', 0, '0',616461.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(669, 'NJIT', 0, '0',616462.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(670, 'NJIT', 0, '0',616463.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(671, 'NJIT', 0, '0',616464.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(672, 'NJIT', 0, '0',616465.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(673, 'NJIT', 0, '0',616466.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(674, 'NJIT', 0, '0',616467.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(675, 'NJIT', 0, '0',616468.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(676, 'NJIT', 0, '0',616469.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(677, 'NJIT', 0, '0',616470.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(678, 'NJIT', 0, '0',616471.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(679, 'NJIT', 0, '0',616472.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(680, 'NJIT', 0, '0',616473.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(681, 'NJIT', 0, '0',616474.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(682, 'NJIT', 0, '0',616475.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(683, 'NJIT', 0, '0',616476.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(684, 'NJIT', 0, '0',616477.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(685, 'NJIT', 0, '0',616478.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(686, 'NJIT', 0, '0',616479.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(687, 'NJIT', 0, '0',616480.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(688, 'NJIT', 0, '0',616481.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(689, 'NJIT', 0, '0',616482.0,788265.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(690, 'NJIT', 0, '0',616438.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(691, 'NJIT', 0, '0',616439.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(692, 'NJIT', 0, '0',616440.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(693, 'NJIT', 0, '0',616441.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(694, 'NJIT', 0, '0',616442.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(695, 'NJIT', 0, '0',616443.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(696, 'NJIT', 0, '0',616444.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(697, 'NJIT', 0, '0',616445.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(698, 'NJIT', 0, '0',616446.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(699, 'NJIT', 0, '0',616447.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(700, 'NJIT', 0, '0',616448.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(701, 'NJIT', 0, '0',616449.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(702, 'NJIT', 0, '0',616450.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(703, 'NJIT', 0, '0',616451.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(704, 'NJIT', 0, '0',616452.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(705, 'NJIT', 0, '0',616453.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(706, 'NJIT', 0, '0',616454.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(707, 'NJIT', 0, '0',616455.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(708, 'NJIT', 0, '0',616456.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(709, 'NJIT', 0, '0',616457.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(710, 'NJIT', 0, '0',616458.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(711, 'NJIT', 0, '0',616459.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(712, 'NJIT', 0, '0',616460.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(713, 'NJIT', 0, '0',616461.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(714, 'NJIT', 0, '0',616462.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(715, 'NJIT', 0, '0',616463.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(716, 'NJIT', 0, '0',616464.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(717, 'NJIT', 0, '0',616465.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(718, 'NJIT', 0, '0',616466.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(719, 'NJIT', 0, '0',616467.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(720, 'NJIT', 0, '0',616468.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(721, 'NJIT', 0, '0',616469.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(722, 'NJIT', 0, '0',616470.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(723, 'NJIT', 0, '0',616471.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(724, 'NJIT', 0, '0',616472.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(725, 'NJIT', 0, '0',616473.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(726, 'NJIT', 0, '0',616474.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(727, 'NJIT', 0, '0',616475.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(728, 'NJIT', 0, '0',616476.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(729, 'NJIT', 0, '0',616477.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(730, 'NJIT', 0, '0',616478.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(731, 'NJIT', 0, '0',616479.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(732, 'NJIT', 0, '0',616480.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(733, 'NJIT', 0, '0',616481.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(734, 'NJIT', 0, '0',616482.0,788266.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(735, 'NJIT', 0, '0',616437.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(736, 'NJIT', 0, '0',616438.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(737, 'NJIT', 0, '0',616439.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(738, 'NJIT', 0, '0',616440.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(739, 'NJIT', 0, '0',616441.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(740, 'NJIT', 0, '0',616442.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(741, 'NJIT', 0, '0',616443.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(742, 'NJIT', 0, '0',616444.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(743, 'NJIT', 0, '0',616445.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(744, 'NJIT', 0, '0',616446.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(745, 'NJIT', 0, '0',616447.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(746, 'NJIT', 0, '0',616448.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(747, 'NJIT', 0, '0',616449.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(748, 'NJIT', 0, '0',616450.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(749, 'NJIT', 0, '0',616451.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(750, 'NJIT', 0, '0',616452.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(751, 'NJIT', 0, '0',616453.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(752, 'NJIT', 0, '0',616454.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(753, 'NJIT', 0, '0',616455.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(754, 'NJIT', 0, '0',616456.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(755, 'NJIT', 0, '0',616457.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(756, 'NJIT', 0, '0',616458.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(757, 'NJIT', 0, '0',616459.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(758, 'NJIT', 0, '0',616460.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(759, 'NJIT', 0, '0',616461.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(760, 'NJIT', 0, '0',616462.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(761, 'NJIT', 0, '0',616463.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(762, 'NJIT', 0, '0',616464.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(763, 'NJIT', 0, '0',616465.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(764, 'NJIT', 0, '0',616466.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(765, 'NJIT', 0, '0',616467.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(766, 'NJIT', 0, '0',616468.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(767, 'NJIT', 0, '0',616469.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(768, 'NJIT', 0, '0',616470.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(769, 'NJIT', 0, '0',616471.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(770, 'NJIT', 0, '0',616472.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(771, 'NJIT', 0, '0',616473.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(772, 'NJIT', 0, '0',616474.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(773, 'NJIT', 0, '0',616475.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(774, 'NJIT', 0, '0',616476.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(775, 'NJIT', 0, '0',616477.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(776, 'NJIT', 0, '0',616478.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(777, 'NJIT', 0, '0',616479.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(778, 'NJIT', 0, '0',616480.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(779, 'NJIT', 0, '0',616481.0,788267.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(780, 'NJIT', 0, '0',616437.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(781, 'NJIT', 0, '0',616438.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(782, 'NJIT', 0, '0',616439.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(783, 'NJIT', 0, '0',616440.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(784, 'NJIT', 0, '0',616441.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(785, 'NJIT', 0, '0',616442.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(786, 'NJIT', 0, '0',616443.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(787, 'NJIT', 0, '0',616444.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(788, 'NJIT', 0, '0',616445.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(789, 'NJIT', 0, '0',616446.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(790, 'NJIT', 0, '0',616447.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(791, 'NJIT', 0, '0',616448.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(792, 'NJIT', 0, '0',616449.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(793, 'NJIT', 0, '0',616450.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(794, 'NJIT', 0, '0',616451.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(795, 'NJIT', 0, '0',616452.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(796, 'NJIT', 0, '0',616453.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(797, 'NJIT', 0, '0',616454.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(798, 'NJIT', 0, '0',616455.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(799, 'NJIT', 0, '0',616456.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(800, 'NJIT', 0, '0',616457.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(801, 'NJIT', 0, '0',616458.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(802, 'NJIT', 0, '0',616459.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(803, 'NJIT', 0, '0',616460.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(804, 'NJIT', 0, '0',616461.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(805, 'NJIT', 0, '0',616462.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(806, 'NJIT', 0, '0',616463.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(807, 'NJIT', 0, '0',616464.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(808, 'NJIT', 0, '0',616465.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(809, 'NJIT', 0, '0',616466.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(810, 'NJIT', 0, '0',616467.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(811, 'NJIT', 0, '0',616468.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(812, 'NJIT', 0, '0',616469.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(813, 'NJIT', 0, '0',616470.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(814, 'NJIT', 0, '0',616471.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(815, 'NJIT', 0, '0',616472.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(816, 'NJIT', 0, '0',616473.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(817, 'NJIT', 0, '0',616474.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(818, 'NJIT', 0, '0',616475.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(819, 'NJIT', 0, '0',616476.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(820, 'NJIT', 0, '0',616477.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(821, 'NJIT', 0, '0',616478.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(822, 'NJIT', 0, '0',616479.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(823, 'NJIT', 0, '0',616480.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(824, 'NJIT', 0, '0',616481.0,788268.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(825, 'NJIT', 0, '0',616436.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(826, 'NJIT', 0, '0',616437.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(827, 'NJIT', 0, '0',616438.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(828, 'NJIT', 0, '0',616439.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(829, 'NJIT', 0, '0',616440.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(830, 'NJIT', 0, '0',616441.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(831, 'NJIT', 0, '0',616442.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(832, 'NJIT', 0, '0',616443.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(833, 'NJIT', 0, '0',616444.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(834, 'NJIT', 0, '0',616445.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(835, 'NJIT', 0, '0',616446.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(836, 'NJIT', 0, '0',616447.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(837, 'NJIT', 0, '0',616448.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(838, 'NJIT', 0, '0',616449.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(839, 'NJIT', 0, '0',616450.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(840, 'NJIT', 0, '0',616451.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(841, 'NJIT', 0, '0',616452.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(842, 'NJIT', 0, '0',616453.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(843, 'NJIT', 0, '0',616454.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(844, 'NJIT', 0, '0',616455.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(845, 'NJIT', 0, '0',616456.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(846, 'NJIT', 0, '0',616457.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(847, 'NJIT', 0, '0',616458.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(848, 'NJIT', 0, '0',616459.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(849, 'NJIT', 0, '0',616460.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(850, 'NJIT', 0, '0',616461.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(851, 'NJIT', 0, '0',616462.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(852, 'NJIT', 0, '0',616463.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(853, 'NJIT', 0, '0',616464.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(854, 'NJIT', 0, '0',616465.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(855, 'NJIT', 0, '0',616466.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(856, 'NJIT', 0, '0',616467.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(857, 'NJIT', 0, '0',616468.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(858, 'NJIT', 0, '0',616469.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(859, 'NJIT', 0, '0',616470.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(860, 'NJIT', 0, '0',616471.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(861, 'NJIT', 0, '0',616472.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(862, 'NJIT', 0, '0',616473.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(863, 'NJIT', 0, '0',616474.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(864, 'NJIT', 0, '0',616475.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(865, 'NJIT', 0, '0',616476.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(866, 'NJIT', 0, '0',616477.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(867, 'NJIT', 0, '0',616478.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(868, 'NJIT', 0, '0',616479.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(869, 'NJIT', 0, '0',616480.0,788269.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(870, 'NJIT', 0, '0',616436.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(871, 'NJIT', 0, '0',616437.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(872, 'NJIT', 0, '0',616438.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(873, 'NJIT', 0, '0',616439.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(874, 'NJIT', 0, '0',616440.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(875, 'NJIT', 0, '0',616441.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(876, 'NJIT', 0, '0',616442.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(877, 'NJIT', 0, '0',616443.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(878, 'NJIT', 0, '0',616444.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(879, 'NJIT', 0, '0',616445.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(880, 'NJIT', 0, '0',616446.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(881, 'NJIT', 0, '0',616447.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(882, 'NJIT', 0, '0',616448.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(883, 'NJIT', 0, '0',616449.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(884, 'NJIT', 0, '0',616450.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(885, 'NJIT', 0, '0',616451.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(886, 'NJIT', 0, '0',616452.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(887, 'NJIT', 0, '0',616453.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(888, 'NJIT', 0, '0',616454.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(889, 'NJIT', 0, '0',616455.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(890, 'NJIT', 0, '0',616456.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(891, 'NJIT', 0, '0',616457.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(892, 'NJIT', 0, '0',616458.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(893, 'NJIT', 0, '0',616459.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(894, 'NJIT', 0, '0',616460.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(895, 'NJIT', 0, '0',616461.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(896, 'NJIT', 0, '0',616462.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(897, 'NJIT', 0, '0',616463.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(898, 'NJIT', 0, '0',616464.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(899, 'NJIT', 0, '0',616465.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(900, 'NJIT', 0, '0',616466.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(901, 'NJIT', 0, '0',616467.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(902, 'NJIT', 0, '0',616468.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(903, 'NJIT', 0, '0',616469.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(904, 'NJIT', 0, '0',616470.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(905, 'NJIT', 0, '0',616471.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(906, 'NJIT', 0, '0',616472.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(907, 'NJIT', 0, '0',616473.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(908, 'NJIT', 0, '0',616474.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(909, 'NJIT', 0, '0',616475.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(910, 'NJIT', 0, '0',616476.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(911, 'NJIT', 0, '0',616477.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(912, 'NJIT', 0, '0',616478.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(913, 'NJIT', 0, '0',616479.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(914, 'NJIT', 0, '0',616480.0,788270.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(915, 'NJIT', 0, '0',616436.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(916, 'NJIT', 0, '0',616437.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(917, 'NJIT', 0, '0',616438.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(918, 'NJIT', 0, '0',616439.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(919, 'NJIT', 0, '0',616440.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(920, 'NJIT', 0, '0',616441.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(921, 'NJIT', 0, '0',616442.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(922, 'NJIT', 0, '0',616443.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(923, 'NJIT', 0, '0',616444.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(924, 'NJIT', 0, '0',616445.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(925, 'NJIT', 0, '0',616446.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(926, 'NJIT', 0, '0',616447.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(927, 'NJIT', 0, '0',616448.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(928, 'NJIT', 0, '0',616449.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(929, 'NJIT', 0, '0',616450.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(930, 'NJIT', 0, '0',616451.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(931, 'NJIT', 0, '0',616452.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(932, 'NJIT', 0, '0',616453.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(933, 'NJIT', 0, '0',616454.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(934, 'NJIT', 0, '0',616455.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(935, 'NJIT', 0, '0',616456.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(936, 'NJIT', 0, '0',616457.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(937, 'NJIT', 0, '0',616458.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(938, 'NJIT', 0, '0',616459.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(939, 'NJIT', 0, '0',616460.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(940, 'NJIT', 0, '0',616461.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(941, 'NJIT', 0, '0',616462.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(942, 'NJIT', 0, '0',616463.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(943, 'NJIT', 0, '0',616464.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(944, 'NJIT', 0, '0',616465.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(945, 'NJIT', 0, '0',616466.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(946, 'NJIT', 0, '0',616467.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(947, 'NJIT', 0, '0',616468.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(948, 'NJIT', 0, '0',616469.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(949, 'NJIT', 0, '0',616470.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(950, 'NJIT', 0, '0',616471.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(951, 'NJIT', 0, '0',616472.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(952, 'NJIT', 0, '0',616473.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(953, 'NJIT', 0, '0',616474.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(954, 'NJIT', 0, '0',616475.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(955, 'NJIT', 0, '0',616476.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(956, 'NJIT', 0, '0',616477.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(957, 'NJIT', 0, '0',616478.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(958, 'NJIT', 0, '0',616479.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(959, 'NJIT', 0, '0',616480.0,788271.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(960, 'NJIT', 0, '0',616435.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(961, 'NJIT', 0, '0',616436.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(962, 'NJIT', 0, '0',616437.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(963, 'NJIT', 0, '0',616438.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(964, 'NJIT', 0, '0',616439.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(965, 'NJIT', 0, '0',616440.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(966, 'NJIT', 0, '0',616441.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(967, 'NJIT', 0, '0',616442.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(968, 'NJIT', 0, '0',616443.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(969, 'NJIT', 0, '0',616444.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(970, 'NJIT', 0, '0',616445.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(971, 'NJIT', 0, '0',616446.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(972, 'NJIT', 0, '0',616447.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(973, 'NJIT', 0, '0',616448.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(974, 'NJIT', 0, '0',616449.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(975, 'NJIT', 0, '0',616450.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(976, 'NJIT', 0, '0',616451.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(977, 'NJIT', 0, '0',616452.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(978, 'NJIT', 0, '0',616453.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(979, 'NJIT', 0, '0',616454.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(980, 'NJIT', 0, '0',616455.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(981, 'NJIT', 0, '0',616456.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(982, 'NJIT', 0, '0',616457.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(983, 'NJIT', 0, '0',616458.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(984, 'NJIT', 0, '0',616459.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(985, 'NJIT', 0, '0',616460.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(986, 'NJIT', 0, '0',616461.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(987, 'NJIT', 0, '0',616462.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(988, 'NJIT', 0, '0',616463.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(989, 'NJIT', 0, '0',616464.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(990, 'NJIT', 0, '0',616465.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(991, 'NJIT', 0, '0',616466.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(992, 'NJIT', 0, '0',616467.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(993, 'NJIT', 0, '0',616468.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(994, 'NJIT', 0, '0',616469.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(995, 'NJIT', 0, '0',616470.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(996, 'NJIT', 0, '0',616471.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(997, 'NJIT', 0, '0',616472.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(998, 'NJIT', 0, '0',616473.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(999, 'NJIT', 0, '0',616474.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1000, 'NJIT', 0, '0',616475.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1001, 'NJIT', 0, '0',616476.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1002, 'NJIT', 0, '0',616477.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1003, 'NJIT', 0, '0',616478.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1004, 'NJIT', 0, '0',616479.0,788272.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1005, 'NJIT', 0, '0',616435.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1006, 'NJIT', 0, '0',616436.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1007, 'NJIT', 0, '0',616437.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1008, 'NJIT', 0, '0',616438.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1009, 'NJIT', 0, '0',616439.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1010, 'NJIT', 0, '0',616440.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1011, 'NJIT', 0, '0',616441.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1012, 'NJIT', 0, '0',616442.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1013, 'NJIT', 0, '0',616443.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1014, 'NJIT', 0, '0',616444.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1015, 'NJIT', 0, '0',616445.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1016, 'NJIT', 0, '0',616446.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1017, 'NJIT', 0, '0',616447.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1018, 'NJIT', 0, '0',616448.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1019, 'NJIT', 0, '0',616449.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1020, 'NJIT', 0, '0',616450.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1021, 'NJIT', 0, '0',616451.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1022, 'NJIT', 0, '0',616452.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1023, 'NJIT', 0, '0',616453.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1024, 'NJIT', 0, '0',616454.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1025, 'NJIT', 0, '0',616455.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1026, 'NJIT', 0, '0',616456.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1027, 'NJIT', 0, '0',616457.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1028, 'NJIT', 0, '0',616458.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1029, 'NJIT', 0, '0',616459.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1030, 'NJIT', 0, '0',616460.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1031, 'NJIT', 0, '0',616461.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1032, 'NJIT', 0, '0',616462.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1033, 'NJIT', 0, '0',616463.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1034, 'NJIT', 0, '0',616464.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1035, 'NJIT', 0, '0',616465.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1036, 'NJIT', 0, '0',616466.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1037, 'NJIT', 0, '0',616467.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1038, 'NJIT', 0, '0',616468.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1039, 'NJIT', 0, '0',616469.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1040, 'NJIT', 0, '0',616470.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1041, 'NJIT', 0, '0',616471.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1042, 'NJIT', 0, '0',616472.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1043, 'NJIT', 0, '0',616473.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1044, 'NJIT', 0, '0',616474.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1045, 'NJIT', 0, '0',616475.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1046, 'NJIT', 0, '0',616476.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1047, 'NJIT', 0, '0',616477.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1048, 'NJIT', 0, '0',616478.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1049, 'NJIT', 0, '0',616479.0,788273.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1050, 'NJIT', 0, '0',616437.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1051, 'NJIT', 0, '0',616438.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1052, 'NJIT', 0, '0',616439.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1053, 'NJIT', 0, '0',616440.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1054, 'NJIT', 0, '0',616441.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1055, 'NJIT', 0, '0',616442.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1056, 'NJIT', 0, '0',616443.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1057, 'NJIT', 0, '0',616444.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1058, 'NJIT', 0, '0',616445.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1059, 'NJIT', 0, '0',616446.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1060, 'NJIT', 0, '0',616447.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1061, 'NJIT', 0, '0',616448.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1062, 'NJIT', 0, '0',616449.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1063, 'NJIT', 0, '0',616450.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1064, 'NJIT', 0, '0',616451.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1065, 'NJIT', 0, '0',616452.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1066, 'NJIT', 0, '0',616453.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1067, 'NJIT', 0, '0',616454.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1068, 'NJIT', 0, '0',616455.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1069, 'NJIT', 0, '0',616456.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1070, 'NJIT', 0, '0',616457.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1071, 'NJIT', 0, '0',616458.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1072, 'NJIT', 0, '0',616459.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1073, 'NJIT', 0, '0',616460.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1074, 'NJIT', 0, '0',616461.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1075, 'NJIT', 0, '0',616462.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1076, 'NJIT', 0, '0',616463.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1077, 'NJIT', 0, '0',616464.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1078, 'NJIT', 0, '0',616465.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1079, 'NJIT', 0, '0',616466.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1080, 'NJIT', 0, '0',616467.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1081, 'NJIT', 0, '0',616468.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1082, 'NJIT', 0, '0',616469.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1083, 'NJIT', 0, '0',616470.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1084, 'NJIT', 0, '0',616471.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1085, 'NJIT', 0, '0',616472.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1086, 'NJIT', 0, '0',616473.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1087, 'NJIT', 0, '0',616474.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1088, 'NJIT', 0, '0',616475.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1089, 'NJIT', 0, '0',616476.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1090, 'NJIT', 0, '0',616477.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1091, 'NJIT', 0, '0',616478.0,788274.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1092, 'NJIT', 0, '0',616439.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1093, 'NJIT', 0, '0',616440.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1094, 'NJIT', 0, '0',616441.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1095, 'NJIT', 0, '0',616442.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1096, 'NJIT', 0, '0',616443.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1097, 'NJIT', 0, '0',616444.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1098, 'NJIT', 0, '0',616445.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1099, 'NJIT', 0, '0',616446.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1100, 'NJIT', 0, '0',616447.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1101, 'NJIT', 0, '0',616448.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1102, 'NJIT', 0, '0',616449.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1103, 'NJIT', 0, '0',616450.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1104, 'NJIT', 0, '0',616451.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1105, 'NJIT', 0, '0',616452.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1106, 'NJIT', 0, '0',616453.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1107, 'NJIT', 0, '0',616454.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1108, 'NJIT', 0, '0',616455.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1109, 'NJIT', 0, '0',616456.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1110, 'NJIT', 0, '0',616457.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1111, 'NJIT', 0, '0',616458.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1112, 'NJIT', 0, '0',616459.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1113, 'NJIT', 0, '0',616460.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1114, 'NJIT', 0, '0',616461.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1115, 'NJIT', 0, '0',616462.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1116, 'NJIT', 0, '0',616463.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1117, 'NJIT', 0, '0',616464.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1118, 'NJIT', 0, '0',616465.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1119, 'NJIT', 0, '0',616466.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1120, 'NJIT', 0, '0',616467.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1121, 'NJIT', 0, '0',616468.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1122, 'NJIT', 0, '0',616469.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1123, 'NJIT', 0, '0',616470.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1124, 'NJIT', 0, '0',616471.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1125, 'NJIT', 0, '0',616472.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1126, 'NJIT', 0, '0',616473.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1127, 'NJIT', 0, '0',616474.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1128, 'NJIT', 0, '0',616475.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1129, 'NJIT', 0, '0',616476.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1130, 'NJIT', 0, '0',616477.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1131, 'NJIT', 0, '0',616478.0,788275.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1132, 'NJIT', 0, '0',616441.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1133, 'NJIT', 0, '0',616442.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1134, 'NJIT', 0, '0',616443.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1135, 'NJIT', 0, '0',616444.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1136, 'NJIT', 0, '0',616445.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1137, 'NJIT', 0, '0',616446.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1138, 'NJIT', 0, '0',616447.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1139, 'NJIT', 0, '0',616448.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1140, 'NJIT', 0, '0',616449.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1141, 'NJIT', 0, '0',616450.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1142, 'NJIT', 0, '0',616451.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1143, 'NJIT', 0, '0',616452.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1144, 'NJIT', 0, '0',616453.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1145, 'NJIT', 0, '0',616454.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1146, 'NJIT', 0, '0',616455.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1147, 'NJIT', 0, '0',616456.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1148, 'NJIT', 0, '0',616457.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1149, 'NJIT', 0, '0',616458.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1150, 'NJIT', 0, '0',616459.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1151, 'NJIT', 0, '0',616460.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1152, 'NJIT', 0, '0',616461.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1153, 'NJIT', 0, '0',616462.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1154, 'NJIT', 0, '0',616463.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1155, 'NJIT', 0, '0',616464.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1156, 'NJIT', 0, '0',616465.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1157, 'NJIT', 0, '0',616466.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1158, 'NJIT', 0, '0',616467.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1159, 'NJIT', 0, '0',616468.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1160, 'NJIT', 0, '0',616469.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1161, 'NJIT', 0, '0',616470.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1162, 'NJIT', 0, '0',616471.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1163, 'NJIT', 0, '0',616472.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1164, 'NJIT', 0, '0',616473.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1165, 'NJIT', 0, '0',616474.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1166, 'NJIT', 0, '0',616475.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1167, 'NJIT', 0, '0',616476.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1168, 'NJIT', 0, '0',616477.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1169, 'NJIT', 0, '0',616478.0,788276.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1170, 'NJIT', 0, '0',616443.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1171, 'NJIT', 0, '0',616444.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1172, 'NJIT', 0, '0',616445.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1173, 'NJIT', 0, '0',616446.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1174, 'NJIT', 0, '0',616447.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1175, 'NJIT', 0, '0',616448.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1176, 'NJIT', 0, '0',616449.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1177, 'NJIT', 0, '0',616450.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1178, 'NJIT', 0, '0',616451.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1179, 'NJIT', 0, '0',616452.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1180, 'NJIT', 0, '0',616453.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1181, 'NJIT', 0, '0',616454.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1182, 'NJIT', 0, '0',616455.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1183, 'NJIT', 0, '0',616456.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1184, 'NJIT', 0, '0',616457.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1185, 'NJIT', 0, '0',616458.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1186, 'NJIT', 0, '0',616459.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1187, 'NJIT', 0, '0',616460.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1188, 'NJIT', 0, '0',616461.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1189, 'NJIT', 0, '0',616462.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1190, 'NJIT', 0, '0',616463.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1191, 'NJIT', 0, '0',616464.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1192, 'NJIT', 0, '0',616465.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1193, 'NJIT', 0, '0',616466.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1194, 'NJIT', 0, '0',616467.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1195, 'NJIT', 0, '0',616468.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1196, 'NJIT', 0, '0',616469.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1197, 'NJIT', 0, '0',616470.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1198, 'NJIT', 0, '0',616471.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1199, 'NJIT', 0, '0',616472.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1200, 'NJIT', 0, '0',616473.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1201, 'NJIT', 0, '0',616474.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1202, 'NJIT', 0, '0',616475.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1203, 'NJIT', 0, '0',616476.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1204, 'NJIT', 0, '0',616477.0,788277.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1205, 'NJIT', 0, '0',616446.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1206, 'NJIT', 0, '0',616447.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1207, 'NJIT', 0, '0',616448.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1208, 'NJIT', 0, '0',616449.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1209, 'NJIT', 0, '0',616450.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1210, 'NJIT', 0, '0',616451.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1211, 'NJIT', 0, '0',616452.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1212, 'NJIT', 0, '0',616453.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1213, 'NJIT', 0, '0',616454.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1214, 'NJIT', 0, '0',616455.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1215, 'NJIT', 0, '0',616456.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1216, 'NJIT', 0, '0',616457.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1217, 'NJIT', 0, '0',616458.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1218, 'NJIT', 0, '0',616459.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1219, 'NJIT', 0, '0',616460.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1220, 'NJIT', 0, '0',616461.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1221, 'NJIT', 0, '0',616462.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1222, 'NJIT', 0, '0',616463.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1223, 'NJIT', 0, '0',616464.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1224, 'NJIT', 0, '0',616465.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1225, 'NJIT', 0, '0',616466.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1226, 'NJIT', 0, '0',616467.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1227, 'NJIT', 0, '0',616468.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1228, 'NJIT', 0, '0',616469.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1229, 'NJIT', 0, '0',616470.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1230, 'NJIT', 0, '0',616471.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1231, 'NJIT', 0, '0',616472.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1232, 'NJIT', 0, '0',616473.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1233, 'NJIT', 0, '0',616474.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1234, 'NJIT', 0, '0',616475.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1235, 'NJIT', 0, '0',616476.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1236, 'NJIT', 0, '0',616477.0,788278.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1237, 'NJIT', 0, '0',616448.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1238, 'NJIT', 0, '0',616449.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1239, 'NJIT', 0, '0',616450.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1240, 'NJIT', 0, '0',616451.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1241, 'NJIT', 0, '0',616452.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1242, 'NJIT', 0, '0',616453.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1243, 'NJIT', 0, '0',616454.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1244, 'NJIT', 0, '0',616455.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1245, 'NJIT', 0, '0',616456.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1246, 'NJIT', 0, '0',616457.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1247, 'NJIT', 0, '0',616458.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1248, 'NJIT', 0, '0',616459.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1249, 'NJIT', 0, '0',616460.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1250, 'NJIT', 0, '0',616461.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1251, 'NJIT', 0, '0',616462.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1252, 'NJIT', 0, '0',616463.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1253, 'NJIT', 0, '0',616464.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1254, 'NJIT', 0, '0',616465.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1255, 'NJIT', 0, '0',616466.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1256, 'NJIT', 0, '0',616467.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1257, 'NJIT', 0, '0',616468.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1258, 'NJIT', 0, '0',616469.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1259, 'NJIT', 0, '0',616470.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1260, 'NJIT', 0, '0',616471.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1261, 'NJIT', 0, '0',616472.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1262, 'NJIT', 0, '0',616473.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1263, 'NJIT', 0, '0',616474.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1264, 'NJIT', 0, '0',616475.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1265, 'NJIT', 0, '0',616476.0,788279.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1266, 'NJIT', 0, '0',616450.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1267, 'NJIT', 0, '0',616451.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1268, 'NJIT', 0, '0',616452.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1269, 'NJIT', 0, '0',616453.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1270, 'NJIT', 0, '0',616454.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1271, 'NJIT', 0, '0',616455.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1272, 'NJIT', 0, '0',616456.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1273, 'NJIT', 0, '0',616457.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1274, 'NJIT', 0, '0',616458.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1275, 'NJIT', 0, '0',616459.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1276, 'NJIT', 0, '0',616460.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1277, 'NJIT', 0, '0',616461.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1278, 'NJIT', 0, '0',616462.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1279, 'NJIT', 0, '0',616463.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1280, 'NJIT', 0, '0',616464.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1281, 'NJIT', 0, '0',616465.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1282, 'NJIT', 0, '0',616466.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1283, 'NJIT', 0, '0',616467.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1284, 'NJIT', 0, '0',616468.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1285, 'NJIT', 0, '0',616469.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1286, 'NJIT', 0, '0',616470.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1287, 'NJIT', 0, '0',616471.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1288, 'NJIT', 0, '0',616472.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1289, 'NJIT', 0, '0',616473.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1290, 'NJIT', 0, '0',616474.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1291, 'NJIT', 0, '0',616475.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1292, 'NJIT', 0, '0',616476.0,788280.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1293, 'NJIT', 0, '0',616453.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1294, 'NJIT', 0, '0',616454.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1295, 'NJIT', 0, '0',616455.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1296, 'NJIT', 0, '0',616456.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1297, 'NJIT', 0, '0',616457.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1298, 'NJIT', 0, '0',616458.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1299, 'NJIT', 0, '0',616459.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1300, 'NJIT', 0, '0',616460.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1301, 'NJIT', 0, '0',616461.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1302, 'NJIT', 0, '0',616462.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1303, 'NJIT', 0, '0',616463.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1304, 'NJIT', 0, '0',616464.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1305, 'NJIT', 0, '0',616465.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1306, 'NJIT', 0, '0',616466.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1307, 'NJIT', 0, '0',616467.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1308, 'NJIT', 0, '0',616468.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1309, 'NJIT', 0, '0',616469.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1310, 'NJIT', 0, '0',616470.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1311, 'NJIT', 0, '0',616471.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1312, 'NJIT', 0, '0',616472.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1313, 'NJIT', 0, '0',616473.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1314, 'NJIT', 0, '0',616474.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1315, 'NJIT', 0, '0',616475.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1316, 'NJIT', 0, '0',616476.0,788281.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1317, 'NJIT', 0, '0',616455.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1318, 'NJIT', 0, '0',616456.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1319, 'NJIT', 0, '0',616457.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1320, 'NJIT', 0, '0',616458.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1321, 'NJIT', 0, '0',616459.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1322, 'NJIT', 0, '0',616460.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1323, 'NJIT', 0, '0',616461.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1324, 'NJIT', 0, '0',616462.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1325, 'NJIT', 0, '0',616463.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1326, 'NJIT', 0, '0',616464.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1327, 'NJIT', 0, '0',616465.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1328, 'NJIT', 0, '0',616466.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1329, 'NJIT', 0, '0',616467.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1330, 'NJIT', 0, '0',616468.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1331, 'NJIT', 0, '0',616469.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1332, 'NJIT', 0, '0',616470.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1333, 'NJIT', 0, '0',616471.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1334, 'NJIT', 0, '0',616472.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1335, 'NJIT', 0, '0',616473.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1336, 'NJIT', 0, '0',616474.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1337, 'NJIT', 0, '0',616475.0,788282.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1338, 'NJIT', 0, '0',616457.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1339, 'NJIT', 0, '0',616458.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1340, 'NJIT', 0, '0',616459.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1341, 'NJIT', 0, '0',616460.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1342, 'NJIT', 0, '0',616461.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1343, 'NJIT', 0, '0',616462.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1344, 'NJIT', 0, '0',616463.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1345, 'NJIT', 0, '0',616464.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1346, 'NJIT', 0, '0',616465.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1347, 'NJIT', 0, '0',616466.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1348, 'NJIT', 0, '0',616467.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1349, 'NJIT', 0, '0',616468.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1350, 'NJIT', 0, '0',616469.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1351, 'NJIT', 0, '0',616470.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1352, 'NJIT', 0, '0',616471.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1353, 'NJIT', 0, '0',616472.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1354, 'NJIT', 0, '0',616473.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1355, 'NJIT', 0, '0',616474.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1356, 'NJIT', 0, '0',616475.0,788283.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1357, 'NJIT', 0, '0',616460.0,788284.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1358, 'NJIT', 0, '0',616461.0,788284.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1359, 'NJIT', 0, '0',616462.0,788284.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1360, 'NJIT', 0, '0',616463.0,788284.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1361, 'NJIT', 0, '0',616464.0,788284.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1362, 'NJIT', 0, '0',616465.0,788284.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1363, 'NJIT', 0, '0',616466.0,788284.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1364, 'NJIT', 0, '0',616467.0,788284.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1365, 'NJIT', 0, '0',616468.0,788284.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1366, 'NJIT', 0, '0',616469.0,788284.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1367, 'NJIT', 0, '0',616470.0,788284.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1368, 'NJIT', 0, '0',616471.0,788284.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1369, 'NJIT', 0, '0',616472.0,788284.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1370, 'NJIT', 0, '0',616473.0,788284.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1371, 'NJIT', 0, '0',616474.0,788284.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1372, 'NJIT', 0, '0',616462.0,788285.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1373, 'NJIT', 0, '0',616463.0,788285.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1374, 'NJIT', 0, '0',616464.0,788285.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1375, 'NJIT', 0, '0',616465.0,788285.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1376, 'NJIT', 0, '0',616466.0,788285.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1377, 'NJIT', 0, '0',616467.0,788285.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1378, 'NJIT', 0, '0',616468.0,788285.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1379, 'NJIT', 0, '0',616469.0,788285.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1380, 'NJIT', 0, '0',616470.0,788285.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1381, 'NJIT', 0, '0',616471.0,788285.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1382, 'NJIT', 0, '0',616472.0,788285.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1383, 'NJIT', 0, '0',616473.0,788285.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1384, 'NJIT', 0, '0',616474.0,788285.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1385, 'NJIT', 0, '0',616464.0,788286.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1386, 'NJIT', 0, '0',616465.0,788286.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1387, 'NJIT', 0, '0',616466.0,788286.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1388, 'NJIT', 0, '0',616467.0,788286.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1389, 'NJIT', 0, '0',616468.0,788286.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1390, 'NJIT', 0, '0',616469.0,788286.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1391, 'NJIT', 0, '0',616470.0,788286.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1392, 'NJIT', 0, '0',616471.0,788286.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1393, 'NJIT', 0, '0',616472.0,788286.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1394, 'NJIT', 0, '0',616473.0,788286.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1395, 'NJIT', 0, '0',616474.0,788286.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1396, 'NJIT', 0, '0',616467.0,788287.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1397, 'NJIT', 0, '0',616468.0,788287.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1398, 'NJIT', 0, '0',616469.0,788287.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1399, 'NJIT', 0, '0',616470.0,788287.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1400, 'NJIT', 0, '0',616471.0,788287.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1401, 'NJIT', 0, '0',616472.0,788287.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1402, 'NJIT', 0, '0',616473.0,788287.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1403, 'NJIT', 0, '0',616469.0,788288.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1404, 'NJIT', 0, '0',616470.0,788288.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1405, 'NJIT', 0, '0',616471.0,788288.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1406, 'NJIT', 0, '0',616472.0,788288.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1407, 'NJIT', 0, '0',616473.0,788288.0, 'N');
insert into "APP"."AREA" ("SQAURE_ID", "SQUARE_DESC", "FLOOR_NUM", "ROOM_NUM", "TILE_X", "TILE_Y", "COVERED_IND") values(1408, 'NJIT', 0, '0',616472.0,788289.0, 'N');

