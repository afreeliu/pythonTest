

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

-- 十一、查询至少有一门课与学号为" 07 "的同学所学相同的同学的信息
SELECT * FROM `Score`;
-- 1. 先查询 学号为‘07’的同学学习的课程
SELECT c_id FROM `Score` WHERE stu_id = '07';
-- 2. 再从 Score 成绩表中查询学号非‘07’的同学学习的课程
SELECT stu_id FROM `Score` WHERE Score.stu_id != '07' AND Score.c_id IN
	(SELECT c_id FROM `Score` WHERE Score.stu_id = '07') GROUP BY stu_id;
-- 3. 第2步骤中查到的学生的 stu_id 然后 联合 Student 表进行联查
SELECT * FROM `Student`, 
	(SELECT stu_id FROM `Score` WHERE Score.stu_id != '07' AND Score.c_id IN
	(SELECT c_id FROM `Score` WHERE Score.stu_id = '07') GROUP BY stu_id) t
WHERE Student.stu_id = t.stu_id;
-- 方式二，使用 RIGHT JOIN 的方式
SELECT * FROM `Student`
LEFT JOIN
(SELECT stu_id FROM `Score` WHERE Score.stu_id != '07' AND Score.c_id IN
	(SELECT c_id FROM `Score` WHERE Score.stu_id = '07') GROUP BY stu_id) t
ON Student.stu_id = t.stu_id;


-- 十二、查询和" 01 "号的同学学习的课程 完全相同的其他同学的信息
-- 原始思路就是：去查找 01 号同学学习的课程，那么这样的到的就是另一个表
-- 貌似 sql 中没有能进行比较两个表相等的方法，因此需要转化思路
-- 等价于修了和01相同课程，那么就是01没有修他们就没有修
-- 1. 查询 ‘01’学号的同学学习的课程
SELECT c_id FROM `Score` WHERE stu_id = '01';
-- 2. 查询Course 表中的课程，那些不在 步骤 1 中查询到的
SELECT c_id FROM `Course` 
WHERE c_id
NOT IN
(SELECT c_id FROM `Score` WHERE stu_id = '01');
-- 3. 
select count(stu_id) from `Score` where stu_id = '01';

-- 答案
select stu_id from `Score` 
where c_id 
not in 
	(select c_id from `Course` 
	 where c_id 
	 not in 
	 	(select c_id from `Score` where stu_id = '01')) 
group by stu_id
having count(stu_id) = (select count(stu_id) from `Score` where stu_id = '01');



-- 十三、查询没学过"张三"老师讲授的任一门课程的学生姓名
-- 1. 找出张三老师教授的课程的课程号
SELECT c_id FROM `Course`
WHERE `Course`.t_id 
IN (SELECT t_id FROM `Teacher` WHERE t_name = '张三');
-- 2. 找出选了课程的学生的编号，且选的课程中包含了02课程，即张三老师的课
SELECT * FROM `Score`
WHERE score.c_id IN
(SELECT c_id FROM `Course`
WHERE `Course`.t_id 
IN (SELECT t_id FROM `Teacher` WHERE t_name = '张三'));
-- 3. 根据第 2 步骤得到的学生的stu_id，然后从Student表中找出不在第 2 步骤的 学生的stu_id
SELECT * FROM `Student`
WHERE stu_id
NOT IN
	(SELECT stu_id FROM `Score`
	WHERE score.c_id IN
		(SELECT c_id FROM `Course`
		WHERE `Course`.t_id 
		IN (SELECT t_id FROM `Teacher` WHERE t_name = '张三')
	)
);


-- 十四、 查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩
SELECT * FROM `Score`;
-- 1. 先选择不及格的同学分别都列出来
SELECT * FROM `Score`
WHERE score < 60;
-- 2. 根据出现的 stu_id 的次数统计不及格的次数
SELECT stu_id, COUNT(stu_id) as low_count, SUM(score) as sum_score FROM `Score`
WHERE score < 60
GROUP BY stu_id;

SELECT stu_id, sum_score/low_count as avg_score FROM
(SELECT stu_id, COUNT(stu_id) as low_count, SUM(score) as sum_score  FROM `Score`
WHERE score < 60
GROUP BY stu_id) t
WHERE t.low_count > 1;

