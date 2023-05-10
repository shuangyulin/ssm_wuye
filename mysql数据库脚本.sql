
-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_building` (
  `buildingId` int(11) NOT NULL AUTO_INCREMENT COMMENT '楼栋id',
  `buildingName` varchar(20)  NOT NULL COMMENT '楼栋名称',
  `memo` varchar(50)  NOT NULL COMMENT '楼栋备注',
  PRIMARY KEY (`buildingId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_employee` (
  `employeeNo` varchar(20)  NOT NULL COMMENT 'employeeNo',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `sex` varchar(4)  NOT NULL COMMENT '性别',
  `positionName` varchar(20)  NOT NULL COMMENT '职位',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `address` varchar(60)  NOT NULL COMMENT '地址',
  `employeeDesc` varchar(200)  NOT NULL COMMENT '员工介绍',
  PRIMARY KEY (`employeeNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_owner` (
  `ownerId` int(11) NOT NULL AUTO_INCREMENT COMMENT '业主id',
  `password` varchar(20)  NOT NULL COMMENT '登录密码',
  `buildingObj` int(11) NOT NULL COMMENT '楼栋名称',
  `roomNo` varchar(20)  NOT NULL COMMENT '房间号',
  `ownerName` varchar(20)  NOT NULL COMMENT '户主',
  `area` varchar(20)  NOT NULL COMMENT '房屋面积',
  `telephone` varchar(20)  NOT NULL COMMENT '联系方式',
  `memo` varchar(500)  NULL COMMENT '备注信息',
  PRIMARY KEY (`ownerId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_parking` (
  `parkingId` int(11) NOT NULL AUTO_INCREMENT COMMENT '车位id',
  `parkingName` varchar(20)  NOT NULL COMMENT '车位名称',
  `plateNumber` varchar(20)  NOT NULL COMMENT '车牌号',
  `ownerObj` int(11) NOT NULL COMMENT '车主',
  `opUser` varchar(20)  NOT NULL COMMENT '操作员',
  PRIMARY KEY (`parkingId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_repair` (
  `repairId` int(11) NOT NULL AUTO_INCREMENT COMMENT '报修id',
  `ownerObj` int(11) NOT NULL COMMENT '报修用户',
  `repairDate` varchar(20)  NULL COMMENT '报修日期',
  `questionDesc` varchar(500)  NOT NULL COMMENT '问题描述',
  `repairState` varchar(20)  NOT NULL COMMENT '报修状态',
  `handleResult` varchar(500)  NULL COMMENT '处理结果',
  PRIMARY KEY (`repairId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_feeType` (
  `typeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '类别id',
  `typeName` varchar(20)  NOT NULL COMMENT '类别名称',
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_fee` (
  `feeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '费用id',
  `feeTypeObj` int(11) NOT NULL COMMENT '费用类别',
  `ownerObj` int(11) NOT NULL COMMENT '住户信息',
  `feeDate` varchar(20)  NULL COMMENT '收费时间',
  `feeMoney` float NOT NULL COMMENT '收费金额',
  `feeContent` varchar(50)  NOT NULL COMMENT '收费内容',
  `opUser` varchar(20)  NOT NULL COMMENT '操作员',
  PRIMARY KEY (`feeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_facility` (
  `facilityId` int(11) NOT NULL AUTO_INCREMENT COMMENT '设施id',
  `name` varchar(20)  NOT NULL COMMENT '设施名称',
  `count` int(11) NOT NULL COMMENT '数量',
  `startTime` varchar(20)  NULL COMMENT '开始使用时间',
  `facilityState` varchar(20)  NOT NULL COMMENT '设施状态',
  PRIMARY KEY (`facilityId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_salary` (
  `salaryId` int(11) NOT NULL AUTO_INCREMENT COMMENT '工资id',
  `employeeObj` varchar(20)  NOT NULL COMMENT '员工',
  `year` varchar(20)  NOT NULL COMMENT '工资年份',
  `month` varchar(20)  NOT NULL COMMENT '工资月份',
  `salaryMoney` float NOT NULL COMMENT '工资金额',
  `fafang` varchar(20)  NOT NULL COMMENT '是否发放',
  PRIMARY KEY (`salaryId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_leaveWord` (
  `leaveWordId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录id',
  `title` varchar(20)  NOT NULL COMMENT '标题',
  `content` varchar(500)  NOT NULL COMMENT '内容',
  `addTime` varchar(20)  NULL COMMENT '发布时间',
  `ownerObj` int(11) NOT NULL COMMENT '提交住户',
  `replyContent` varchar(500)  NULL COMMENT '回复内容',
  `replyTime` varchar(20)  NULL COMMENT '回复时间',
  `opUser` varchar(20)  NOT NULL COMMENT '回复人',
  PRIMARY KEY (`leaveWordId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_manager` (
  `manageUserName` varchar(20)  NOT NULL COMMENT 'manageUserName',
  `password` varchar(20)  NOT NULL COMMENT '登录密码',
  `manageType` varchar(20)  NOT NULL COMMENT '管理员类别',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `sex` varchar(4)  NOT NULL COMMENT '性别',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  PRIMARY KEY (`manageUserName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE t_owner ADD CONSTRAINT FOREIGN KEY (buildingObj) REFERENCES t_building(buildingId);
ALTER TABLE t_parking ADD CONSTRAINT FOREIGN KEY (ownerObj) REFERENCES t_owner(ownerId);
ALTER TABLE t_repair ADD CONSTRAINT FOREIGN KEY (ownerObj) REFERENCES t_owner(ownerId);
ALTER TABLE t_fee ADD CONSTRAINT FOREIGN KEY (feeTypeObj) REFERENCES t_feeType(typeId);
ALTER TABLE t_fee ADD CONSTRAINT FOREIGN KEY (ownerObj) REFERENCES t_owner(ownerId);
ALTER TABLE t_salary ADD CONSTRAINT FOREIGN KEY (employeeObj) REFERENCES t_employee(employeeNo);
ALTER TABLE t_leaveWord ADD CONSTRAINT FOREIGN KEY (ownerObj) REFERENCES t_owner(ownerId);


