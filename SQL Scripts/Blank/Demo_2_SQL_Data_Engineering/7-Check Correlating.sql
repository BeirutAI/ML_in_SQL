-------------------------------------------------------------------------------
--Find correlation between Age and survival rate
Select	
	______,
	AVG(CAST(______ AS DECIMAL(12,2))) as mean
From Train
group by Age
order by Age asc


--Find correlation between Pclass and survival rate
Select	
	______,
	AVG(CAST(______ AS DECIMAL(12,2))) as mean,
	(Select count(*) from Train T where T.Pclass = A.Pclass) as Count
From Train A
group by Pclass
order by mean desc

--Find correlation between Sex and survival rate
Select	
	______,
	AVG(CAST(______ AS DECIMAL(12,2))) as mean,
	(Select count(*) from Train T where T.Sex = A.Sex) as Count
From Train A
group by Sex
order by mean desc

--Find correlation between SibSp and survival rate
Select	
	______,
	AVG(CAST(______ AS DECIMAL(12,2))) as mean
From Train
group by SibSp
order by mean desc

--Find correlation between Parch and survival rate
Select	
	______,
	AVG(CAST(______ AS DECIMAL(12,2))) as mean
From Train
group by Parch
order by mean desc
