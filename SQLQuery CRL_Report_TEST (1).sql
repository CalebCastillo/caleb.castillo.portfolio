---------------------------------------------------------------------------------------------
--------------CRL_Report_221017021631723-----------------------------------------------------

-- DATASETS CORRISPONDS W/ CRLDATA_A, IMPACTLAB_A, IMPACTCONTACTSCHEDULING--
-----------------TASKS-------------------------------------------------------------------------
--Use codebook to change variable name to corrispond with crldata_a--
--pivot analyte_name to corrispond with crldata_a table--
--Merge data into CRLDATA_A--
--Adjust for LABID typos--
--Ensure comments are merged--


            --- First_name and Last_Name are LABid's ---
---------UNDERSTANDING ENVIRONMENT-------------------------------------------------------------------------------------

SELECT *
FROM crl_report_test


SELECT * 
  FROM [dbo].[CRLDATA_A]

SELECT * 
FROM ImpactContactScheduling_A

SELECT *
FROM impactlab_a

SELECT Analyte_Name, Count(*) as Occurrence
FROM CCHC_Test.dbo.CRL_Report_TEST
GROUP BY Analyte_name
ORDER BY 2 DESC


-----------------------------------------------------------------------------------------------


SELECT Analyte_name
FROM CCHC_Test.dbo.CRL_Report_TEST

SELECT First_name, Patient_ID
FROM CCHC_Test.dbo.CRL_Report_TEST


--Cleaning so that entries correspond with merge--

SELECT DISTINCT Patient_ID
FROM CCHC_Test.dbo.CRL_Report_TEST

SELECT  Analyte_Name
FROM CCHC_Test.dbo.CRL_Report_TEST

SELECT Analyte_Name, Count(*) as Occurrence
FROM CCHC_Test.dbo.CRL_Report_TEST
GROUP BY Analyte_name
ORDER BY 1 ASC

--------------------CHANGE VARIABLE NAME TO CORRISPOND WITH CODEBOOK------------------------------------------------
UPDATE CRL_Report_Test
SET Analyte_Name = CASE Analyte_Name
		WHEN 'Hemoglobin A1c' THEN 'GHB'
		WHEN 'Hemoglobin' THEN 'HGB'
		WHEN 'BUN/Creatinine Ratio' THEN 'BUN'
		WHEN 'VLDL Cholesterol Cal' THEN 'VLDL_Chol_Cal'
		WHEN 'eGFR' THEN 'GFR'
		WHEN 'Hematocrit' THEN 'HCT'
		--WHEN 'Globulin, Total' THEN 'FIND PROPER VARIABLE NAME FOR GLOBULIN TOTAL'
		WHEN 'Creatinine' THEN 'CREA'
		WHEN 'ALT (SGPT)' THEN 'GPT'
		WHEN 'Triglycerides' THEN 'TRIG'
		WHEN 'Albumin' THEN 'LALB'
		WHEN 'Cholesterol, Total' THEN 'CHOL1'
		WHEN 'Sodium' THEN 'SOD'
		WHEN 'Alkaline Phosphatase' THEN 'ALK'
		WHEN 'Carbon Dioxide, Total' THEN 'CO2'
		WHEN 'Calcium' THEN 'CALC'
		WHEN 'Glucose' THEN 'FBG3'
		WHEN 'Bilirubin, Total' THEN 'TBIL'
		WHEN 'LDL Chol Calc (NIH)' THEN 'LDLCALC'
		WHEN 'Potassium' THEN 'POT'
		--WHEN 'A/G Ratio' THEN 'SEARCH FOR CORRECT VARIABLE NAME'
		WHEN 'Chloride' THEN 'CHL'
		WHEN 'AST (SGOT)' THEN 'GOT'
		WHEN 'Protein, Total' THEN 'TP'
		WHEN 'Platelets' THEN 'PLT'
		WHEN 'HDL Cholesterol' THEN 'HDLC'
		WHEN 'Immature Granulocytes' THEN 'GR_NO'
		--WHEN 'Lymphs' THEN 'SEARCH FOR CORRECT VARIABLE NAME'
		WHEN 'Neutrophils (Absolute)' THEN 'NEUT_NO'
		WHEN 'Monocytes(Absolute)' THEN 'MO_NO'
		--WHEN 'EOS' THEN 'SEARCH FOR CORRECT VARIABLE'
		--WHEN 'Monocytes' THEN 'SEARCH FOR CORRECT VARIABLE'
		WHEN 'Baso (Absolute)' THEN 'BASO_NO'
		WHEN 'Eos (Absolute)' THEN 'EOS_NO'
		--WHEN 'Neutrophils' THEN 'SEARCH FOR CORRECT VARIABLE NAME'
		WHEN 'Estim. Avg Glu (eAG)' THEN 'MCGLUC'
		--WHEN 'Basos' THEN 'SEARCH FOR CORRECT VARIABLE NAME'
		--WHEN 'Immature Grans (Abs)' THEN 'SEARCH FOR CORRECT VARIABLE NAME'
		WHEN 'Lymphs (Absolute)' THEN 'LY_NO'
		WHEN 'LDL/HDL Ratio' THEN 'CHLR'
		WHEN 'T. Chol/HDL Ratio' THEN 'CHLR'
	ELSE Analyte_Name 
	END --as Analyte_Name_TEST
