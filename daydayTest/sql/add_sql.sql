
-- 增加一名学生 学号为 08
SELECT * FROM `Student`;
INSERT INTO `Student` VALUES('08', '王八', '1999-01-09', '男');

-- 给 Score 表增加一项
SELECT * FROM `Score`;
INSERT INTO `Score` VALUES ('08', '01', 99);
INSERT INTO `Score` VALUES ('08', '02', 89);
DELETE FROM `Score` WHERE stu_id = '08' AND c_id = '02';

INSERT INTO `Course` VALUES('04', '生物', '06');

INSERT INTO `Score` VALUES ('07', '04', 89);

-- 增加一门课程给 张三老师测, 然后 09 号学生选择了该门课程并考试得分试以下题目：
-- 十三、查询没学过"张三"老师讲授的任一门课程的学生姓名
INSERT INTO `Course` VALUES ('05', '微积分', '01');
INSERT INTO `Score` VALUES('09', '05', 80);