-- 十五、检索" 01 "课程分数小于 60，按分数降序排列的学生信息
-- 1. 先从 Score 表中找出 课程为 01 的 分数小于60分的学生的信息，Desc 的降序排列
SELECT * FROM `Score`
WHERE c_id = '01' AND score < 60
ORDER BY score DESC;

-- 2. 再从 Student 表中查询学生的信息，然后 Right Join 的方式插入到步骤1中查询到的信息中
SELECT * FROM `Student`
RIGHT JOIN
(
	SELECT * FROM `Score`
	WHERE c_id = '01' AND score < 60
	ORDER BY score DESC
) t
ON Student.stu_id = t.stu_id;


-- 十六、 按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩
-- 1. 先从 Score 表中计算出每个学生的平均成绩
SELECT stu_id, AVG(score) as avg_score FROM `Score`
GROUP BY stu_id;

-- 2. 再从 Score 中查询出学生的各科的成绩，然后把步骤 1 中的插入到对应的学号即可
SELECT * FROM `Score`
LEFT JOIN
(
	SELECT stu_id, AVG(score) as avg_score FROM `Score`
	GROUP BY stu_id
) t
ON Score.stu_id = t.stu_id
ORDER BY t.avg_score Desc;



-- 十七、查询各科成绩最高分、最低分和平均分：
-- 以如下形式显示：课程 ID，课程 name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率
-- 及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90
-- 要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列
-- 1. 先把成绩表 Score 按通过max，min，avg 函数找出来
SELECT c_id, MAX(score) as max_score, MIN(score) as min_score, AVG(score) as avg_score FROM `Score`
GROUP BY c_id;

-- 2. 从 课程表Course 中查找课程的信息然后把步骤 1 的结果对应插入到结果中
-- 得到表： 课程 ID，课程 name，最高分，最低分，平均分
SELECT Course.c_id, c_name, t.max_score, t.min_score, t.avg_score FROM `Course`
LEFT JOIN
(
	SELECT c_id, MAX(score) as max_score, MIN(score) as min_score, AVG(score) as avg_score FROM `Score`
	GROUP BY c_id
) t
ON Course.c_id = t.c_id;

-- 3.找出每一科的及格的个数
SELECT c_id, COUNT(*) as pass_count FROM `Score`
WHERE score > 60
GROUP BY c_id;
-- 4. 找出每一科的总人数
SELECT c_id, COUNT(*) as all_count FROM `Score`
GROUP BY c_id;
-- 5. 步骤 3 的及格的个数 / 步骤 4 的总人数的到及格率
SELECT p.c_id, p.pass_count/a.all_count as pass_rate FROM
(
	SELECT c_id, COUNT(*) as pass_count FROM `Score`
	WHERE score > 60
	GROUP BY c_id
) p
LEFT JOIN
(
	SELECT c_id, COUNT(*) as all_count FROM `Score`
	GROUP BY c_id
) a
ON p.c_id = a.c_id;
-- 以上方式可以慢慢一个一个找出来，但是不是比较好的方式，是没有使用sql中能使用函数方法的方式
-- 参考答案如下，使用sql中的函数可以更简洁书写
SELECT 	sc.c_id,
		c.c_name,
		sc.count_student,
		sc.max_score,
		sc.min_score,
		sc.avg_score,
		sc.pass_rate,
		sc.mid_rate,
		sc.good_rate,
		sc.excellent_rate
FROM
(
	SELECT c_id,
		count(*) as count_student,
		max(score) as max_score,
		min(score) as min_score,
		avg(score) as avg_score,
		SUM(case when score>=60 then 1 else 0 end)/COUNT(*) as pass_rate,
		SUM(case when score>=70 then 1 else 0 end)/COUNT(*) as mid_rate,
		SUM(case when score>=80 then 1 else 0 end)/COUNT(*) as good_rate,
		SUM(case when score>=90 then 1 else 0 end)/COUNT(*) as excellent_rate
	FROM Score
	GROUP BY c_id
) sc
LEFT JOIN
(
	SELECT * FROM Course
) c
ON sc.c_id = c.c_id
ORDER BY sc.count_student DESC, sc.c_id ASC;




