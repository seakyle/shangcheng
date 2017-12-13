# Host: 127.0.0.1  (Version 5.0.86-community-nt)
# Date: 2017-12-05 10:50:35
# Generator: MySQL-Front 6.0  (Build 2.20)


#
# Structure for table "system_dictionary"
#

DROP TABLE IF EXISTS `system_dictionary`;
CREATE TABLE `system_dictionary` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `parentId` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

#
# Data for table "system_dictionary"
#

INSERT INTO `system_dictionary` VALUES (1,'01001','计算机学院',2,3),(2,'01','学校信息管理',7,2),(3,'0100101','计算机网络1531',1,4),(4,'02','管理员类型',7,2),(5,'02001','超级管理员',4,3),(6,'02002','普通管理员',4,3),(7,'00','字典管理',0,1),(8,'0100102','软件1513',1,4),(9,'03','图标类型管理',7,2),(10,'0301','fa-area-chart',9,3),(11,'0302','fa-plus-square',9,3),(12,'0303','fa-jpy',9,3),(13,'0304','fa- align-justify',9,3),(14,'0305','fa-chain',9,3),(15,'0305','fa- th-list',9,3),(16,'0307','fa-angle-double-down',9,3),(17,'04','区域管理',7,2),(28,'330000','浙江省',17,3),(29,'330100','杭州市',28,4),(30,'330109','萧山区',29,5),(31,'330500','湖州市',28,4),(32,'330523','安吉县',31,5),(33,'730000','黑龙江省',17,3),(34,'730100','齐齐哈尔市',33,4),(35,'730101','梅里斯达斡尔族区',34,5);

#
# Structure for table "system_navs"
#

DROP TABLE IF EXISTS `system_navs`;
CREATE TABLE `system_navs` (
  `id` int(11) NOT NULL auto_increment,
  `href` varchar(255) default NULL,
  `icon` varchar(255) default NULL,
  `parentId` int(11) NOT NULL,
  `spread` varchar(20) NOT NULL default '0',
  `title` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

#
# Data for table "system_navs"
#

INSERT INTO `system_navs` VALUES (1,'#','icon-computer',0,'false','系统管理'),(2,'#','fa-align-justify',0,'false','业务管理'),(3,'/shangcheng/admin/page/studentInfo/studentInfoList.jsp','fa-user',2,'false','学生信息管理'),(4,'/shangcheng/admin/page/dictionary/dictionaryList.jsp','fa-book',1,'false','字典管理'),(5,'/shangcheng/admin/page/navs/navsList.jsp','fa-list-ul',1,'false','模块管理');

#
# Structure for table "t_admin"
#

DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin` (
  `id` int(11) NOT NULL auto_increment,
  `password` varchar(255) default NULL,
  `username` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Data for table "t_admin"
#

INSERT INTO `t_admin` VALUES (1,'jandar','admin','超级管理员');

#
# Structure for table "t_stuinfo"
#

DROP TABLE IF EXISTS `t_stuinfo`;
CREATE TABLE `t_stuinfo` (
  `id` int(11) NOT NULL auto_increment,
  `address` varchar(255) default NULL,
  `major` varchar(255) default NULL,
  `password` varchar(255) default NULL,
  `sex` varchar(255) default NULL,
  `stu_id` varchar(255) default NULL,
  `stu_name` varchar(255) default NULL,
  `stu_num` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

#
# Data for table "t_stuinfo"
#

INSERT INTO `t_stuinfo` VALUES (1,'黑龙江省齐齐哈尔市梅里斯达斡尔族区','计算机','123456','女','1511103025','张三','330990092123123'),(2,'浙江省诸暨市','计算机网络','240000','男','150305153217 ','王杰','330681199704240000'),(14,'浙江省杭州市','软件技术','012390','男','1511101011','小黄鱼','30011230123012390');