--FROM CRL_Report_Test

UPDATE CRL_Report_Test
SET Analyte_Name = CASE Analyte_Name
WHEN 'BUN/Creatinine Ratio' THEN 'BUN_CREA_RA'
WHEN 'Globulin, Total' THEN 'GLOB'
WHEN 'A/G Ratio' THEN 'AG_RA'
ELSE Analyte_Name
END

ALTER TABLE CRL_Report_Test
DROP COLUMN Analyte

ALTER TABLE CRL_Report_Test
DROP COLUMN Abnormal_Flag

ALTER TABLE CRL_Report_Test
DROP COLUMN Abnormal_Indicator


-------------VERIFYING--------------------------------------------------
SELECT Analyte_Name, Count(*) as Occurrence
FROM CCHC_Test.dbo.CRL_Report_TEST
GROUP BY Analyte_name
ORDER BY 1 ASC

SELECT * 
FROM CRLDATA_


--------------------------------------------------------------------------------------------------------
---Converting row Analyte_name and results into a column------------------------------------------------

-----------------USE THIS SCRIPT FOR ROTATING ANALYTE_NAME COLUM----------------------------------------
SELECT First_Name, Patient_ID, Reported_Date,
	MAX(CASE WHEN Analyte_Name = 'AG_RA' THEN Result END) as 'AG_RA',
	MAX(CASE WHEN Analyte_Name = 'ALK' THEN Result END) as 'ALK',
	MAX(CASE WHEN Analyte_Name = 'BASO_NO' THEN Result END) as 'BASO_NO',
	MAX(CASE WHEN Analyte_Name = 'Basos' THEN Result END) as 'Basos',
	MAX(CASE WHEN Analyte_Name = 'BUN' THEN Result END) as 'BUN',
	MAX(CASE WHEN Analyte_Name = 'BUN_CREA_RA' THEN Result END) as 'BUN_CREA_RA',
	MAX(CASE WHEN Analyte_Name = 'CALC' THEN Result END) as 'CALC',
	MAX(CASE WHEN Analyte_Name = 'CHL' THEN Result END) as 'CHL',
	MAX(CASE WHEN Analyte_Name = 'CHLR' THEN Result END) as 'CHLR',
	MAX(CASE WHEN Analyte_Name = 'CHOL1' THEN Result END) as 'CHOL1',
	MAX(CASE WHEN Analyte_Name = 'CO2' THEN Result END) as 'CO2',
	MAX(CASE WHEN Analyte_Name = 'CREA' THEN Result END) as 'CREA',
	MAX(CASE WHEN Analyte_Name = 'Eos' THEN Result END) as 'Eos',
	MAX(CASE WHEN Analyte_Name = 'EOS_NO' THEN Result END) as 'EOS_NO',
	MAX(CASE WHEN Analyte_Name = 'FBG3' THEN Result END) as 'FBG3',
	MAX(CASE WHEN Analyte_Name = 'GFR' THEN Result END) as 'GFR',
	MAX(CASE WHEN Analyte_Name = 'GHB' THEN Result END) as 'GHB',
	MAX(CASE WHEN Analyte_Name = 'GLOB' THEN Result END) as 'GLOB',
	MAX(CASE WHEN Analyte_Name = 'GOT' THEN Result END) as 'GOT',
	MAX(CASE WHEN Analyte_Name = 'GPT' THEN Result END) as 'GPT',
	MAX(CASE WHEN Analyte_Name = 'GR_NO' THEN Result END) as 'GR_NO',
	MAX(CASE WHEN Analyte_Name = 'HCT' THEN Result END) as 'HCT',
	MAX(CASE WHEN Analyte_Name = 'HDLC' THEN Result END) as 'HDLC',
	MAX(CASE WHEN Analyte_Name = 'HGB' THEN Result END) as 'HGB',
	MAX(CASE WHEN Analyte_Name = 'Immature Grans (ABS)' THEN Result END) as 'Immature Grans (ABS)',
	MAX(CASE WHEN Analyte_Name = 'LALB' THEN Result END) as 'LALB',
	MAX(CASE WHEN Analyte_Name = 'LDLCALC' THEN Result END) as 'LDLCALC',
	MAX(CASE WHEN Analyte_Name = 'LY_NO' THEN Result END) as 'LY_NO',
	MAX(CASE WHEN Analyte_Name = 'Lymphs' THEN Result END) as 'Lymphs',
	MAX(CASE WHEN Analyte_Name = 'MCGLUC' THEN Result END) as 'MCGLUC',
	MAX(CASE WHEN Analyte_Name = 'MCH' THEN Result END) as 'MCH',
	MAX(CASE WHEN Analyte_Name = 'MCHC' THEN Result END) as 'MCHC',
	MAX(CASE WHEN Analyte_Name = 'MCV' THEN Result END) as 'MCV',
	MAX(CASE WHEN Analyte_Name = 'MO_NO' THEN Result END) as 'MO_NO',
	MAX(CASE WHEN Analyte_Name = 'Monocytes' THEN Result END) as 'Monocytes',
	MAX(CASE WHEN Analyte_Name = 'NEUT_NO' THEN Result END) as 'NEUT_NO',
	MAX(CASE WHEN Analyte_Name = 'Neutrophils' THEN Result END) as 'Neutrophils',
	MAX(CASE WHEN Analyte_Name = 'PLT' THEN Result END) as 'PLT',
	MAX(CASE WHEN Analyte_Name = 'POT' THEN Result END) as 'POT',
	MAX(CASE WHEN Analyte_Name = 'RBC' THEN Result END) as 'RBC',
	MAX(CASE WHEN Analyte_Name = 'SOD' THEN Result END) as 'SOD',
	MAX(CASE WHEN Analyte_Name = 'TBIL' THEN Result END) as 'TBIL',
	MAX(CASE WHEN Analyte_Name = 'TP' THEN Result END) as 'TP',
	MAX(CASE WHEN Analyte_Name = 'TRIG' THEN Result END) as 'TRIG',
	MAX(CASE WHEN Analyte_Name = 'VLDL_Chol_Calc' THEN Result END) as 'VLDL_Chol_Calc',
	MAX(CASE WHEN Analyte_Name = 'WBC' THEN Result END) as 'WBC'
FROM CRL_Report_TEST 
GROUP BY First_Name, Patient_ID, Reported_Date
--------------------------------------------------------------------------------------------------
--Delete rows containing invaild results (comments)-----------------------------------------------

Select *
from dbo.CRL_Report_Test where Analyte  in ( 1315,977740,978113,977164)

DELETE
FROM CRL_Report_Test
WHERE Analyte in (1315,977740,978113,977164)

DELETE
FROM CRL_Report_Test
WHERE Analyte_Name = 'Please note'

DELETE
FROM CRL_Report_Test
WHERE Analyte_Name = 'Please Note:'

DELETE
FROM CRL_Report_Test
WHERE Analyte_Name = 'Written Authorization'
--------------------------------------------------------------------

SELECT LABID, Count(*) as Occurrence
FROM CCHC_Test.dbo.CRLDATA_A
GROUP BY LABID
ORDER BY 2 DESC

SELECT Patient_ID, Count(*) as Occurrence
FROM CCHC_Test.dbo.CRL_Report_TEST
GROUP BY Patient_ID 
ORDER BY 1 ASC

SELECT First_Name, Count(*) as Occurrence
FROM CCHC_Test.dbo.CRL_Report_TEST
GROUP BY First_Name 
ORDER BY 1 ASC


SELECT LABID, Count(*) as Occurrence
FROM CCHC_Test.dbo.impactlab_a
GROUP BY LABID
ORDER BY 1 ASC
------------------------TYPOS IN VARIABLE NAMES-----------------------------------------
SELECT*
FROM CRL_Report_Test
WHERE First_Name 
in ('10Y0580', '10Y0581', '10Y0579', '15Y0243', '15Y0244', '15Y0239', '15Y0240', '15Y0241', '15Y0242', '15Y0245', '15Y0246', 
'20Y0001', '20Y0002', '5Y1508', '5Y1509', 'BA0711', 'CV0322', 'CV0323', 'CV0324', 'CV0325', 'CV0327', 'CV0328', 'CV0329', 'CV0330', 
'CV0331', 'DST0004', 'DT0001', 'DT0002', 'DT0003', 'DT0005', 'DT0006', 'DT0007', 'DT0008', 'DT0009', 'DT0010', 'DT0011', 'DT0012', 
'DT0013', 'DT0014', 'DT0015', 'DT0016', 'DT0017', 'DT0018', 'DT0019', 'DT0020', 'DT0021', 'DT0022', 'DT0023', 'DT0024', 'DT0025', 
'DT0026', 'DT0027', 'DT0028', 'DT0029', 'DT0030', 'GLP055', 'GLP058', 'GLP068')



