-- #################################################################################################
-- UNIFIED LOG QUERIES
-- #################################################################################################

-- Airdrop acitivty ------------------------------------------------------------
-- find successful events from last 5 minutes
SELECT timestamp,subsystem,category,message FROM unified_log 
    WHERE subsystem="com.apple.sharing"
    AND process="sharingd"
    AND level="default"
    AND message="Sending Ask response with code OK (200)"
    AND timestamp > (select unix_time - 300 from time) LIMIT 5;


-- airdrop acitivity with example of using LIKE for message content
SELECT * FROM unified_log 
    WHERE subsystem="com.apple.sharing"
    AND process="sharingd"
    AND level="default"
    AND message LIKE "%Sending Ask response%"
    AND timestamp > (select unix_time - 1200 from time) LIMIT 5;


-- Show physical logins
SELECT * FROM unified_log 
    WHERE process="loginwindow"
    AND level="default"
    AND message LIKE "%com.apple.sessionDidLogin%"
    AND timestamp > (select unix_time - 345600 from time) LIMIT 5;


-- Shows authentication attempts for system settings changes
SELECT * FROM unified_log 
    WHERE process = "authd"
    AND subsystem = "com.apple.Authorization"
    AND message LIKE "%Validating shared credential%"
    AND message LIKE "%system.preferences.%"
    AND level="default"
    AND timestamp > (select unix_time - 3600 from time) LIMIT 5;


-- Shows authentication failed system settins authentications
SELECT * FROM unified_log 
    WHERE process = "authd"
    AND subsystem = "com.apple.Authorization"
    AND message LIKE "%interaction not allowed%"
    AND level="error"
    AND timestamp > (select unix_time - 3600 from time) LIMIT 5;


-- To see what the failed authentication was doing
SELECT * FROM unified_log 
    WHERE process = "authd"
    AND subsystem = "com.apple.Authorization"
    AND message LIKE "%Validating shared credential%"
    AND message LIKE "%system.preferences.%"
    AND level="default"
    AND timestamp > (select unix_time - 3600 from time) LIMIT 5;

-- To see successful authentications
SELECT * FROM unified_log 
    WHERE process = "authd"
    AND subsystem = "com.apple.Authorization"
    AND message LIKE "%Succeeded authorizing right%"
    AND level="default"
    AND timestamp > (select unix_time - 3600 from time) LIMIT 5;








