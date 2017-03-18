CREATE DATABASE IF NOT EXISTS whut_database;
USE whut_database;

/**
课数据表：流水号（课程ID）  课程名称 起始周  终止周  老师  上课地址  周几 时间（第几节课）
学生数据表：//只储存学生信息
老师数据表：//只储存老师信息
学生匹配课程数据表：流水号  学生ID  课程ID
教师匹配课程数据表: 流水号  教师ID  课程ID
实验室规格表：教室  数量  器材类型  仪器已损坏数量
实验课数据表：周几 时间  地点  课程名称  老师
 */


/**
下面是对于course_info数据表的定义
*/
DROP TABLE IF EXISTS `course_info`;
CREATE TABLE `course_info` (
  `course_id`           INT(10) UNSIGNED   NOT NULL AUTO_INCREMENT COMMENT '课程编号',
  `course_name`         VARCHAR(20)
                        CHARACTER SET utf8 NOT NULL COMMENT '课程名称',
  `start_week`          INT(2)             NOT NULL COMMENT '起始周',
  `end_week`            INT(2)             NOT NULL COMMENT '终止周',
  `course_teacher_name` VARCHAR(20)
                        CHARACTER SET utf8 NOT NULL COMMENT '授课教师',
  `course_address`      VARCHAR(20)
                        CHARACTER SET utf8 NOT NULL COMMENT '上课地址',
  `course_weekdays`     VARCHAR(5)
                        CHARACTER SET utf8 NOT NULL COMMENT '周几上课',
  `course_time`         INT(1)             NOT NULL COMMENT '第几节课',
  `single_or_not`       INT(1)COMMENT '分周上课', /*0为所有周，1为单周，2为双周*/
  PRIMARY KEY (`course_id`),
  INDEX (`course_id`)
);
/*转存数据*/
ALTER TABLE `course_info`
  DISABLE KEYS;
/*在大批量导入时先禁用索引, 在完全导入后, 再开启索引, 一次性完成重建索引的效率会相对高很多*/
INSERT INTO `course_info` (`course_id`, `course_name`, `start_week`, `end_week`, `course_teacher_name`, `course_address`, `course_weekdays`, `course_time`, `single_or_not`)
VALUES
  (1, '可视化编程', 1, 15, '刘春', '5-403', '周一', 1, 0);
ALTER TABLE `course_info`
  ENABLE KEYS;


/**
下面是对于student_info数据表的定义
*/
DROP TABLE IF EXISTS `student_info`;
CREATE TABLE `student_info` (
  `ID`         INT(10) UNSIGNED   NOT NULL AUTO_INCREMENT COMMENT '学生编号',
  `student_id` VARCHAR(15)
               CHARACTER SET utf8 NOT NULL COMMENT '学生学号',
  `name`       VARCHAR(40)
               CHARACTER SET utf8 NOT NULL COMMENT '学生姓名',
  `phone`      VARCHAR(15)
               CHARACTER SET utf8 COMMENT '电话号码',
  `mail`       VARCHAR(30)
               CHARACTER SET utf8 COMMENT '邮箱地址',
  PRIMARY KEY (`ID`),
  INDEX (`ID`)
);

/*转存数据*/
ALTER TABLE `student_info`
  DISABLE KEYS;
INSERT INTO `student_info` (`ID`, `student_id`, `name`, `phone`, `mail`) VALUES
  (1, '0121510870325', '魏涛', '15871375510', '171395837@qq.com');
ALTER TABLE `student_info`
  ENABLE KEYS;


/**
下面是对数据表teacher_info的定义
*/
DROP TABLE IF EXISTS `teacher_info`;
CREATE TABLE `teacher_info` (
  `ID`         INT(10) UNSIGNED   NOT NULL AUTO_INCREMENT COMMENT '教师编号',
  `teacher_id` VARCHAR(15)
               CHARACTER SET utf8 NOT NULL COMMENT '教师学号',
  `name`       VARCHAR(40)
               CHARACTER SET utf8 NOT NULL COMMENT '教师姓名',
  `phone`      VARCHAR(15)
               CHARACTER SET utf8 COMMENT '电话号码',
  `mail`       VARCHAR(30)
               CHARACTER SET utf8 COMMENT '邮箱地址',
  PRIMARY KEY (`ID`),
  INDEX (`ID`)
);

/*转存数据*/
ALTER TABLE `teacher_info`
  DISABLE KEYS;
INSERT INTO `teacher_info` (`ID`, `teacher_id`, `name`, `phone`, `mail`) VALUES
  (1, '1', '刘春','123456798','546798123@qq.com');
ALTER TABLE `teacher_info`
  ENABLE KEYS;


/**
以下是对数据表student_match_course的定义
*/

DROP TABLE IF EXISTS `student_match_course`;
CREATE TABLE `student_match_course` (
  `student_id` INT(10) UNSIGNED NOT NULL COMMENT '学生编号',
  `course_id`  INT(10)          NOT NULL COMMENT '课程编号',
  INDEX (`student_id`)
);

/*转存数据*/
ALTER TABLE `student_match_course`
  DISABLE KEYS;
INSERT INTO `student_match_course` (`student_id`, `course_id`)
VALUES
  (1, 1);

ALTER TABLE `student_match_course`
  ENABLE KEYS;