-- 十八、按各科成绩进行排序，并显示排名， Score 重复时保留名次空缺
-- 这题不会做，直接看答案
SELECT c.c_id, c.stu_id, c.score, COUNT(c2.score) + 1 as ran
FROM Score as c
LEFT JOIN Score as c2
ON c.score < c2.score AND c.c_id = c2.c_id
GROUP BY c.c_id, c.stu_id, c.score
ORDER BY c.c_id, ran ASC;
-- 可以用变量，但也有更为简单的方法，即自交（左交）
-- 用sc中的score和自己进行对比，来计算“比当前分数高的分数有几个”。


-- 十八.1 按各科成绩进行排序，并显示排名， Score 重复时合并名次
-- 先 按各科成绩进行排序
SELECT sc1.stu_id, sc1.c_id, sc1.score, COUNT(sc2.score)+1 as ran FROM Score as sc1
LEFT JOIN
Score as sc2
ON sc1.score < sc2.score AND sc1.c_id = sc2.c_id
GROUP BY sc1.c_id, sc1.stu_id, sc1.score
ORDER BY sc1.c_id, ran ASC;



-- 十九、查询学生的总成绩，并进行排名，总分重复时不保留名次空缺
-- 不会做，这里主要学习一下使用变量。在SQL里面变量用@来标识。

set @crank=0;
SELECT t.stu_id, t.total, @crank := @crank+1 as ran FROM
(SELECT stu_id, SUM(score) as total
FROM `Score`
GROUP BY stu_id
ORDER BY total DESC) t;


-- 统计各科成绩各分数段人数：课程编号，课程名称，[100-85]，[85-70]，[70-60]，[60-0] 及所占百分比
SELECT 
t.c_name, t.c_id,
SUM(case when t.score > 85 then 1 else 0 end)/COUNT(*) as '[100-85]',
SUM(case when t.score > 70 AND t.score <= 85 then 1 else 0 end)/COUNT(*) as '[85-70]',
SUM(case when t.score > 60 AND t.score <= 70 then 1 else 0 end)/COUNT(*) as '[70-60]',
SUM(case when t.score > 0 AND t.score <= 60 then 1 else 0 end)/COUNT(*) as '[60-0]'
FROM
(SELECT c.c_name, sc.c_id, sc.score
FROM `Score` as sc
LEFT JOIN `Course` as c
ON sc.c_id = c.c_id) t
GROUP BY t.c_name, t.c_id;


-- 查询各科成绩前三名的记录
-- mysql不能group by 了以后取limit

-- 答案：1. 暴力方式
-- 计算比自己分数大的记录有几条，如果小于3 就select，
-- 因为对前三名来说不会有3个及以上的分数比自己大了，
-- 最后再对所有select到的结果按照分数和课程编号排名即可。
SELECT * FROM Score
WHERE
(
	SELECT COUNT(*) FROM Score as a
	WHERE score.c_id = a.c_id and Score.score < a.score
) < 3
ORDER BY c_id asc, Score.score DESC;

-- 答案：2. 自身左交
select a.stu_id,a.c_id,a.score from Score a 
left join Score b on a.c_id = b.c_id and a.score<b.score
group by a.c_id, a.stu_id
having count(b.c_id)<3
order by a.c_id;

-- 查询每门课程被选修的学生数
-- 1. 先从 Score 表中计算出每门课程的学生的数量
SELECT c_id, COUNT(stu_id) FROM `Score`
GROUP BY c_id;
-- 2. 将步骤 1 中得到的表 左交插入 Course 表中
SELECT c.c_id, c_name, t.stu_count FROM `Course` c
LEFT JOIN 
(SELECT c_id, COUNT(stu_id) as stu_count FROM `Score`
GROUP BY c_id) t
ON c.c_id = t.c_id;


-- 查询出只选修两门课程的学生学号和姓名

-- 1.得到 每个学生选修课的数量
SELECT t.stu_id, s.stu_name FROM
(SELECT stu_id, COUNT(stu_id) as s FROM `Score`
GROUP BY stu_id) t
LEFT JOIN `Student` s
ON t.stu_id = s.stu_id
WHERE t.s = 2;

-- 查询男生、女生人数
SELECT COUNT(
	stu_sex
) FROM `Student`
WHERE stu_sex = '男';


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

