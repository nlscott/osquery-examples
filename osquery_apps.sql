


-- List of never opened apps
SELECT name, path,  bundle_identifier,bundle_short_version, last_opened_time
    FROM apps
    WHERE path LIKE '/App%'
    AND last_opened_time = -1;

-- Count numner of unopend apps
SELECT count(*) FROM(
SELECT name, path,  bundle_identifier,bundle_short_version, last_opened_time
    FROM apps
    WHERE path LIKE '/App%'
    AND last_opened_time = -1);

-- apps opened in the last 24 hours
SELECT * FROM apps 
    WHERE last_opened_time > (( SELECT unix_time FROM time ) - 86400 ) 
    ORDER BY last_opened_time DESC;

-- interactive command to see apps in the main app folder that have never been opened.
-- osqueryi "SELECT name,path,last_opened_time FROM apps WHERE path LIKE '/Applications%' AND last_opened_time=-1.0"
SELECT name,path,last_opened_time 
    FROM apps 
    WHERE path LIKE '/Applications%' 
    AND last_opened_time=-1.0;


-- Top 10 apps using memory
SELECT pid, name,
    ROUND((total_size * '10e-7'), 2) AS memory_used
    FROM processes
    ORDER BY total_size DESC LIMIT 10;