/**
以下是对数据表teacher_match_course的定义
*/
DROP TABLE IF EXISTS `teacher_match_course`;
CREATE TABLE `teacher_match_course` (
  `teacher_id` INT(10) UNSIGNED NOT NULL COMMENT '教师编号',
  `course_id`  INT(10)          NOT NULL COMMENT '课程编号',
  INDEX (`teacher_id`)
);

/*转存数据*/
ALTER TABLE `teacher_match_course`
  DISABLE KEYS;
INSERT INTO `teacher_match_course` (`teacher_id`, `course_id`) VALUES
  (1, 1);
ALTER TABLE `teacher_match_course`
  ENABLE KEYS;


/**
以下是对lab_info数据表的定义
 */
DROP TABLE IF EXISTS `lab_info`;
CREATE TABLE `lab_info` (
  `id`          INT(10) UNSIGNED   NOT NULL COMMENT '实验室编号',
  `address`     VARCHAR(10)
                CHARACTER SET utf8 NOT NULL COMMENT '实验室地址',
  `equipment`   VARCHAR(10)
                CHARACTER SET utf8 NOT NULL COMMENT '实验室设备',
  `number`      INT(5) COMMENT '设备数量',
  `damaged_num` INT(5) COMMENT '损坏数量',
  PRIMARY KEY (`id`),
  INDEX (`id`)
);
/*转存数据*/
ALTER TABLE `lab_info`
  DISABLE KEYS;
INSERT INTO `lab_info` (`id`, `address`, `equipment`, `number`, `damaged_num`)
VALUES (1, '2-104', '电脑', 100, 0);
ALTER TABLE `lab_info`
  ENABLE KEYS;


/**
以下是对experiment_course数据表的定义
 */
DROP TABLE IF EXISTS `experiment_course`;
CREATE TABLE `experiment_course` (
  `id`                  INT(10) UNSIGNED   NOT NULL COMMENT '实验课编号',
  `course_name`         VARCHAR(20)
                        CHARACTER SET utf8 NOT NULL COMMENT '实验课名称',
  `course_address`      VARCHAR(20)
                        CHARACTER SET utf8 NOT NULL COMMENT '上课地址',
  `course_weekdays`     VARCHAR(5)
                        CHARACTER SET utf8 NOT NULL COMMENT '周几上课',
  `course_time`         INT(1)             NOT NULL COMMENT '第几节课',
  `course_teacher_name` VARCHAR(20)
                        CHARACTER SET utf8 NOT NULL COMMENT '教师姓名',
  `remarks` VARCHAR(100) CHARACTER SET utf8 COMMENT '备注',
  PRIMARY KEY (`id`)
);
ALTER TABLE `experiment_course`
  DISABLE KEYS;
INSERT INTO `experiment_course` (`id`, `course_name`, `course_address`, `course_weekdays`, `course_time`, `course_teacher_name`)
VALUES (1, '大物实验', '3-404', '周一', 1, '里霖');
ALTER TABLE `experiment_course`
  ENABLE KEYS;


/**
以下是对数据表teacher_match_experiment的定义
*/
DROP TABLE IF EXISTS `teacher_match_experiment`;
CREATE TABLE `teacher_match_experiment` (
  `teacher_id` INT(10) UNSIGNED NOT NULL COMMENT '教师编号',
  `course_id`  INT(10)          NOT NULL COMMENT '课程编号',
  PRIMARY KEY (`course_id`),
  INDEX (`teacher_id`)
);

/*转存数据*/
ALTER TABLE `teacher_match_experiment`
  DISABLE KEYS;
INSERT INTO `teacher_match_experiment` (`teacher_id`, `course_id`) VALUES
  (1, 1);
ALTER TABLE `teacher_match_experiment`
  ENABLE KEYS;


/**
以下是对数据表student_match_experiment的定义
*/
DROP TABLE IF EXISTS `student_match_experiment`;
CREATE TABLE `student_match_experiment` (
  `student_id` INT(10) UNSIGNED NOT NULL COMMENT '教师编号',
  `course_id`  INT(10)          NOT NULL COMMENT '课程编号',
  PRIMARY KEY (`course_id`),
  INDEX (`student_id`)
);

/*转存数据*/
ALTER TABLE `student_match_experiment`
  DISABLE KEYS;
INSERT INTO `student_match_experiment` (`student_id`, `course_id`) VALUES
  (1, 1);
ALTER TABLE `student_match_experiment`
  ENABLE KEYS;


/**
以下是对数据表lab_match_experiment的定义
*/
DROP TABLE IF EXISTS `lab_match_experiment`;
CREATE TABLE `lab_match_experiment` (
  `lab_id` INT(10) UNSIGNED NOT NULL COMMENT '教师编号',
  `course_id`  INT(10)          NOT NULL COMMENT '课程编号',
  PRIMARY KEY (`course_id`),
  INDEX (`lab_id`)
);

/*转存数据*/
ALTER TABLE `lab_match_experiment`
  DISABLE KEYS;
INSERT INTO `lab_match_experiment` (`lab_id`, `course_id`) VALUES
  (1, 1);
ALTER TABLE `lab_match_experiment`
  ENABLE KEYS;

/*添加外键约束*/
ALTER TABLE `teacher_match_experiment`ADD FOREIGN KEY (`teacher_id`) REFERENCES `experiment_course`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `student_match_experiment` ADD FOREIGN KEY (`student_id`) REFERENCES `experiment_course`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `lab_match_experiment` ADD FOREIGN KEY (`lab_id`) REFERENCES `experiment_course`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