SELECT *
FROM CRLDATA_A
WHERE LABID in ('10Y0580', '10Y0581', '10Y0579', '15Y0243', '15Y0244', '15Y0239', '15Y0240', '15Y0241', '15Y0242', '15Y0245', '15Y0246', 
'20Y0001', '20Y0002', '5Y1508', '5Y1509', 'BA0711', 'CV0322', 'CV0323', 'CV0324', 'CV0325', 'CV0327', 'CV0328', 'CV0329', 'CV0330', 
'CV0331', 'DT0004', 'DT0001', 'DT0002', 'DT0003', 'DT0005', 'DT0006', 'DT0007', 'DT0008', 'DT0009', 'DT0010', 'DT0011', 'DT0012', 
'DT0013', 'DT0014', 'DT0015', 'DT0016', 'DT0017', 'DT0018', 'DT0019', 'DT0020', 'DT0021', 'DT0022', 'DT0023', 'DT0024', 'DT0025', 
'DT0026', 'DT0027', 'DT0028', 'DT0029', 'DT0030', 'GLP055', 'GLP058', 'GLP068')




--- CHANGE '1040580', '1040581', '1540243', '1540244', '541508', 'DST0004'--------------------------------------------------------------------------
--- 4=Y (TYPO)--------------------------------------------------------------------

UPDATE CRL_Report_Test
SET Patient_ID = CASE Patient_ID
	WHEN '1040580' THEN '10Y0580'
	WHEN '1040581' THEN '10Y0581'
	WHEN '1540243' THEN '15Y0243'
	WHEN '1540244' THEN '15Y0244'
	WHEN '541508' THEN '5Y1508'
	WHEN 'DST0004' THEN 'DT0004'
ELSE Patient_ID
END
 
UPDATE CRL_Report_Test
SET Analyte_Name = CASE Analyte_Name
	WHEN 'Immature Grans (ABS)' THEN 'Immature_Grans' 
ELSE Analyte_Name
END


-----------------------------------------------------------------------------------------------
-------------CREATING TEMP TABLE FOR ASSISTING WITH DATA MERGE-----------------
----ANALYTE VARIBALE NAMES-----------------
SELECT Analyte_Name, Count(*) as Occurrence
FROM CCHC_Test.dbo.CRL_Report_TEST
GROUP BY Analyte_name
ORDER BY 1 ASC

--TEMP TABLE CREATION/ROTATING COLUMNS FOR DATA MERGE-----------------------

DROP TABLE IF EXISTS #temp_Crl_Report_Test
CREATE TABLE #temp_Crl_Report_Test (
First_Name nvarchar(50),
Patient_ID nvarchar(50),
Reported_Date date,
Result_Comments nvarchar(max),
AG_RA float,
ALK float,
BASO_NO float,
Basos float,
BUN float,
BUN_CREA_RA float,
CALC float,
CHL float,
CHLR float,
CHOL1 float,
CO2 float,
CREA float,
Eos float,
EOS_NO float,
FBG3 float,
GFR float,
GHB float,
GLOB float,
GOT float,
GPT float,
GR_NO float,
HCT float,
HDLC float,
HGB float,
Immature_Grans float, 
LALB float,
LDLCALC float,
LY_NO float,
Lymphs float,
MCGLUC float,
MCH float,
MCHC float,
MCV float,
MO_NO float,
Monocytes float,
NEUT_NO float,
Neutrophils float,
PLT float,
POT float,
RBC float,
RDW float,
SOD float,
TBIL float,
TP float,
TRIG float,
VLDL_Chol_Cal float,
WBC float
)

