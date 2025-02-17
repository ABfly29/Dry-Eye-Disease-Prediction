Create Table eyess(
Gender	varchar(20),
Age	 int,
Sleep_duration decimal(10,2),	
Sleep_quality	int,
Stress_level	int,
Blood_pressure	text,
Heart_rate	int,
Daily_steps	int,
Physical_activity int,	
Height	int,
Weight	int,
Sleep_disorder int,	
Wake_up_during_night	int,
Feel_sleepy_during_day	int,
Caffeine_consumption	int,
Alcohol_consumption	int,
Smoking	int,
Medical_issue	int,
Ongoing_medication	int,
Smart_device_before_bed	 int,
Average_screen_time	decimal(10,2),
Blue_light_filter	int,
Discomfort_Eye_strain	int,
Redness_in_eye  int,
Itchiness_Irritation_in_eye	 int,
Dry_Eye_Disease int
);

select * from eyess

--How do stress levels, daily steps, caffeine consumption, and screen time impact sleep quality?

WITH SleepFactors AS (
    SELECT 
        Sleep_Quality,
        AVG(Stress_Level) AS Avg_Stress_Level,
        AVG(Daily_Steps) AS Avg_Daily_Steps,
        AVG(Caffeine_Consumption) AS Avg_Caffeine_Consumption,
        AVG(Average_Screen_Time) AS Avg_Screen_Time
    FROM eyess  -- Using the correct table name
    GROUP BY Sleep_Quality
),
RankedData AS (
    SELECT 
        Sleep_Quality,
        Avg_Stress_Level,
        Avg_Daily_Steps,
        Avg_Caffeine_Consumption,
        Avg_Screen_Time,
        RANK() OVER (ORDER BY Avg_Stress_Level DESC) AS Stress_Rank,
        RANK() OVER (ORDER BY Avg_Daily_Steps ASC) AS Steps_Rank,
        RANK() OVER (ORDER BY Avg_Caffeine_Consumption DESC) AS Caffeine_Rank,
        RANK() OVER (ORDER BY Avg_Screen_Time DESC) AS Screen_Time_Rank
    FROM SleepFactors
)
SELECT 
    Sleep_Quality,
    Avg_Stress_Level,
    Avg_Daily_Steps,
    Avg_Caffeine_Consumption,
    Avg_Screen_Time,
    Stress_Rank,
    Steps_Rank,
    Caffeine_Rank,
    Screen_Time_Rank
FROM RankedData;


--"How does digital screen usage before bed impact sleep quality and eye health?"

WITH SleepFactors AS (
    SELECT 
        Sleep_Quality,
        AVG(Stress_Level) AS Avg_Stress_Level,
        AVG(Daily_Steps) AS Avg_Daily_Steps,
        AVG(Caffeine_Consumption) AS Avg_Caffeine_Consumption,
        AVG(Average_Screen_Time) AS Avg_Screen_Time
    FROM eyess
    GROUP BY Sleep_Quality
),
RankedData AS (
    SELECT 
        Sleep_Quality,
        Avg_Stress_Level,
        Avg_Daily_Steps,
        Avg_Caffeine_Consumption,
        Avg_Screen_Time,
        RANK() OVER (ORDER BY Avg_Stress_Level DESC) AS Stress_Rank,
        RANK() OVER (ORDER BY Avg_Daily_Steps ASC) AS Steps_Rank,
        RANK() OVER (ORDER BY Avg_Caffeine_Consumption DESC) AS Caffeine_Rank,
        RANK() OVER (ORDER BY Avg_Screen_Time DESC) AS Screen_Time_Rank
    FROM SleepFactors
)
SELECT 
    Sleep_Quality,
    Avg_Stress_Level,
    Avg_Daily_Steps,
    Avg_Caffeine_Consumption,
    Avg_Screen_Time,
    Stress_Rank,
    Steps_Rank,
    Caffeine_Rank,
    Screen_Time_Rank
FROM RankedData;

--Impact of Lifestyle Factors on Sleep Quality

