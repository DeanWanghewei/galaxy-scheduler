DROP TABLE IF EXISTS QRTZ_FIRED_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_PAUSED_TRIGGER_GRPS;
DROP TABLE IF EXISTS QRTZ_SCHEDULER_STATE;
DROP TABLE IF EXISTS QRTZ_LOCKS;
DROP TABLE IF EXISTS QRTZ_SIMPLE_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_SIMPROP_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_CRON_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_BLOB_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_JOB_DETAILS;
DROP TABLE IF EXISTS QRTZ_CALENDARS;

CREATE TABLE QRTZ_JOB_DETAILS
(
    SCHED_NAME        VARCHAR(120) NOT NULL comment '调度器名称',
    JOB_NAME          VARCHAR(200) NOT NULL comment '任务名称',
    JOB_GROUP         VARCHAR(200) NOT NULL comment '任务群组',
    DESCRIPTION       VARCHAR(250) NULL comment '说明',
    JOB_CLASS_NAME    VARCHAR(250) NOT NULL comment '任务class全路径',
    IS_DURABLE        VARCHAR(1)   NOT NULL comment '是否是长期运行的',
    IS_NONCONCURRENT  VARCHAR(1)   NOT NULL comment '是否是不同步的',
    IS_UPDATE_DATA    VARCHAR(1)   NOT NULL comment '更新数据',
    REQUESTS_RECOVERY VARCHAR(1)   NOT NULL comment '请求恢复',
    JOB_DATA          BLOB         NULL comment '任务包含的数据',
    PRIMARY KEY (SCHED_NAME, JOB_NAME, JOB_GROUP)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 comment ='任务详情';

CREATE TABLE QRTZ_TRIGGERS
(
    SCHED_NAME     VARCHAR(120) NOT NULL comment '调度器名称',
    TRIGGER_NAME   VARCHAR(200) NOT NULL comment '触发器名称',
    TRIGGER_GROUP  VARCHAR(200) NOT NULL comment '触发器群组',
    JOB_NAME       VARCHAR(200) NOT NULL comment '任务名称',
    JOB_GROUP      VARCHAR(200) NOT NULL comment '任务群组',
    DESCRIPTION    VARCHAR(250) NULL comment '说明',
    NEXT_FIRE_TIME BIGINT(13)   NULL comment '下次调度时间',
    PREV_FIRE_TIME BIGINT(13)   NULL comment '上次调度时间',
    PRIORITY       INTEGER      NULL comment '权重',
    TRIGGER_STATE  VARCHAR(16)  NOT NULL comment '触发器状态',
    TRIGGER_TYPE   VARCHAR(8)   NOT NULL comment '触发器类型',
    START_TIME     BIGINT(13)   NOT NULL comment '调度开始时间',
    END_TIME       BIGINT(13)   NULL comment '调度结束时间',
    CALENDAR_NAME  VARCHAR(200) NULL comment '触发器名称',
    MISFIRE_INSTR  SMALLINT(2)  NULL comment '结束指令',
    JOB_DATA       BLOB         NULL comment '任务包含的数据',
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 comment ='任务调度器信息';

CREATE TABLE QRTZ_SIMPLE_TRIGGERS
(
    SCHED_NAME      VARCHAR(120) NOT NULL comment '计划名称',
    TRIGGER_NAME    VARCHAR(200) NOT NULL comment '触发器名称',
    TRIGGER_GROUP   VARCHAR(200) NOT NULL comment '触发器组',
    REPEAT_COUNT    BIGINT(7)    NOT NULL comment '重复次数',
    REPEAT_INTERVAL BIGINT(12)   NOT NULL comment '重复间隔',
    TIMES_TRIGGERED BIGINT(10)   NOT NULL comment '触发次数',
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 comment ='存储简单的Trigger，包括重复次数，间隔，以及已触的次数';

CREATE TABLE QRTZ_CRON_TRIGGERS
(
    SCHED_NAME      VARCHAR(120) NOT NULL comment '计划名称',
    TRIGGER_NAME    VARCHAR(200) NOT NULL comment '触发器名称',
    TRIGGER_GROUP   VARCHAR(200) NOT NULL comment '触发器群组',
    CRON_EXPRESSION VARCHAR(200) NOT NULL comment 'cron表达式',
    TIME_ZONE_ID    VARCHAR(80) comment '时区',
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='cron触发器';

CREATE TABLE QRTZ_SIMPROP_TRIGGERS
(
    SCHED_NAME    VARCHAR(120)   NOT NULL comment '计划名称',
    TRIGGER_NAME  VARCHAR(200)   NOT NULL comment '触发器名称',
    TRIGGER_GROUP VARCHAR(200)   NOT NULL comment '触发器群组',
    STR_PROP_1    VARCHAR(512)   NULL comment 'string支持1',
    STR_PROP_2    VARCHAR(512)   NULL comment 'string支持2',
    STR_PROP_3    VARCHAR(512)   NULL comment 'string支持3',
    INT_PROP_1    INT            NULL comment 'int支持1',
    INT_PROP_2    INT            NULL comment 'int支持2',
    LONG_PROP_1   BIGINT         NULL comment 'long 支持1',
    LONG_PROP_2   BIGINT         NULL comment 'long 支持2',
    DEC_PROP_1    NUMERIC(13, 4) NULL comment 'dec 支持1',
    DEC_PROP_2    NUMERIC(13, 4) NULL comment 'dec 支持2',
    BOOL_PROP_1   VARCHAR(1)     NULL comment 'bool 支持1',
    BOOL_PROP_2   VARCHAR(1)     NULL comment 'bool 支持1',
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
);

CREATE TABLE QRTZ_BLOB_TRIGGERS
(
    SCHED_NAME    VARCHAR(120) NOT NULL comment '计划名称',
    TRIGGER_NAME  VARCHAR(200) NOT NULL comment '触发器名称',
    TRIGGER_GROUP VARCHAR(200) NOT NULL comment '触发器群组',
    BLOB_DATA     BLOB         NULL comment '基本信息',
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='用于 Quartz 用户用 JDBC 创建他们自己定制的 Trigger 类型，JobStore并不知道如何存储实例的时候';

CREATE TABLE QRTZ_CALENDARS
(
    SCHED_NAME    VARCHAR(120) NOT NULL comment '计划名称',
    CALENDAR_NAME VARCHAR(200) NOT NULL comment '触发器名称',
    CALENDAR      BLOB         NOT NULL comment '日历信息',
    PRIMARY KEY (SCHED_NAME, CALENDAR_NAME)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='日历信息触发器';

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS
(
    SCHED_NAME    VARCHAR(120) NOT NULL comment '计划名称',
    TRIGGER_GROUP VARCHAR(200) NOT NULL comment '触发器组',
    PRIMARY KEY (SCHED_NAME, TRIGGER_GROUP)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='被暂停的触发器';

CREATE TABLE QRTZ_FIRED_TRIGGERS
(
    SCHED_NAME        VARCHAR(120) NOT NULL comment '计划名称',
    ENTRY_ID          VARCHAR(95)  NOT NULL comment '组织id',
    TRIGGER_NAME      VARCHAR(200) NOT NULL comment '触发器名称',
    TRIGGER_GROUP     VARCHAR(200) NOT NULL comment '触发器组',
    INSTANCE_NAME     VARCHAR(200) NOT NULL comment '实例名称',
    FIRED_TIME        BIGINT(13)   NOT NULL comment '触发时间',
    SCHED_TIME        BIGINT(13)   NOT NULL comment '计划时间',
    PRIORITY          INTEGER      NOT NULL comment '权重',
    STATE             VARCHAR(16)  NOT NULL comment '状态',
    JOB_NAME          VARCHAR(200) NULL comment '作业名称',
    JOB_GROUP         VARCHAR(200) NULL comment '作业群组',
    IS_NONCONCURRENT  VARCHAR(1)   NULL comment '是否并行',
    REQUESTS_RECOVERY VARCHAR(1)   NULL comment '是否要求唤醒',
    PRIMARY KEY (SCHED_NAME, ENTRY_ID)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='存储与已触发的 Trigger 相关的状态信息，以及相联 Job的执行信息QRTZ_PAUSED_TRIGGER_GRPS 存储已暂停的 Trigger组的信息';

CREATE TABLE QRTZ_SCHEDULER_STATE
(
    SCHED_NAME        VARCHAR(120) NOT NULL comment '调度器名称',
    INSTANCE_NAME     VARCHAR(200) NOT NULL comment '运行节点名称',
    LAST_CHECKIN_TIME BIGINT(13)   NOT NULL comment '最后验证时间',
    CHECKIN_INTERVAL  BIGINT(13)   NOT NULL comment '时间间隔',
    PRIMARY KEY (SCHED_NAME, INSTANCE_NAME)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 comment '调度状态结果';

CREATE TABLE QRTZ_LOCKS
(
    SCHED_NAME VARCHAR(120) NOT NULL comment '计划名称',
    LOCK_NAME  VARCHAR(40)  NOT NULL comment '锁名称',
    PRIMARY KEY (SCHED_NAME, LOCK_NAME)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='通过悲观锁获取触发器';


commit;