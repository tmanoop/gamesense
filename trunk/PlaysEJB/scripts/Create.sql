create table App.Area (sqaure_id integer PRIMARY KEY, square_desc varchar(32), floor_num integer, room_num varchar(16), tile_x double, tile_y double, gps_lat double, gps_lng double, covered_ind varchar(32));
create table App.Users (user_id integer PRIMARY KEY, user_access varchar(10), user_email varchar(255), bullets integer, score integer, status_level integer, user_meid varchar(255), aliens_killed integer);
create table App.Sensor_Readings (reading_id integer PRIMARY KEY, user_id integer, square_id integer, gps_lat double, gps_lng double,  BSSID varchar(255), SSID varchar(255), Capabilities varchar(255), Frequency integer, SignalLevel integer);
create table App.Reading_values (reading_value_id integer PRIMARY KEY, reading_id integer, mac_id char(12), mac_signal_strength double);
create table App.Aliens (alien_id integer PRIMARY KEY, square_id integer, shot_count integer);
create table App.Player_Aliens (player_alien_id integer PRIMARY KEY, shot_alien_id integer, user_id integer, shot_square_id integer, gps_lat double, gps_lng double);
create table App.Bullets (bullet_id integer PRIMARY KEY, bullet_count integer,  square_id integer, gps_lat double, gps_lng double);
create table App.Sentinels (sentinel_id integer PRIMARY KEY, user_id integer, square_id integer, gps_lat double, gps_lng double);

drop table App.Area;
drop table App.Users;
drop table App.Sensor_Readings;
drop table App.Reading_values;
drop table App.Aliens;
drop table App.Player_Aliens;
drop table App.Bullets;
drop table App.Sentinels;

drop table Area;
drop table Users;
drop table Sensor_Readings;
drop table Reading_values;
drop table Aliens;
drop table Player_Aliens;
drop table Bullets;
drop table Sentinels;

delete from App.Aliens;

delete from App.Users;
select * from App.Users;

update APP.Users
set USER_ACCESS = 'Y'
where user_email = 'tmanoop@gmail.com'



ALTER TABLE APP.Aliens
ADD FOREIGN KEY (sqaure_id) 
REFERENCES APP.Area(sqaure_id)
ON DELETE CASCADE;

update APP.AREA
set COVERED_IND = 'N'

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

select * from APP.SEQUENCE
select * from APP.ALIENS
select * from APP.AREA

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