INSERT INTO #temp_Crl_Report_Test
SELECT First_Name, Patient_ID, Reported_Date, Result_Comments,
	MAX(CASE WHEN Analyte_Name = 'AG_RA' THEN Result END) as 'AG_RA',
	MAX(CASE WHEN Analyte_Name = 'ALK' THEN Result END) as 'ALK',
	MAX(CASE WHEN Analyte_Name = 'BASO_NO' THEN Result END) as 'BASO_NO',
	MAX(CASE WHEN Analyte_Name = 'Basos' THEN Result END) as 'Basos',
	MAX(CASE WHEN Analyte_Name = 'BUN' THEN Result END) as 'BUN',
	MAX(CASE WHEN Analyte_Name = 'BUN_CREA_RA' THEN Result END) as 'BUN_CREA_RA',
	MAX(CASE WHEN Analyte_Name = 'CALC' THEN Result END) as 'CALC',
	MAX(CASE WHEN Analyte_Name = 'CHL' THEN Result END) as 'CHL',
	MAX(CASE WHEN Analyte_Name = 'CHLR' THEN Result END) as 'CHLR',
	MAX(CASE WHEN Analyte_Name = 'CHOL1' THEN Result END) as 'CHOL1',
	MAX(CASE WHEN Analyte_Name = 'CO2' THEN Result END) as 'CO2',
	MAX(CASE WHEN Analyte_Name = 'CREA' THEN Result END) as 'CREA',
	MAX(CASE WHEN Analyte_Name = 'Eos' THEN Result END) as 'Eos',
	MAX(CASE WHEN Analyte_Name = 'EOS_NO' THEN Result END) as 'EOS_NO',
	MAX(CASE WHEN Analyte_Name = 'FBG3' THEN Result END) as 'FBG3',
	MAX(CASE WHEN Analyte_Name = 'GFR' THEN Result END) as 'GFR',
	MAX(CASE WHEN Analyte_Name = 'GHB' THEN Result END) as 'GHB',
	MAX(CASE WHEN Analyte_Name = 'GLOB' THEN Result END) as 'GLOB',
	MAX(CASE WHEN Analyte_Name = 'GOT' THEN Result END) as 'GOT',
	MAX(CASE WHEN Analyte_Name = 'GPT' THEN Result END) as 'GPT',
	MAX(CASE WHEN Analyte_Name = 'GR_NO' THEN Result END) as 'GR_NO',
	MAX(CASE WHEN Analyte_Name = 'HCT' THEN Result END) as 'HCT',
	MAX(CASE WHEN Analyte_Name = 'HDLC' THEN Result END) as 'HDLC',
	MAX(CASE WHEN Analyte_Name = 'HGB' THEN Result END) as 'HGB',
	MAX(CASE WHEN Analyte_Name = 'Immature_Grans' THEN Result END) as 'Immature_Grans',
	MAX(CASE WHEN Analyte_Name = 'LALB' THEN Result END) as 'LALB',
	MAX(CASE WHEN Analyte_Name = 'LDLCALC' THEN Result END) as 'LDLCALC',
	MAX(CASE WHEN Analyte_Name = 'LY_NO' THEN Result END) as 'LY_NO',
	MAX(CASE WHEN Analyte_Name = 'Lymphs' THEN Result END) as 'Lymphs',
	MAX(CASE WHEN Analyte_Name = 'MCGLUC' THEN Result END) as 'MCGLUC',
	MAX(CASE WHEN Analyte_Name = 'MCH' THEN Result END) as 'MCH',
	MAX(CASE WHEN Analyte_Name = 'MCHC' THEN Result END) as 'MCHC',
	MAX(CASE WHEN Analyte_Name = 'MCV' THEN Result END) as 'MCV',
	MAX(CASE WHEN Analyte_Name = 'MO_NO' THEN Result END) as 'MO_NO',
	MAX(CASE WHEN Analyte_Name = 'Monocytes' THEN Result END) as 'Monocytes',
	MAX(CASE WHEN Analyte_Name = 'NEUT_NO' THEN Result END) as 'NEUT_NO',
	MAX(CASE WHEN Analyte_Name = 'Neutrophils' THEN Result END) as 'Neutrophils',
	MAX(CASE WHEN Analyte_Name = 'PLT' THEN Result END) as 'PLT',
	MAX(CASE WHEN Analyte_Name = 'POT' THEN Result END) as 'POT',
	MAX(CASE WHEN Analyte_Name = 'RBC' THEN Result END) as 'RBC',
	MAX(CASE WHEN Analyte_Name = 'RDW' THEN Result END) as 'RDW',
	MAX(CASE WHEN Analyte_Name = 'SOD' THEN Result END) as 'SOD',
	MAX(CASE WHEN Analyte_Name = 'TBIL' THEN Result END) as 'TBIL',
	MAX(CASE WHEN Analyte_Name = 'TP' THEN Result END) as 'TP',
	MAX(CASE WHEN Analyte_Name = 'TRIG' THEN Result END) as 'TRIG',
	MAX(CASE WHEN Analyte_Name = 'VLDL_Chol_Cal' THEN Result END) as 'VLDL_Chol_Cal',
	MAX(CASE WHEN Analyte_Name = 'WBC' THEN Result END) as 'WBC'
FROM CRL_Report_TEST 
GROUP BY First_Name, Patient_ID, Reported_Date, Result_Comments

