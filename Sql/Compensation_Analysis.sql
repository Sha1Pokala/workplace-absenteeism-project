--create a join table
select * from dbo.Absenteeism_at_work a 
left join dbo.compensation b 
on a.ID= b.ID
left join dbo.Reasons r
on  a.Reason_for_absence=r.Number;

--Find the Healthiest Employees for the Bonus

select * from Absenteeism_at_work 
where Social_drinker=0 and Social_smoker=0
and Body_mass_index<25 
and Absenteeism_time_in_hours < (select AVG(Absenteeism_time_in_hours) from Absenteeism_at_work);

--Compensation rate increase for Non-Smokers / Budget is $983,221 so 0.68 increase per Hour/ $1,414.4 per Year.
select count(*) as nonsmokers 
from Absenteeism_at_work where Social_smoker=0;


--optiminize the query
select a.ID,r.Reason, a.Body_mass_index,Month_of_absence,
CASE WHEN a.Body_mass_index<18.5 then ' UnderWeight'
     WHEN a.Body_mass_index between 18.5 and 25 then 'Healthy Weight'
     WHEN Body_mass_index between 25 and 30 then 'OverWeight' 
     WHEN Body_mass_index> 18.5 then 'Obese'
     ELSE 'Unknown' end as BMI_Category,
CASE when Month_of_absence IN (12,1,2) Then 'Winter'
     when Month_of_absence IN (3,4,5) Then 'Spring'
     when Month_of_absence IN (6,7,8) Then 'Summer'
     when Month_of_absence IN (9,10,11) Then 'Fall'
     ELSE 'Unkown' END as Season_Names, 
 Day_of_the_week,Transportation_expense,Education,Son,
 Social_drinker,Social_smoker,Pet,Disciplinary_failure,
 Age, Work_load_Average_day, Absenteeism_time_in_hours
from dbo.Absenteeism_at_work a 
left join dbo.compensation b 
on a.ID= b.ID
left join dbo.Reasons r
on  a.Reason_for_absence=r.Number;


select min(age) from dbo.Absenteeism_at_work;