-- below query to get max signal of each square having NJIT signal from mcsense data
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2012-04-02 00:00:00' and '2012-04-16 00:00:00'
			group by square_id
			order by square_id;
			
-- below queries are for 2 weeks progress to get max signal of each square having NJIT signal from mcsense data
select square_id, max(SIGNALLEVEL) from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2012-04-02 00:00:00' and '2012-04-03 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2012-04-02 00:00:00' and '2012-04-04 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2012-04-02 00:00:00' and '2012-04-05 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2012-04-02 00:00:00' and '2012-04-06 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2012-04-02 00:00:00' and '2012-04-07 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2012-04-02 00:00:00' and '2012-04-08 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2012-04-02 00:00:00' and '2012-04-09 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2012-04-02 00:00:00' and '2012-04-10 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2012-04-02 00:00:00' and '2012-04-11 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2012-04-02 00:00:00' and '2012-04-12 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2012-04-02 00:00:00' and '2012-04-13 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2012-04-02 00:00:00' and '2012-04-14 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2012-04-02 00:00:00' and '2012-04-15 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.MCSENSE_READINGS 
		where SSID = 'njit'
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2012-04-02 00:00:00' and '2012-04-16 00:00:00'
			group by square_id
			order by square_id;
			
			
-- 2weeks coverage for game
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2014-04-01 00:00:00' and '2014-04-15 00:00:00'
			group by square_id
			order by square_id;

--below queries for all 2 weeks progress
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2014-04-01 00:00:00' and '2014-04-02 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2014-04-01 00:00:00' and '2014-04-03 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2014-04-01 00:00:00' and '2014-04-04 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2014-04-01 00:00:00' and '2014-04-05 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2014-04-01 00:00:00' and '2014-04-06 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2014-04-01 00:00:00' and '2014-04-07 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2014-04-01 00:00:00' and '2014-04-08 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2014-04-01 00:00:00' and '2014-04-09 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2014-04-01 00:00:00' and '2014-04-10 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2014-04-01 00:00:00' and '2014-04-11 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2014-04-01 00:00:00' and '2014-04-12 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2014-04-01 00:00:00' and '2014-04-13 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2014-04-01 00:00:00' and '2014-04-14 00:00:00'
			group by square_id
			order by square_id;
select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS 
		where (SSID like ('%NJIT%') or SSID like ('%njit%'))
			and square_id >= 0
			and square_id in (select a.sqaure_id from APP.AREA a where a.rutgers_ind = 'N')
			and created_time between '2014-04-01 00:00:00' and '2014-04-15 00:00:00'
			group by square_id
			order by square_id;
