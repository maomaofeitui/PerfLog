-- Script was generated by Devart dbForge Studio for MySQL, Version 5.0.97.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 9/16/2012 7:50:14 AM
-- Server version: 5.1.62-0ubuntu0.10.04.1
-- Client version: 4.1

USE perfDB;

CREATE TABLE PERF_LOG(
  TXN_DT DATE NOT NULL COMMENT 'Transaction date',
  TXN_START TIMESTAMP DEFAULT '0000-00-00 00:00:00' COMMENT 'Transaction Start Time',
  TXN_START_MS BIGINT(20) DEFAULT NULL COMMENT 'Transaction start time in milliseconds since epoch',
  REQUEST_GUID VARCHAR(255) DEFAULT NULL COMMENT 'Globaly unique request identifier. The GUID is prefixed with the INSTANCE_NAME where it was created. Multiple transactions entries can have same REQUEST_GUID as they could be initiated by same servlet or portlet or web service request ',
  REQUEST_SESSION_ID VARCHAR(255) DEFAULT NULL COMMENT 'Request Session ID - This is usually created at the User Interface layer. Can be used to find all transaction within a single user session',
  HOST_NAME VARCHAR(255) DEFAULT NULL COMMENT 'Hostname where the transaction took place',
  HOST_IP VARCHAR(64) DEFAULT NULL COMMENT 'Host IP address where the perf log record was generated',
  INSTANCE_NAME VARCHAR(255) DEFAULT NULL COMMENT 'Container instance name e.g. JVM name in a cluster topology',
  TXN_TIME_MS BIGINT(20) DEFAULT NULL COMMENT 'Transaction time in milli seconds',
  TXN_CLASS VARCHAR(255) DEFAULT NULL COMMENT 'This is marker to indicate what type of transaction classs for categorization e.g. all servlet, portlet can be grouped as web transaction etc.',
  INFO_CONTEXT VARCHAR(2048) DEFAULT NULL COMMENT 'Additional context for the transaction as name value format e.g. in case of form submission, it may contain the form data. Also contain addition transaction details e.g. thread id, transaction contextual information specific to transaction not captured el',
  TXN_TYPE VARCHAR(255) DEFAULT NULL COMMENT 'Transaction type e.g. jaxRpcClient, jaxRpcServer, sqlQuery, servlet etc.',
  TXN_NAME VARCHAR(255) DEFAULT NULL COMMENT 'Transaction name - this can vary depending on the type e.g. in case Web Service, it is the service name, in case of servlet, it is the URI etc.',
  SUB_TXN_NAME VARCHAR(255) DEFAULT NULL COMMENT 'Sub Transaction name, in case of a Web service, it would be the operation, in case of portlet, it could be the portlet etc.',
  REQUEST_GUID_SOURCE VARCHAR(255) DEFAULT NULL COMMENT 'The instance name where the REQUEST_GUID was created.',
  USER_ID VARCHAR(255) DEFAULT NULL COMMENT 'User id for the  transaction ',
  THREAD_NAME VARCHAR(255) DEFAULT NULL COMMENT 'Thread name of the request that generated this performance metric log',
  TXN_STATUS VARCHAR(255) DEFAULT NULL COMMENT 'Indicates Success or Failure, If Failure may include failure message',
  THREAD_ID VARCHAR(255) DEFAULT NULL COMMENT 'Thread id of the transaction thread',
  JVM_DEPTH INT(11) DEFAULT NULL COMMENT 'JVM Depth of the transaction',
  TXN_FILTER_DEPTH INT(11) DEFAULT NULL COMMENT 'Txn filter depth of the current transaction',
  INDEX UK_PERF_LOG_REQUEST_GUID (REQUEST_GUID),
  INDEX UK_PERF_LOG_REQUEST_SESSION_ID (REQUEST_SESSION_ID),
  INDEX UK_PERF_LOG_TXN_DT (TXN_DT)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 456
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'Table to collect performance metrics from org.perf.log.* pac';

CREATE TABLE PERF_LOG_AGGREGATE(
  TXN_DT DATE NOT NULL,
  TXN_NAME VARCHAR(255) NOT NULL,
  SUB_TXN_NAME VARCHAR(255) NOT NULL,
  TXN_TYPE VARCHAR(255) NOT NULL,
  AVERAGE_TXN_TIME_MS BIGINT(20) DEFAULT NULL,
  STD_DEV_TXN_TIME_MS BIGINT(20) DEFAULT NULL,
  MIN_TXN_TIME_MS BIGINT(20) DEFAULT NULL,
  MAX_TXN_TIME_MS BIGINT(20) DEFAULT NULL,
  TOTAL_TXN_TIME_MS BIGINT(20) DEFAULT NULL,
  TOTAL_TXN_COUNT BIGINT(20) DEFAULT NULL,
  AGGREGATE_TYPE VARCHAR(255) NOT NULL COMMENT '5 aggregate types - fiveMinute, hourly, weekly, monthly',
  PRIMARY KEY (AGGREGATE_TYPE, TXN_TYPE, TXN_NAME, TXN_DT, SUB_TXN_NAME),
  INDEX IX_PERF_LOG_AGGREGATE_AGGREGATE_TYPE (AGGREGATE_TYPE),
  INDEX IX_PERF_LOG_AGGREGATE_SUB_TXN_NAME (SUB_TXN_NAME),
  INDEX IX_PERF_LOG_AGGREGATE_TXN_DT (TXN_DT),
  INDEX IX_PERF_LOG_AGGREGATE_TXN_NAME (TXN_NAME)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci;