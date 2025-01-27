USE [etl_ssis_car_insurance]
GO

SELECT [Policy_ID]
      ,[AGE]
      ,[G_ID]
      ,[GENDER]
      ,[R_ID]
      ,[RACE]
      ,[DRIVING_EXPERIENCE]
      ,[E_ID]
      ,[EDUCATION]
      ,[I_ID]
      ,[INCOME]
      ,[CREDIT_SCORE]
      ,[VEHICLE_OWNERSHIP]
      ,[VEHICLE_YEAR]
      ,[MARRIED]
      ,[CHILDREN]
      ,[POSTAL_CODE]
      ,[ANNUAL_MILEAGE]
      ,[VT_ID]
      ,[VEHICLE_TYPE]
      ,[SPEEDING_VIOLATIONS]
      ,[DUIS]
      ,[PAST_ACCIDENTS]
      ,[OUTCOME]
  FROM [dbo].[VINC]

GO

Select Distinct G_id,Gender from VINC
--select * into New_table from Old_table
-- creating sub table 
select Distinct G_id, Gender into GT from VINC
select * from GT

---creating for other colummns
select Distinct R_id, RACE into RT from VINC
select Distinct E_id, Education into ET from VINC
select Distinct I_id, Income into IT from VINC
select Distinct VT_ID, Vehicle_Type into VT from VINC

--printing all the info in the newly created tables
select * from RT
select * from ET
select * from IT
select * from VT
-- finding all the tables in the database
select * from Information_schema.tables

--fact table
select * from VINC

select [Policy_ID],AGE,G_ID,R_ID,E_ID,I_ID,CREDIT_SCORE,VEHICLE_OWNERSHIP,
VEHICLE_YEAR,MARRIED,CHILDREN,POSTAL_CODE,ANNUAL_MILEAGE,VT_ID,SPEEDING_VIOLATIONS,
DUIS,PAST_ACCIDENTS,OUTCOME from VINC

select [Policy_ID],AGE,G_ID,R_ID,E_ID,I_ID,CREDIT_SCORE,VEHICLE_OWNERSHIP,
VEHICLE_YEAR,MARRIED,CHILDREN,POSTAL_CODE,ANNUAL_MILEAGE,VT_ID,SPEEDING_VIOLATIONS,
DUIS,PAST_ACCIDENTS,OUTCOME into FT from VINC

-- finding all teh columns in all teh tables

select * from GT
select * from RT
select * from ET
select * from IT
select * from VT
select * from FT

-- now making connection between all the tables
-- first is GT where am adding the primary and the foreign key, before this, 
--am making all the values of G_ID as not null
alter table GT
alter column G_ID nvarchar(255) not null

alter table GT
add primary key (G_ID)

alter table FT
add foreign key (G_ID) references GT(G_ID)

-- now creating for Education table
alter table ET
alter column E_ID float not null

alter table ET
add primary key (E_ID)

alter table FT
add foreign key (E_ID) references ET(E_ID)

-- now creating for Race table
alter table RT
alter column R_ID nvarchar(255) not null

alter table RT
add primary key (R_ID)

alter table FT
add foreign key (R_ID) references RT(R_ID)

---- now creating for Income table
alter table IT
alter column I_ID float not null

alter table IT
add primary key (I_ID)

alter table FT
add foreign key (I_ID) references IT(I_ID)

-- now creating for Vehicle table
alter table VT
alter column VT_ID float not null

alter table VT
add primary key (VT_ID)

alter table FT
add foreign key (VT_ID) references VT(VT_ID)

---
SELECT COUNT(Policy_ID) FROM ft;

--letf joins
---
SELECT GT.GENDER,COUNT(Policy_ID) FROM ft
left join GT on ft.G_id= GT.G_ID group by GT.GENDER
