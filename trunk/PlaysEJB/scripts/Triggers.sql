create table App.Aliens_Audit (audit_id integer NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY, alien_id integer, square_id integer, user_id integer, shot_count integer, sys_action varchar(10), sys_time TIMESTAMP);

drop table App.Aliens_Audit;

insert into "APP"."ALIENS" ("ALIEN_ID", "SQUARE_ID", "USER_ID", "SHOT_COUNT") values(683888, 1, 1, 0);

insert into "APP"."ALIENS" ("ALIEN_ID", "SQUARE_ID", "USER_ID", "SHOT_COUNT") values(683892, 1, 1, 0);

select max(alien_id) from App.Aliens

update App.Aliens
set square_id = 2
where alien_id in (683888, 683889) and user_id = 1 and square_id = 1 and shot_count = 0

delete from APP.ALIENS
where alien_id in (683888) and user_id = 1 and square_id = 1 and shot_count = 0

select * from App.Aliens
where alien_id in (683888) and user_id = 1 and square_id = 1 and shot_count = 0

select * from App.Aliens_Audit

drop trigger App.UpdateAlienAUDIT

create trigger App.UpdateAlienAUDIT
  after update  
            on App.Aliens
  REFERENCING NEW AS CURR_ALIEN
  for each row MODE DB2SQL
            insert into App.Aliens_Audit
            (
            alien_id, square_id, user_id, shot_count, 
            sys_action,sys_time
            )
            values
            (
            (CURR_ALIEN.alien_id),
            (CURR_ALIEN.square_id), 
            (CURR_ALIEN.user_id),
            (CURR_ALIEN.shot_count),
            ('U'),
            CURRENT_TIMESTAMP
            );
            
drop trigger App.InsertAlienAUDIT
 
create trigger App.InsertAlienAUDIT
  after insert  
            on App.Aliens
  REFERENCING NEW AS CURR_ALIEN
  for each row MODE DB2SQL
            insert into App.Aliens_Audit
            (
            alien_id, square_id, user_id, shot_count, 
            sys_action,sys_time
            )
            values
            (
            (CURR_ALIEN.alien_id),
            (CURR_ALIEN.square_id), 
            (CURR_ALIEN.user_id),
            (CURR_ALIEN.shot_count),
            ('I'),
            CURRENT_TIMESTAMP
            );
            
 ---- trigger for users
 drop table App.Users_Audit
 create table App.Users_Audit (audit_id integer NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY, user_id integer, user_access varchar(10), user_email varchar(255), bullets integer, score integer, status_level varchar(16), user_meid varchar(255), aliens_killed integer, sys_action varchar(10), sys_time TIMESTAMP);
 
 drop trigger App.UpdateUsersAUDIT

create trigger App.UpdateUsersAUDIT
  after update  
            on App.Users
  REFERENCING NEW AS CURR_USER
  for each row MODE DB2SQL
            insert into App.Users_Audit
            (
            user_id, user_access, user_email, bullets, score, status_level, user_meid, aliens_killed,
            sys_action, sys_time
            )
            values
            (
            (CURR_USER.user_id),
            (CURR_USER.user_access),
            (CURR_USER.user_email), 
            (CURR_USER.bullets), 
            (CURR_USER.score), 
            (CURR_USER.status_level), 
            (CURR_USER.user_meid), 
            (CURR_USER.aliens_killed),
            ('U'),
            CURRENT_TIMESTAMP
            );