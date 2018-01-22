create table User(
   user_id VARCHAR (100) not null,
   user_name VARCHAR (100) not null,
   id_card VARCHAR (100),
   phone VARCHAR (100),
   password VARCHAR (100),
   nick_name VARCHAR (100),
   gesture_password VARCHAR (100),
   gesturepassword_flag VARCHAR (100),
   PRIMARY KEY ( user_id )
);
comment on table User is '用户信息'; 
comment on column User.user_id is '客户号';	
comment on column User.user_name is '客户名';	
comment on column User.id_card is '身份证';	
comment on column User.phone is '手机号';	
comment on column User.password is '密码';
comment on column User.nick_name is '别名';
comment on column User.gesture_password is '手势密码';
comment on column User.gesturepassword_flag is '手势密码开关';