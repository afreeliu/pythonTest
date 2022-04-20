

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
-- 2. 计算每个同学的平均分，提取出大于60分的学生的信息
SELECT * FROM `Student`
RIGHT JOIN
(SELECT stu_id, sum_score/class_count as arg FROM
(SELECT stu_id, SUM(score) as sum_score, COUNT(stu_id) as class_count FROM `Score`
GROUP BY stu_id) sc_sum WHERE  sum_score/class_count > 60) r
ON Student.stu_id = r.stu_id;

-- 六、查询在 Score 表存在成绩的学生信息
SELECT * FROM `Score`;

-- 1. 查询在 Score 表中存在成绩的学生的信息，即去重：可以使用 DISTINCT 关键字
SELECT DISTINCT stu_id FROM `Score`;

-- 2. 查询学生表中的学生的信息
SELECT * FROM `Student`;

-- 3. 把学生表中的信息插入到 1 中查询到的内容
SELECT * FROM `Student`
RIGHT JOIN
	(SELECT stu_id FROM `Score`
	 GROUP BY stu_id) r
ON Student.stu_id = r.stu_id;

-- 答案
select DISTINCT Student.*
from Student,Score
where student.stu_id = Score.stu_id;


-- 七、查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩(没成绩的显示为 null )
-- 1. 查询学生的信息：学生编号，学生姓名，选课总数，所有课程的总成绩
SELECT stu_id, stu_name FROM `Student`;
-- 2. 在成绩表中，找到同一个学生的信息，计算该学生的课程数量以及课程总成绩
SELECT stu_id, COUNT(stu_id) as class_count, SUM(score) as sum_score FROM `Score` GROUP BY stu_id;
-- 3. 把 步骤 2 中查询的结果 LEFT JOIN 到 步骤 1 中
SELECT Student.stu_id, stu_name, r.class_count, r.sum_score FROM `Student`
LEFT JOIN
	(SELECT stu_id, COUNT(stu_id) as class_count, SUM(score) as sum_score 
	 FROM `Score` 
	 GROUP BY stu_id) r
ON Student.stu_id = r.stu_id;
-- 答案 
-- 该方式为联合查找，联合查找的方式不能达到题目要求显示所有的学生信息，并现在没有课程和分数的为null
select student.stu_id, student.stu_name, r.coursenumber, r.scoresum
from `Student`,
(select Score.stu_id, sum(Score.score) as scoresum, count(Score.c_id) as coursenumber from `Score` 
group by Score.stu_id)r
where student.stu_id = r.stu_id;
-- 因为上面的方式无法满足要求，因此需要使用 JOIN 的方式，自己写的join的方式符合


-- 八、查有成绩的学生信息
-- 说明：因为没有要求显示所有学生信息，没有要求没成绩的学生的成绩显示为null，因此可以使用联合查找
-- 1. 先查找成绩表 Score 找出有成绩的学生的stu_id 并使用关键字DISTINCT 去重， 然后联合查找 Student表
SELECT DISTINCT Score.stu_id, Student.stu_name, Student.stu_age, Student.stu_sex FROM `Score`, Student
WHERE Score.stu_id = Student.stu_id;

-- 查询「李」姓老师的数量
SELECT * FROM `Teacher`;
SELECT COUNT(*) FROM `Teacher`
WHERE t_name LIKE '李%';

select count(*)
from `Teacher`
where t_name like '李%';

-- 九、查询学过「张三」老师授课的同学的信息
-- 1. 先通过联合查找 Teacher 表和 Course表 找出张三老师授课的课程信息
SELECT  Teacher.t_id, Teacher.t_name, Course.c_id, Course.c_name FROM `Course`, Teacher
WHERE `Course`.t_id = Teacher.t_id AND Teacher.t_name = '张三';
-- 2. 通过第1个步骤，我们可以知道张三老师的授课课程为02，从成绩表中找出含有课程c_id=02的学生
SELECT t.t_id, t.t_name, Score.c_id, t.c_name, score, Score.stu_id FROM Score, 
	(SELECT  Teacher.t_id, Teacher.t_name, Course.c_id, Course.c_name FROM `Course`, Teacher
	WHERE `Course`.t_id = Teacher.t_id AND Teacher.t_name = '张三') t
