
/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables dim_patient
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/
select *
from [gold].[dim_patient]


--dim_patient EDA
select distinct count(*) as total_patients
from [gold].[dim_patient]

--patient segmentation by state and gender
select 
	state,
	gender, 
	count (*) as total_patients
from [gold].[dim_patient]
group by state, gender
order by state, total_patients desc

--patient segmentation by marital status
select 
	maritalstatus,
	count (*) as total_patients
from [gold].[dim_patient]
group by maritalstatus
order by total_patients desc

--patient info
select 
	DATEDIFF(year, MIN(BirthDate), GETDATE()) AS oldest_patient_age_years,
    DATEDIFF(year, MAX(BirthDate), GETDATE()) AS youngest_patient_age_years
from [gold].[dim_patient]

--patient background 
select distinct language
from [gold].[dim_patient]
