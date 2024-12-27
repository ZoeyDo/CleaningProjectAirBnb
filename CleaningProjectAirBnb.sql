USE CleaningProjectAirBnb;

SELECT * FROM cleaningprojectairbnbdata;

#Delete Unused Columns
SELECT * FROM cleaningprojectairbnbdata;

ALTER TABLE cleaningprojectairbnbdata
DROP COLUMN price,
DROP COLUMN category, 
DROP COLUMN discount,
DROP COLUMN breadcrumbs;

ALTER TABLE cleaningprojectairbnbdata
DROP COLUMN lat,
DROP COLUMN `long`;

#Change Y and N to Yes and No in "availability", "pets_allowed", "is_supperhost", "is_guest_favorite" field
SELECT * FROM cleaningprojectairbnbdata;

SELECT availability,
    CASE
        WHEN availability = 'FALSE' THEN 'No'
        WHEN availability = 'TRUE' THEN 'Yes'
        ELSE availability
    END, 
    pets_allowed,
    CASE
        WHEN pets_allowed = 'FALSE' THEN 'No'
        WHEN pets_allowed = 'TRUE' THEN 'Yes'
        ELSE pets_allowed
    END,
    is_supperhost,
    CASE
        WHEN is_supperhost = 'FALSE' THEN 'No'
        WHEN is_supperhost = 'TRUE' THEN 'Yes'
        ELSE is_supperhost
    END,
    is_guest_favorite,
    CASE
        WHEN is_guest_favorite = 'FALSE' THEN 'No'
        WHEN is_guest_favorite = 'TRUE' THEN 'Yes'
        ELSE is_guest_favorite
    END
FROM cleaningprojectairbnbdata;

UPDATE cleaningprojectairbnbdata
SET availability = CASE
        WHEN availability = 'FALSE' THEN 'No'
        WHEN availability = 'TRUE' THEN 'Yes'
        ELSE availability
    END; 
    
UPDATE cleaningprojectairbnbdata
SET pets_allowed = CASE
        WHEN pets_allowed = 'FALSE' THEN 'No'
        WHEN pets_allowed = 'TRUE' THEN 'Yes'
        ELSE pets_allowed
    END; 

UPDATE cleaningprojectairbnbdata
SET is_supperhost = CASE
        WHEN is_supperhost = 'FALSE' THEN 'No'
        WHEN is_supperhost = 'TRUE' THEN 'Yes'
        ELSE is_supperhost
    END;

UPDATE cleaningprojectairbnbdata
SET is_guest_favorite = CASE
        WHEN is_guest_favorite = 'FALSE' THEN 'No'
        WHEN is_guest_favorite = 'TRUE' THEN 'Yes'
        ELSE is_guest_favorite
    END;
    
#Breaking out "location" into individual columns (place, province, country) + Drop column "location"
SELECT * FROM cleaningprojectairbnbdata;

SELECT location FROM cleaningprojectairbnbdata;

SELECT
	SUBSTRING_INDEX(location, ',', 1) AS place,
    SUBSTRING_INDEX(SUBSTRING_INDEX(location, ',', -2), ',', 1) AS province,
    SUBSTRING_INDEX(location, ',', -1) AS country
FROM cleaningprojectairbnbdata;

ALTER TABLE cleaningprojectairbnbdata
ADD place VARCHAR(255);

UPDATE cleaningprojectairbnbdata
SET place = SUBSTRING_INDEX(location, ',', 1);

ALTER TABLE cleaningprojectairbnbdata
ADD province VARCHAR(255);

UPDATE cleaningprojectairbnbdata
SET province = SUBSTRING_INDEX(SUBSTRING_INDEX(location, ',', -2), ',', 1);

ALTER TABLE cleaningprojectairbnbdata
ADD country VARCHAR(255);

UPDATE cleaningprojectairbnbdata
SET country = SUBSTRING_INDEX(location, ',', -1);

ALTER TABLE cleaningprojectairbnbdata
DROP COLUMN location;

#Clean "house_rules" column: Delete "[ ]", "" "" symbols, Delete information about the number of guests
SELECT * FROM cleaningprojectairbnbdata;

SELECT REPLACE(REPLACE(REPLACE(house_rules, '[', ''), ']', ''), '"', '') AS house_rules_updated
FROM cleaningprojectairbnbdata;

ALTER TABLE cleaningprojectairbnbdata
ADD COLUMN house_rules_updated TEXT;

UPDATE cleaningprojectairbnbdata
SET house_rules_updated = REPLACE(REPLACE(REPLACE(house_rules, '[', ''), ']', ''), '"', '');

SELECT
	SUBSTRING_INDEX(house_rules_updated, ',', 2) AS time_rules
FROM cleaningprojectairbnbdata;

ALTER TABLE cleaningprojectairbnbdata
ADD COLUMN time_rules TEXT;

UPDATE cleaningprojectairbnbdata
SET time_rules = SUBSTRING_INDEX(house_rules_updated, ',', 2);

ALTER TABLE cleaningprojectairbnbdata
DROP COLUMN house_rules,
DROP COLUMN house_rules_updated;

SELECT time_rules,
    CASE
        WHEN SUBSTRING_INDEX(time_rules, ",", -1) NOT LIKE ' C%' THEN SUBSTRING_INDEX(time_rules, ",", 1)
        ELSE time_rules
    END 
FROM cleaningprojectairbnbdata;

UPDATE cleaningprojectairbnbdata
SET time_rules = CASE
        WHEN SUBSTRING_INDEX(time_rules, ",", -1) NOT LIKE ' C%' THEN SUBSTRING_INDEX(time_rules, ",", 1)
        ELSE time_rules
    END;

#Clean "details" column: Delete "[ ]", "" "" symbols, Delete information about the number of guests
SELECT * FROM cleaningprojectairbnbdata;

SELECT REPLACE(REPLACE(REPLACE(details, '[', ''), ']', ''), '"', '') AS room_details
FROM cleaningprojectairbnbdata;

ALTER TABLE cleaningprojectairbnbdata
ADD COLUMN room_details TEXT;

UPDATE cleaningprojectairbnbdata
SET room_details = REPLACE(REPLACE(REPLACE(details, '[', ''), ']', ''), '"', '');

ALTER TABLE cleaningprojectairbnbdata
DROP COLUMN details;

SELECT room_details,
    CASE
        WHEN SUBSTRING(room_details, 3, 1) LIKE 'g' THEN SUBSTRING(room_details, 11, LENGTH(room_details))
        ELSE room_details
    END 
FROM cleaningprojectairbnbdata;

UPDATE cleaningprojectairbnbdata
SET room_details = CASE
        WHEN SUBSTRING(room_details, 3, 1) LIKE 'g' THEN SUBSTRING(room_details, 11, LENGTH(room_details))
        ELSE room_details
    END;
    