SELECT *
FROM #temp_Crl_Report_Test
--------------------------------------------------------------------------------------------
------------------------------QUERY SHOWING ALL MERGED DATA---------------------------------
SELECT *
FROM CRLDATA_A_COPY
WHERE LABID in ('10Y0580', '10Y0581', '10Y0579', '15Y0243', '15Y0244', '15Y0239', '15Y0240', '15Y0241', '15Y0242', '15Y0245', '15Y0246', 
'20Y0001', '20Y0002', '5Y1508', '5Y1509', 'BA0711', 'CV0322', 'CV0323', 'CV0324', 'CV0325', 'CV0327', 'CV0328', 'CV0329', 'CV0330', 
'CV0331', 'DT0004', 'DT0001', 'DT0002', 'DT0003', 'DT0005', 'DT0006', 'DT0007', 'DT0008', 'DT0009', 'DT0010', 'DT0011', 'DT0012', 
'DT0013', 'DT0014', 'DT0015', 'DT0016', 'DT0017', 'DT0018', 'DT0019', 'DT0020', 'DT0021', 'DT0022', 'DT0023', 'DT0024', 'DT0025', 
'DT0026', 'DT0027', 'DT0028', 'DT0029', 'DT0030', 'GLP055', 'GLP058', 'GLP068')


------------JOINING/UPDATING CRLDATA_A_COPY-----------------------
UPDATE CD
SET CD.DATE_CRL = CR.Reported_Date, 
--AG_RA.CD = AG_RA.CR,
CD.ALK = CR.ALK,
CD.BASO_NO = CR.BASO_NO,
CD.Basos = CR.Basos, 
CD.BUN = CR.BUN,
--BUN_CREA_RA,
CD.CALC = CR.CALC,
CD.CHL = CR.CHL,
CD.CHLR = CR.CHLR,
CD.CHOL1 = CR.CHOL1,
CD.CO2 = CR.CO2,
CD.CREA = CR.CREA, 
--CD.Eos = CR.Eos,
CD.EOS_NO = CR.EOS_NO,
CD.FBG3 = CR.FBG3,
CD.GFR = CR.GFR,
CD.GHB = CR.GHB,
--GLOB.CD = GLOB.CR,
CD.GOT = CR.GOT,
CD.GPT = CR.GPT,
CD.GR_NO = CR.GR_NO,
CD.HCT = CR.HCT,
CD.HDLC = CR.HDLC,
CD.HGB = CR.HGB,
--Immature_Grans.CD = Immature_Grans.CR,
CD.LALB = CR.LALB,
CD.LDLCALC = CR.LDLCALC,
CD.LY_NO = CR.LY_NO,
--Lymphs.CD = Lymphs.CR,
CD.MCGLUC = CR.MCGLUC,
CD.MCH = CR.MCH,
CD.MCHC = CR.MCHC,
CD.MCV = CR.MCV,
CD.MO_NO = CR.MO_NO,
--Monocytes.CD = Monocytes.CR,
CD.NEUT_NO = CR.NEUT_NO,
--Neutrophils.CD = Neutrophils.CR,
CD.PLT = CR.PLT,
CD.POT = CR.POT,
CD.RBC = CR.RBC,
CD.RDW = CR.RBC,
CD.SOD = CR.SOD,
CD.TBIL = CR.TBIL,
CD.TP = CR.TP,
CD.TRIG = CR.TRIG,
--VLDL_Chol_Calc.CD = VLDL_Chol_Calc.CR,
CD.WBC = CR.WBC
FROM CRLDATA_A_COPY as CD 
	INNER JOIN #temp_Crl_Report_Test as CR ON CD.LABID = CR.First_Name 

SELECT*
FROM CRLDATA_A_COPY as CD 
	INNER JOIN #temp_Crl_Report_Test as CR ON CD.LABID = CR.First_Name 

--------------ADDING NEW COLUMN VARIABLES---------------------------
ALTER TABLE CRLDATA_A_COPY
ADD 
LABCORP_COMMENTS NVARCHAR(MAX)

UPDATE  CD
SET CD.AG_RA = CR.AG_RA,
CD.BUN_CREA_RA = CR.BUN_CREA_RA,
CD.Eos = CR.Eos,
CD.GLOB = CR.GLOB,
CD.Immature_Grans = CR.Immature_Grans,
CD.Lymphs = CR.Lymphs,
CD.Monocytes = CR.Monocytes,
CD.Neutrophils = CR.Neutrophils,
CD.VLDL_Chol_Cal = CR.VLDL_Chol_Cal
FROM CRLDATA_A_COPY AS CD
	INNER JOIN #temp_Crl_Report_Test as CR ON CD.LABID = CR.First_Name 

------------------------------------INSERTING COVID LABS--------------------------------------------
INSERT INTO 
	CRLDATA_A_COPY (LABID, DATE_CRL, AG_RA, ALK, BASO_NO, Basos, BUN, BUN_CREA_RA, CALC, CHL, CHLR, CHOL1, CO2, CREA, Eos, EOS_NO, FBG3, GFR, GHB, GLOB, GOT, GPT, GR_NO, HCT, HDLC, HGB,
	Immature_Grans, LALB, LDLCALC, LY_NO, Lymphs, MCGLUC, MCH, MCHC, MCV, MO_NO, Monocytes, NEUT_NO, Neutrophils, PLT, POT, RBC, RDW, SOD, TBIL, TP, TRIG, VLDL_Chol_Cal, WBC)
