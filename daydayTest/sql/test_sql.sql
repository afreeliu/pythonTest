

-- 一、查询 01课程 比 02课程 成绩高的学生的信息及课程分数
-- 1. 查询课程 01 的学生的信息 和 分数
SELECT stu_id, score AS class1 FROM Score WHERE c_id = 01;
-- 2. 查询课程 02 的学生的信息 和 分数 
SELECT stu_id, score AS class2 FROM Score WHERE c_id = 02;
-- 3. 从上面两张表中 查询 课程01 比 课程02 的分数打的课程和 学生ID
SELECT t1.stu_id, class1, class2 FROM
	(SELECT stu_id, score AS class1 FROM Score WHERE c_id = 01) AS t1,
	(SELECT stu_id, score AS class2 FROM Score WHERE c_id = 02) AS t2
	WHERE t1.stu_id = t2.stu_id AND t1.class1 > t2.class2;
-- 4. 最后，查询学生的表格，然后学生表的 stu_id 和 上面得到的 stu_id 相等
SELECT * FROM Student RIGHT JOIN(
	SELECT t1.stu_id, class1, class2 FROM
		(SELECT stu_id, score AS class1 FROM Score WHERE c_id = 01) AS t1,
		(SELECT stu_id, score AS class2 FROM Score WHERE c_id = 02) AS t2
			WHERE t1.stu_id = t2.stu_id AND t1.class1 > t2.class2
)r
ON Student.stu_id = r.stu_id;

-- 4.1 第二种方式使用 LEFT JOIN 
SELECT * FROM (
	SELECT t1.stu_id, class1, class2 
	FROM
		(SELECT stu_id, score AS class1 FROM Score WHERE c_id = 01) AS t1,
		(SELECT stu_id, score AS class2 FROM Score WHERE c_id = 02) AS t2
	WHERE t1.stu_id = t2.stu_id AND t1.class1 > t2.class2
)r 
LEFT JOIN Student
ON Student.stu_id = r.stu_id;


-- -------------------------------------------------------------------------------


-- 二、 查询同时存在 01课程 和 02课程 的情况
-- 1. 分别先查询 01课程 和 02课程
SELECT stu_id, c_id AS class1 FROM Score WHERE c_id = 01;
SELECT stu_id, c_id AS class2 FROM Score WHERE c_id = 02;

-- 2. 然后查询分同时有 01课程 和 02课程 的信息
SELECT t1.stu_id, class1, class1_score, class2, class2_score FROM 
	(SELECT stu_id, c_id AS class1, score AS class1_score FROM Score WHERE c_id = 01) AS t1,
	(SELECT stu_id, c_id AS class2, score AS class2_score FROM Score WHERE c_id = 02) AS t2
WHERE t1.stu_id = t2.stu_id;

-- 3. 最后 根据查询的再匹配学生Student 表的学生的信息
SELECT * FROM Student RIGHT JOIN (
	SELECT t1.stu_id, class1, class1_score, class2, class2_score FROM
		(SELECT stu_id, c_id AS class1, score AS class1_score FROM Score WHERE c_id = 01) AS t1,
		(SELECT stu_id, c_id AS class2, score AS class2_score FROM Score WHERE c_id = 02) AS t2
	WHERE t1.stu_id = t2.stu_id
)r 
ON Student.stu_id = r.stu_id;


-- 三、查询存在 01课程 但可能不存在 02课程 的情况（不存在时可以显示为null）
-- 1. 先查询 02课程的数据
SELECT stu_id, c_id AS class2, score FROM Score WHERE c_id = 02;
-- 2. 查询 01课程的数据
SELECT stu_id, c_id AS class1, score FROM Score WHERE c_id = 01;
-- 3. 从以上两个数据中查询相关的数据，且比较存在01而不存在02的数据
SELECT t1.stu_id, t1.class1, t1.score AS class1_score, t2.class2, t2.score AS class2_score FROM
	(SELECT stu_id, c_id AS class1, score FROM Score WHERE c_id = 01) AS t1
LEFT JOIN
	(SELECT stu_id, c_id AS class2, score FROM Score WHERE c_id = 02) AS t2
ON t1.stu_id = t2.stu_id;


SELECT * FROM Score;

-- 四、 查询不存在 01课程 但存在 02课程的情况
SELECT * FROM `Score`;
--1. 先查询存在 01课程的 学生的学号
SELECT stu_id FROM Score WHERE c_id = 01;
-- 2. 查询存在 02课程的 学生的学号
SELECT stu_id FROM `Score` WHERE c_id = 02;
-- 3. 最后 在不存在 01课程的数据中查询存在 02课程的数据
SELECT * FROM `Score`
WHERE Score.stu_id NOT IN
	(SELECT stu_id FROM `Score`
	 WHERE c_id = 01
	)
AND Score.c_id = 02;
SELECT * FROM `Student`
RIGHT JOIN
(SELECT score, stu_id FROM `Score`
WHERE Score.c_id = 2 
AND Score.stu_id NOT IN
(
	SELECT stu_id FROM `Score`
	WHERE c_id = 01
)
) sc
ON sc.stu_id = Student.stu_id;





-- 五、 查询平均成绩大于等于 60 分的同学的学生编号和学生姓名和平均成绩
SELECT * FROM `Score`;
-- 1. 查询每个同学的所有成绩以及课程的数量
SELECT stu_id, SUM(score) as sum_score, COUNT(stu_id) as class_count FROM `Score`
GROUP BY stu_id;
-- 2. 计算每个同学的平均分
SELECT * FROM `Student`
RIGHT JOIN
(SELECT stu_id, sum_score/class_count as arg FROM
(SELECT stu_id, SUM(score) as sum_score, COUNT(stu_id) as class_count FROM `Score`
GROUP BY stu_id) sc_sum WHERE  sum_score/class_count > 60) r
ON Student.stu_id = r.stu_id;

SELECT stu_id, stu_name FROM `Student`
RIGHT JOIN
(SELECT * FROM
(SELECT stu_id, sum_score/class_count as arg FROM
(SELECT stu_id, SUM(score) as sum_score, COUNT(stu_id) as class_count FROM `Score`
GROUP BY stu_id) sc_sum) sc_arg
WHERE sc_arg.arg > 60) las
ON Student.stu_id = las.stu_id;