-- resource: https://www.kolide.com/blog/how-to-spotlight-search-across-every-mac-with-osquery



-- search for a file by file name
SELECT f.path FROM file AS f JOIN mdfind ON mdfind.path = f.path AND mdfind.query = "kMDItemFSName == '*Security*'" LIMIT 5;


-- search for a file by file name and filter out unwanted file paths
SELECT f.path FROM file AS f JOIN mdfind ON mdfind.path = f.path 
    AND mdfind.query = "kMDItemFSName == '*Security*'c" 
    WHERE mdfind.path LIKE "/Users%" 
    AND mdfind.path NOT LIKE "%Library_Containers%"
    AND mdfind.path NOT LIKE "%Library_Application_Support%"  
    LIMIT 10;


-- search for a file by mulitple keywords and filter out unwanted file paths
SELECT f.path FROM file AS f JOIN mdfind ON mdfind.path = f.path 
    AND mdfind.query = "kMDItemFSName == '*Security*'c 
    || kMDItemFSName == '*Password*'c 
    || kMDItemFSName == '*2fA*'c
    || kMDItemFSName == '*login*'c" 
    WHERE mdfind.path LIKE "/Users%" 
    AND mdfind.path NOT LIKE "%Library_Containers%"
    AND mdfind.path NOT LIKE "%Group_Containers%"
    AND mdfind.path NOT LIKE "%Library_Application_Support%"  
    LIMIT 10;


-- find .apps not in the main /Appllicstions folder
SELECT f.path FROM file AS f JOIN mdfind ON mdfind.path = f.path 
    AND mdfind.query = "kMDItemKind == 'Application'" 
    WHERE mdfind.path Not LIKE "%Applications%" 
    AND mdfind.path Not LIKE "%System_Library%"
    AND mdfind.path Not LIKE "%Users_%_Library_CloudStorage%"
    AND mdfind.path Not LIKE "%Library_Application_Support%";

   