SELECT 
	First_Name, Reported_Date, AG_RA, ALK, BASO_NO, Basos, BUN, BUN_CREA_RA, CALC, CHL, CHLR, CHOL1, CO2, CREA, Eos, EOS_NO, FBG3, GFR, GHB, GLOB, GOT, GPT, GR_NO, HCT, HDLC, HGB,
	Immature_Grans, LALB, LDLCALC, LY_NO, Lymphs, MCGLUC, MCH, MCHC, MCV, MO_NO, Monocytes, NEUT_NO, Neutrophils, PLT, POT, RBC, RDW, SOD, TBIL, TP, TRIG, VLDL_Chol_Cal, WBC
FROM #temp_Crl_Report_Test
WHERE 
	First_Name IN ( 'CV0322', 'CV0323', 'CV0324', 'CV0325', 'CV0327', 'CV0328', 'CV0329', 'CV0330', 'CV0331')

SELECT *
FROM #temp_Crl_Report_Test

SELECT * 
FROM CRL_Report_Test

SELECT *
FROM CRLdata_a_copy
where labid = 'CV0324'
-----------------------ADDING LABCORP_COMMENTS COLUMN-----------------------------------------------------------------------------------------
UPDATE CRLDATA_A_COPY
SET LABCORP_COMMENTS = CRL_COMMENTS
FROM CRLDATA_A_COPY 
	WHERE LABID in ('10Y0580', '10Y0581', '10Y0579', '15Y0243', '15Y0244', '15Y0239', '15Y0240', '15Y0241', '15Y0242', '15Y0245', '15Y0246', 
'20Y0001', '20Y0002', '5Y1508', '5Y1509', 'BA0711', 'CV0322', 'CV0323', 'CV0324', 'CV0325', 'CV0327', 'CV0328', 'CV0329', 'CV0330', 
'CV0331', 'DT0004', 'DT0001', 'DT0002', 'DT0003', 'DT0005', 'DT0006', 'DT0007', 'DT0008', 'DT0009', 'DT0010', 'DT0011', 'DT0012', 
'DT0013', 'DT0014', 'DT0015', 'DT0016', 'DT0017', 'DT0018', 'DT0019', 'DT0020', 'DT0021', 'DT0022', 'DT0023', 'DT0024', 'DT0025', 
'DT0026', 'DT0027', 'DT0028', 'DT0029', 'DT0030', 'GLP055', 'GLP058', 'GLP068')

UPDATE CRLDATA_A_COPY
SET CRL_COMMENTS = NULL
	WHERE LABID in ('10Y0580', '10Y0581', '10Y0579', '15Y0243', '15Y0244', '15Y0239', '15Y0240', '15Y0241', '15Y0242', '15Y0245', '15Y0246', 
'20Y0001', '5Y1508', '5Y1509', 'BA0711')

---------------------------------ISSUES WITH 'CV0324' DUPLICATION DURING JOINS, ENSURING TWO SEPARATE UNIQUE ENTRIES-----------------------------------------------------
DELETE 
FROM CRLDATA_A_COPY
WHERE LABID = 'CV0324'

INSERT INTO 
	CRLDATA_A_COPY (LABID, DATE_CRL, AG_RA, ALK, BASO_NO, Basos, BUN, BUN_CREA_RA, CALC, CHL, CHLR, CHOL1, CO2, CREA, Eos, EOS_NO, FBG3, GFR, GHB, GLOB, GOT, GPT, GR_NO, HCT, HDLC, HGB,
	Immature_Grans, LALB, LDLCALC, LY_NO, Lymphs, MCGLUC, MCH, MCHC, MCV, MO_NO, Monocytes, NEUT_NO, Neutrophils, PLT, POT, RBC, RDW, SOD, TBIL, TP, TRIG, VLDL_Chol_Cal, WBC)
SELECT 
	First_Name, Reported_Date, AG_RA, ALK, BASO_NO, Basos, BUN, BUN_CREA_RA, CALC, CHL, CHLR, CHOL1, CO2, CREA, Eos, EOS_NO, FBG3, GFR, GHB, GLOB, GOT, GPT, GR_NO, HCT, HDLC, HGB,
	Immature_Grans, LALB, LDLCALC, LY_NO, Lymphs, MCGLUC, MCH, MCHC, MCV, MO_NO, Monocytes, NEUT_NO, Neutrophils, PLT, POT, RBC, RDW, SOD, TBIL, TP, TRIG, VLDL_Chol_Cal, WBC
