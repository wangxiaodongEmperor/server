

create table APPbaseInfo(
   onlyIndentification VARCHAR (100)NOT NULL,
   phone_System VARCHAR (100),
   phone_Firm VARCHAR (100),
   phone_Model VARCHAR (100),
   phone_OnlyIndentification VARCHAR (100),
   phone_IsRoot VARCHAR (100),
   phone_SystemVersion VARCHAR (100),
   phone_ResolutionRatio VARCHAR (100),
   phone_Bounds VARCHAR (100),
   phone_NetWorkState VARCHAR (100),
   phone_Number VARCHAR (100),
   phone_Operator VARCHAR (100),
   phone_JCDLKNumber VARCHAR (100),
   phone_GJYDYHSBMNumber VARCHAR (100),
   phone_Country VARCHAR (100),
   phone_TimeZone VARCHAR (100),
   phone_Longitude VARCHAR (100),
   phone_Latitude VARCHAR (100),
   app_Name VARCHAR (100),
   app_Version VARCHAR (100),
   app_ID VARCHAR (100),
   app_Key VARCHAR (100),
   app_SDKState VARCHAR (100),
   app_SDKVersion VARCHAR (100),
   app_Channel VARCHAR (100),
   user_phoneNumber VARCHAR (100),
   user_sfzCard VARCHAR (100),
   userName VARCHAR (100),
   user_Cusid VARCHAR (100),
   user_XL VARCHAR (100),
   user_BYYX VARCHAR (100),
   PRIMARY KEY ( onlyIndentification )
);
comment on table APPbaseInfo is '基础信息'; 
comment on column APPbaseInfo.onlyIndentification is '唯一标识';	
comment on column APPbaseInfo.phone_System is '操作系统';	
comment on column APPbaseInfo.phone_Firm is '手机厂商';	
comment on column APPbaseInfo.phone_OnlyIndentification is '设备唯一标识';	
comment on column APPbaseInfo.phone_IsRoot is '是否root';	
comment on column APPbaseInfo.phone_SystemVersion is '系统版本';	
comment on column APPbaseInfo.phone_ResolutionRatio is '分辨率';	
comment on column APPbaseInfo.phone_Bounds is '屏幕尺寸';
comment on column APPbaseInfo.phone_NetWorkState is '联网方式';	
comment on column APPbaseInfo.phone_Number is '电话号码';	
comment on column APPbaseInfo.phone_Operator is '运营商';	
comment on column APPbaseInfo.phone_JCDLKNumber is '集成电路卡识别码';	
comment on column APPbaseInfo.phone_GJYDYHSBMNumber is '国际移动用户识别码号码';	
comment on column APPbaseInfo.phone_Country is '国家';	
comment on column APPbaseInfo.phone_TimeZone is '时区';	
comment on column APPbaseInfo.phone_Longitude is '经度';	
comment on column APPbaseInfo.phone_Latitude is '纬度';	
comment on column APPbaseInfo.app_Name is 'App版本名';	
comment on column APPbaseInfo.app_Version is 'App版本号';	
comment on column APPbaseInfo.app_ID is 'AppID';	
comment on column APPbaseInfo.app_Key is 'AppKey';	
comment on column APPbaseInfo.app_SDKState is 'SDK类型';	
comment on column APPbaseInfo.app_SDKVersion is 'SDK版本';	
comment on column APPbaseInfo.app_Channel is 'APP渠道';	
comment on column APPbaseInfo.user_phoneNumber is '手机号';	
comment on column APPbaseInfo.user_sfzCard is '身份证号码';	
comment on column APPbaseInfo.userName is '姓名';	
comment on column APPbaseInfo.user_Cusid is '客户号';	
comment on column APPbaseInfo.user_XL is '学历';	
comment on column APPbaseInfo.user_BYYX is '毕业院校';	

	
create table conversationInfo(
   onlyIndentification VARCHAR (100)NOT NULL,
   channel VARCHAR (100),
   conversation_ID VARCHAR (100),
   conversation_Duration VARCHAR (100),
   conversation_Date VARCHAR (100),
   conversation_Time VARCHAR (100),
   conversation_Name VARCHAR (100),
   conversation_Path VARCHAR (100),
   conversation_TimeTamp VARCHAR (100),
   conversation_OverDate VARCHAR (100),
   conversation_OverTime VARCHAR (100)
);
create index conversationInfo_index on conversationInfo (onlyIndentification) ;	
comment on table conversationInfo is '会话信息'; 
comment on column conversationInfo.onlyIndentification is '唯一标识';	
comment on column conversationInfo.channel is 'channel';	
comment on column conversationInfo.conversation_ID is '会话ID';	
comment on column conversationInfo.conversation_Duration is '会话时长';	
comment on column conversationInfo.conversation_Date is '启动日期';	
comment on column conversationInfo.conversation_Time is '启动时间';	
comment on column conversationInfo.conversation_Name is '页面名称';	
comment on column conversationInfo.conversation_Path is '页面访问路径';
comment on column conversationInfo.conversation_TimeTamp is '时间戳';	
comment on column conversationInfo.conversation_OverDate is '结束日期';	
comment on column conversationInfo.conversation_OverTime is '结束时间';	

create table tapInfo(
   onlyIndentification VARCHAR (100)NOT NULL,
   channel VARCHAR (100),
   eventID VARCHAR (100),
   eventTag VARCHAR (100),
   eventTime VARCHAR (100),
   eventDate VARCHAR (100),
   eventNumber VARCHAR (100),
   conversation_ID VARCHAR (100), 
   eventPageName VARCHAR (100),
   eventKey VARCHAR (100),
   eventValue VARCHAR (100)
);
create index tapInfo_onlyIndentification on tapInfo (onlyIndentification) ;	

comment on table tapInfo is '点击信息'; 
comment on column tapInfo.onlyIndentification is '唯一标识';	
comment on column tapInfo.channel is '渠道号';	
comment on column tapInfo.eventID is '事件ID';	
comment on column tapInfo.eventTag is '事件标签';	
comment on column tapInfo.eventTime is '事件点击时间';	
comment on column tapInfo.eventDate is '事件点击日期';	
comment on column tapInfo.eventNumber is '事件点击次数';	
comment on column tapInfo.conversation_ID is '会话ID';	
comment on column tapInfo.eventPageName is '页面名称';	
comment on column tapInfo.eventKey is '自定义key';	
comment on column tapInfo.eventValue is '自定义key值';	

---回退脚本
drop table tapInfo;
drop table conversationInfo;
drop table APPbaseInfo;