WHERE Score.c_id = t.c_id;
-- 3.最后，使用 LEFT JOIN 或者 RIGHT JOIN 把查找到的Student数据中匹配步骤 2 中的数据，根据stud_id
SELECT * FROM 
	(SELECT t.t_id, t.t_name, Score.c_id, t.c_name, score, Score.stu_id FROM Score, 
		(SELECT  Teacher.t_id, Teacher.t_name, Course.c_id, Course.c_name FROM `Course`, Teacher
		WHERE `Course`.t_id = Teacher.t_id AND Teacher.t_name = '张三') t
	WHERE Score.c_id = t.c_id) sc
LEFT JOIN `Student`
ON sc.stu_id = Student.stu_id;

-- 十、查询没有学全所有课程的同学的信息
-- 1. 先查询课程表中有多少门课程，即课程的数量
SELECT COUNT(c_id) as class_count FROM `Course`;

-- 2.查询成绩表中统计有三门成绩的学生的信息
SELECT stu_id, COUNT(score) as class_count FROM `Score` GROUP BY stu_id;

-- 3. 根据 Score 中 以 stu_id 进行分组，然后计算分组中出现了分数的次数 等于 课程的数量，这时候需要使用到的关键字 HAVING
--having字句可以让我们筛选分组之后的各种数据，where字句在聚合前先筛选记录，也就是说作用在group by和having字句前。
--而having子句在聚合后对组记录进行筛选。我的理解就是真实表中没有此数据，这些数据是通过一些函数产生的
SELECT stu_id FROM `Score` 
GROUP BY stu_id
HAVING COUNT(score) = (SELECT COUNT(c_id) FROM `Course`);

-- 4.最后 查询学生表 Student 中所有学生的信息，然后判断 对应的stu_id 不在(NOT IN) 步骤 3 中查询到的数据中即可
SELECT * FROM `Student`
WHERE Student.stu_id 
NOT IN
(SELECT stu_id FROM `Score` 
GROUP BY stu_id
HAVING COUNT(score) = (SELECT COUNT(c_id) FROM `Course`));

-- 查询至少有一门课与学号为" 01 "的同学所学相同的同学的信息

-- 查询和" 01 "号的同学学习的课程 完全相同的其他同学的信息

-- 查询没学过"张三"老师讲授的任一门课程的学生姓名

-- 查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩

-- 检索" 01 "课程分数小于 60，按分数降序排列的学生信息

-- 按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩

-- 查询各科成绩最高分、最低分和平均分：

-- 以如下形式显示：课程 ID，课程 name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率

-- 及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90

-- 要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列

-- 按各科成绩进行排序，并显示排名， Score 重复时保留名次空缺
-- 15.1 按各科成绩进行排序，并显示排名， Score 重复时合并名次

-- 查询学生的总成绩，并进行排名，总分重复时保留名次空缺
-- 16.1 查询学生的总成绩，并进行排名，总分重复时不保留名次空缺

-- 统计各科成绩各分数段人数：课程编号，课程名称，[100-85]，[85-70]，[70-60]，[60-0] 及所占百分比

-- 查询各科成绩前三名的记录

-- 查询每门课程被选修的学生数

-- 查询出只选修两门课程的学生学号和姓名

-- 查询男生、女生人数

-- 查询名字中含有「风」字的学生信息

-- 查询同名同性学生名单，并统计同名人数

-- 查询 1990 年出生的学生名单

-- 查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列

-- 查询平均成绩大于等于 85 的所有学生的学号、姓名和平均成绩

-- 查询课程名称为「数学」，且分数低于 60 的学生姓名和分数

-- 查询所有学生的课程及分数情况（存在学生没成绩，没选课的情况）

-- 查询任何一门课程成绩在 70 分以上的姓名、课程名称和分数

-- 查询不及格的课程

-- 查询课程编号为 01 且课程成绩在 80 分以上的学生的学号和姓名

-- 求每门课程的学生人数

-- 成绩不重复，查询选修「张三」老师所授课程的学生中，成绩最高的学生信息及其成绩

-- 成绩有重复的情况下，查询选修「张三」老师所授课程的学生中，成绩最高的学生信息及其成绩

-- 查询不同课程成绩相同的学生的学生编号、课程编号、学生成绩

-- 查询每门功成绩最好的前两名

-- 统计每门课程的学生选修人数（超过 5 人的课程才统计）。

-- 检索至少选修两门课程的学生学号

-- 查询选修了全部课程的学生信息

-- 查询各学生的年龄，只按年份来算

-- 按照出生日期来算，当前月日 < 出生年月的月日则，年龄减一

-- 查询本周过生日的学生

-- 查询下周过生日的学生

-- 查询本月过生日的学生

-- 查询下月过生日的学生