FROM #temp_Crl_Report_Test
WHERE 
	First_Name IN ('CV0324')

---------------SEARCHING FOR OTHER DUPLICATES-----------------------------------
SELECT LABID, Count(*) as Occurrence
FROM CRLDATA_A_COPY
GROUP BY LABID
ORDER BY 2 DESC

---------------ADJUSTING FOR MISSING COMMENTS-----------------------------------
SELECT First_Name, Analyte_Name, Result_Comments
FROM CRL_Report_Test
where First_Name = '15Y0246'

UPDATE CD
SET CD.CRL_COMMENTS = CR.Result_Comments
FROM CRLDATA_A_COPY as CD 
	INNER JOIN Crl_Report_Test as CR 
		ON CD.LABID = CR.First_Name 


----------QUERY REFERENCE FOR MERGED DATA------------------------------------------------------------------------------------------------
SELECT *
FROM CRLDATA_A_COPY
WHERE LABID in ('10Y0580', '10Y0581', '10Y0579', '15Y0243', '15Y0244', '15Y0239', '15Y0240', '15Y0241', '15Y0242', '15Y0245', '15Y0246', 
'20Y0001', '20Y0002', '5Y1508', '5Y1509', 'BA0711', 'CV0322', 'CV0323', 'CV0324', 'CV0325', 'CV0327', 'CV0328', 'CV0329', 'CV0330', 
'CV0331', 'DT0004', 'DT0001', 'DT0002', 'DT0003', 'DT0005', 'DT0006', 'DT0007', 'DT0008', 'DT0009', 'DT0010', 'DT0011', 'DT0012', 
'DT0013', 'DT0014', 'DT0015', 'DT0016', 'DT0017', 'DT0018', 'DT0019', 'DT0020', 'DT0021', 'DT0022', 'DT0023', 'DT0024', 'DT0025', 
'DT0026', 'DT0027', 'DT0028', 'DT0029', 'DT0030', 'GLP055', 'GLP058', 'GLP068')
-----------------------------------------------------------------------------------------------------------------------------------------
--------------ADJUSTING FOR MISSING COMMENTS CONTINUED-----------------------------------------------------------------------------------
UPDATE CRLDATA_A_COPY
SET LABCORP_COMMENTS = CONCAT(LABCORP_COMMENTS, '; GFR: <18 years old')
WHERE LABID = '15Y0246' 

UPDATE CRLDATA_A_COPY
SET LABCORP_COMMENTS = 'CHLR: Missing Value'
WHERE LABID = '5Y1508' 

UPDATE CRLDATA_A_COPY
SET LABCORP_COMMENTS = 'CHLR: Missing Value'
WHERE LABID = 'CV0322' 

UPDATE CRLDATA_A_COPY
SET LABCORP_COMMENTS = 'Repeated LABID, All NULL result values except GHB and MCGLUC'
WHERE LABID = 'CV0324' 
and DATE_CRL = '2022-10-11 00:00:00'

UPDATE CRLDATA_A_COPY
SET LABCORP_COMMENTS = 'MCGLUC: Missing Value; MPV: Missing Value'
WHERE LABID = 'CV0324' 
and DATE_CRL = '2022-10-06 00:00:00'

UPDATE CRLDATA_A_COPY
SET LABCORP_COMMENTS = 'CHLR: Missing Value; MPV: Missing Value'
WHERE LABID = 'CV0322' 

UPDATE CRLDATA_A_COPY
SET LABCORP_COMMENTS = 'CHLR: Missing Value; MPV: Missing Value'
WHERE LABID IN ('CV0323', 'CV0325', 'CV0327', 'CV0328', 'CV0329', 'CV0330', 'CV0331')

---------------------------------------------------------------------------------------------
SELECT *
FROM Crl_Report_Test
WHERE Result_Comments = '**Please note reference interval change**'


SELECT Result_Comments, Count(*) as Occurrence
FROM CRL_Report_Test
GROUP BY Result_Comments
ORDER BY 2 DESC

UPDATE CRLDATA_A_COPY
SET CRL_COMMENTS = 'FBG3: **Please note reference interval change**'
WHERE LABID  = 'CV0324' 
and DATE_CRL = '2022-10-06 00:00:00'

------------------------------------------------------------------------------------------------

UPDATE CRLDATA_A_COPY
SET CRL_COMMENTS = 'No patient age and/or gender provided or "N" placed in gender box'
WHERE LABID  = '15Y0246' 


---VERIFYING--------------------------------------------------------------------------------------
SELECT * 
FROM CRLDATA_A_COPY

SELECT *
FROM #tempCRL_Report_Test

SELECT *
FROM CRL_Reprot_Test

SELECT * 
FROM CRLDATA_A 
--------------------------------------------------------------------------------------------------

