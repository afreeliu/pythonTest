
-- 给 Score 表增加一项
SELECT * FROM `Score`;
INSERT INTO `Score` VALUES ('08', '01', 99);
INSERT INTO `Score` VALUES ('08', '02', 89);
DELETE FROM `Score` WHERE stu_id = '08' AND c_id = '02';

INSERT INTO `Course` VALUES('04', '生物', '06');

INSERT INTO `Score` VALUES ('07', '04', 89);