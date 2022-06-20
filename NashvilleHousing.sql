-- Cleaning Nashville housing data table using MYSQL

SELECT *
FROM portfolio.nashville_housing_data


SELECT *
FROM portfolio.nashville_housing_data
WHERE PropertyAddress = ''

-- standardizing date format
-- Initally tried using CONVERT/CAST funtions to convert my date format which was previously (ex. April 1, 2015) to yyyy-dd-mm but found it easier to format date in google sheets and reupload data.

-- Populate property address data

SELECT *
FROM portfolio.nashville_housing_data
-- WHERE PropertyAddress is null
order by ParcelID

-- Empty values were showing up instead of having 'NULL' values. Backtracked and went into excel to Find and Replace values with 'NULL'
-- Updating table to replace missing values in property address. 

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, IFNULL(a.PropertyAddress, b.PropertyAddress)
FROM portfolio.nashville_housing_data a
JOIN portfolio.nashville_housing_data b
	on a.ParcelID = b.ParcelID
	and a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress is not null

-- Updating

UPDATE portfolio.nashville_housing_data 
SET PropertyAddress = IFNULL(a.PropertyAddress, b.PropertyAddress)
FROM portfolio.nashville_housing_data
INNER JOIN portfolio.nashville_housing_data 
  on a.ParcelID = b.ParcelID
  and a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress is null

-- Breaking out Address into Individual Columns (Address, City, State) 

SELECT PropertyAddress
FROM portfolio.nashville_housing_data

SELECT SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) -1 ) as Address, 
SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) +1 , LENGTH(PropertyAddress)) as Address
FROM portfolio.nashville_housing_data

ALTER TABLE portfolio.nashville_housing_data
Add PropertySplitAddress Nvarchar(255)

UPDATE portfolio.nashville_housing_data
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) -1 ) 

ALTER TABLE portfolio.nashville_housing_data
Add PropertySplitCity Nvarchar(255)

UPDATE portfolio.nashville_housing_data
SET PropertySplitCity = SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) +1 , LENGTH(PropertyAddress))

SELECT *
FROM portfolio.nashville_housing_data


SELECT OwnerAddress 
FROM portfolio.nashville_housing_data

-- Secondary way of separting 'OwnerAddress' column
SELECT 
SUBSTRING_INDEX(OwnerAddress,',', 1),
SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress,',', 2), ',',-1) , 
SUBSTRING_INDEX(OwnerAddress,',', -1) 
FROM portfolio.nashville_housing_data

-- Creating separate columns
ALTER TABLE portfolio.nashville_housing_data
Add OwnerSplitAddress Nvarchar(255)

UPDATE portfolio.nashville_housing_data
SET OwnerSplitAddress = SUBSTRING_INDEX(OwnerAddress,',', 1)

ALTER TABLE portfolio.nashville_housing_data
Add OwnerSplitCity Nvarchar(255)

UPDATE portfolio.nashville_housing_data
SET OwnerSplitCity = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress,',', 2), ',',-1)

ALTER TABLE portfolio.nashville_housing_data
Add OwnerSplitState Nvarchar(255)

UPDATE portfolio.nashville_housing_data
SET OwnerSplitState = SUBSTRING_INDEX(OwnerAddress,',', -1) 

-- Verifying
SELECT *
FROM portfolio.nashville_housing_data

-- Change Y and N to Yes and No in "Sold as Vacant" field

SELECT Distinct(SoldAsVacant), COUNT(SoldAsVacant)
FROM portfolio.nashville_housing_data
GROUP BY SoldASVacant
ORDER BY 2

SELECT SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
    ELSE SoldAsVacant
    END
FROM portfolio.nashville_housing_data

UPDATE portfolio.nashville_housing_data
SET SoldAsVacant = CASE 
	When SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
    ELSE SoldAsVacant
    END


SELECT Distinct(SoldAsVacant), COUNT(SoldAsVacant)
FROM portfolio.nashville_housing_data
GROUP BY SoldASVacant
ORDER BY 2

-- Removing Duplicates

DELETE FROM portfolio.nashville_housing_data
WHERE
	UniqueID IN 
	(SELECT t.UniqueID
	FROM(
	SELECT UniqueID ,
		ROW_NUMBER() OVER (
		PARTITION BY ParcelID, 
		PropertyAddress, 
		SalePrice, 
		SaleDate, 
		LegalReference
		ORDER BY 
			UniqueID
			) row_num
        
FROM portfolio.nashville_housing_data) t

WHERE row_num > 1
);
-- Verifying

WITH RowNumCTE AS( 
SELECT *,  
	ROW_NUMBER() OVER ( 
    PARTITION BY ParcelID,
		PropertyAddress,     
        SalePrice,      
        SaleDate,      
        LegalReference    
        ORDER BY    
			UniqueID         
            ) row_num          
FROM portfolio.nashville_housing_data 
-- Order By ParcelID 
) 
SELECT * 
FROM RowNumCTE
WHERE row_num > 1
Order By PropertyAddress

-- Delete unused columns

SELECT * 
FROM portfolio.nashville_housing_data

ALTER TABLE portfolio.nashville_housing_data
DROP COLUMN OwnerAddress;

ALTER TABLE portfolio.nashville_housing_data
DROP COLUMN TaxDistrict;

ALTER TABLE portfolio.nashville_housing_data
DROP COLUMN PropertyAddress;

-- Verifying
SELECT *
FROM portfolio.nashville_housing_data