WITH SleepFactors AS (
    SELECT 
        Sleep_Quality,
        AVG(Stress_Level) AS Avg_Stress_Level,
        AVG(Daily_Steps) AS Avg_Daily_Steps,
        AVG(Caffeine_Consumption) AS Avg_Caffeine_Consumption,
        AVG(Average_Screen_Time) AS Avg_Screen_Time
    FROM eyess
    GROUP BY Sleep_Quality
),
RankedData AS (
    SELECT 
        Sleep_Quality,
        Avg_Stress_Level,
        Avg_Daily_Steps,
        Avg_Caffeine_Consumption,
        Avg_Screen_Time,
        RANK() OVER (ORDER BY Avg_Stress_Level DESC) AS Stress_Rank,
        RANK() OVER (ORDER BY Avg_Daily_Steps ASC) AS Steps_Rank,
        RANK() OVER (ORDER BY Avg_Caffeine_Consumption DESC) AS Caffeine_Rank,
        RANK() OVER (ORDER BY Avg_Screen_Time DESC) AS Screen_Time_Rank
    FROM SleepFactors
)
SELECT 
    Sleep_Quality,
    Avg_Stress_Level,
    Avg_Daily_Steps,
    Avg_Caffeine_Consumption,
    Avg_Screen_Time,
    Stress_Rank,
    Steps_Rank,
    Caffeine_Rank,
    Screen_Time_Rank
FROM RankedData;

--Digital Screen Usage and Eye Health

WITH ScreenImpact AS (
    SELECT 
        Sleep_Quality,
        COUNT(*) AS Total_People,
        SUM(Smart_Device_Before_Bed) AS Smart_Device_Users,
        SUM(Blue_Light_Filter) AS Blue_Light_Users,
        SUM(Discomfort_Eye_Strain) AS Eye_Strain_Cases,
        SUM(Redness_In_Eye) AS Redness_Cases,
        SUM(Itchiness_Irritation_In_Eye) AS Irritation_Cases,
        SUM(Dry_Eye_Disease) AS Dry_Eye_Cases,
        SUM(Sleep_Disorder) AS Sleep_Disorder_Cases,
        SUM(Wake_Up_During_Night) AS Night_Waking_Cases
    FROM eyess
    GROUP BY Sleep_Quality
)
SELECT 
    Sleep_Quality,
    Total_People,
    Smart_Device_Users,
    (Smart_Device_Users * 100.0 / Total_People) AS Smart_Device_Percentage,
    Blue_Light_Users,
    (Blue_Light_Users * 100.0 / Total_People) AS Blue_Light_Percentage,
    Eye_Strain_Cases,
    (Eye_Strain_Cases * 100.0 / Total_People) AS Eye_Strain_Percentage,
    Redness_Cases,
    (Redness_Cases * 100.0 / Total_People) AS Redness_Percentage,
    Irritation_Cases,
    (Irritation_Cases * 100.0 / Total_People) AS Irritation_Percentage,
    Dry_Eye_Cases,
    (Dry_Eye_Cases * 100.0 / Total_People) AS Dry_Eye_Percentage,
    Sleep_Disorder_Cases,
    (Sleep_Disorder_Cases * 100.0 / Total_People) AS Sleep_Disorder_Percentage,
    Night_Waking_Cases,
    (Night_Waking_Cases * 100.0 / Total_People) AS Night_Waking_Percentage
FROM ScreenImpact
ORDER BY Sleep_Disorder_Percentage DESC;


--Impact of Physical Activity on Sleep Disorders

WITH ActivityImpact AS (
    SELECT 
        Sleep_Quality,
        COUNT(*) AS Total_People,
        SUM(Daily_Steps) AS Total_Steps,
        AVG(Daily_Steps) AS Avg_Daily_Steps,
        SUM(Physical_Activity) AS Total_Physical_Activity,
        AVG(Physical_Activity) AS Avg_Physical_Activity
    FROM eyess
    GROUP BY Sleep_Quality
)
SELECT 
    Sleep_Quality,
    Total_People,
    Total_Steps,
    Avg_Daily_Steps,
    Total_Physical_Activity,
    Avg_Physical_Activity
FROM ActivityImpact
ORDER BY Avg_Daily_Steps DESC;

