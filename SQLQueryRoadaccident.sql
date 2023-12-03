-- xem tổng quan dữ liệu 
SELECT * FROM [Road Accident Data]
-- kiểm tra các cột có bị trống 
SELECT COUNT(*) Missing_value
FROM [Road Accident Data]
WHERE Accident_Index IS NULL OR Accident_Severity IS NULL or Accident_Date IS NULL OR Light_Conditions IS NULL OR Number_of_Casualties IS NULL OR Vehicle_Type IS NULL
-- Kiểm tra các giá trị có sai chính tả
SELECT DISTINCT Junction_Control
FROM [Road Accident Data]

SELECT DISTINCT Accident_Severity
FROM [Road Accident Data]

SELECT DISTINCT Light_Conditions
FROM [Road Accident Data]
-- Số người bị thương và tử vong
SELECT SUM(Number_of_Casualties) Number_of_Casualties
FROM [Road Accident Data]
--Số người bị thương dựa trên Accident_Severity
SELECT Accident_Severity, SUM(Number_of_Casualties) Number_of_Casualties
FROM [Road Accident Data]
GROUP BY Accident_Severity
ORDER BY SUM(Number_of_Casualties) 

--
-- Số lượng người tử vong trong từng loại phương tiện 
SELECT 
    CASE 
        WHEN Vehicle_Type LIKE '%car%' THEN 'Car'
        WHEN Vehicle_Type LIKE '%bus%' THEN 'Bus'
        WHEN Vehicle_Type LIKE '%Goods%' THEN 'Goods'
        WHEN Vehicle_Type LIKE '%Motorcycle%' THEN 'Motorcycle'
        WHEN Vehicle_Type LIKE '%Agricultural%' THEN 'Agricultural Vehicle'
        ELSE 'Others' 
    END AS new_vehicle_type,
    SUM(Number_of_Casualties) AS Number_of_Casualties
FROM [Road Accident Data]
GROUP BY 
    CASE 
        WHEN Vehicle_Type LIKE '%car%' THEN 'Car'
        WHEN Vehicle_Type LIKE '%bus%' THEN 'Bus'
        WHEN Vehicle_Type LIKE '%Goods%' THEN 'Goods'
        WHEN Vehicle_Type LIKE '%Motorcycle%' THEN 'Motorcycle'
        WHEN Vehicle_Type LIKE '%Agricultural%' THEN 'Agricultural Vehicle'
        ELSE 'Others' 
    END
ORDER BY Number_of_Casualties;

-- xem lượng thương vong mỗi tháng theo từng năm
WITH t1 AS (SELECT DATEPART(month, Accident_date) AS truncated_month, SUM(Number_of_Casualties) AS Number_of_Casualties
FROM [Road Accident Data]
WHERE DATEPART(year, Accident_date) = 2021
GROUP BY DATEPART(month, Accident_date)),
t2 AS (SELECT DATEPART(month, Accident_date) AS truncated_month, SUM(Number_of_Casualties) AS Number_of_Casualties
FROM [Road Accident Data]
WHERE DATEPART(year, Accident_date) = 2022
GROUP BY DATEPART(month, Accident_date))

SELECT t1.truncated_month, t1.Number_of_Casualties AS Number_of_Casualties_2021, t2.Number_of_Casualties AS Number_of_Casualties_2022
FROM t1 
JOIN t2 ON t1.truncated_month = t2.truncated_month;

SELECT DATEPART(month, Accident_date) AS truncated_month,DATEPART(year, Accident_date) truncated_year,SUM(Number_of_Casualties) AS Number_of_Casualties
FROM [Road Accident Data]
GROUP BY DATEPART(month, Accident_date),DATEPART(year, Accident_date)
ORDER BY DATEPART(month, Accident_date),DATEPART(year, Accident_date)

--xem xét số lượng thương vong và mức độ nguy hiểm theo từng chỉ tiêu
SELECT Road_Type, Accident_Severity,SUM(Number_of_Casualties) Number_of_Casualties
FROM [Road Accident Data]
GROUP BY Road_Type,Accident_Severity

SELECT Road_Surface_Conditions, Accident_Severity,SUM(Number_of_Casualties) Number_of_Casualties
FROM [Road Accident Data]
GROUP BY Road_Surface_Conditions,Accident_Severity

SELECT Urban_or_Rural_Area, Accident_Severity,SUM(Number_of_Casualties) Number_of_Casualties
FROM [Road Accident Data]
GROUP BY Urban_or_Rural_Area,Accident_Severity

SELECT Light_Conditions, Accident_Severity,SUM(Number_of_Casualties) Number_of_Casualties
FROM [Road Accident Data]
GROUP BY Light_Conditions,Accident_Severity