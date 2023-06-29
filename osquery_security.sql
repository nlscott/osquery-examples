
-- Processes running on disk without a binary on disk. could be from malware thas has delete the parent app
SELECT name,path,pid FROM processes WHERE on_disk=0;

-- unecnrypted comptuers
SELECT * FROM mounts m,disk_encryption d WHERE m.device_alias = d.name and m.path = "/" and d.encrypted = 1;


-- Finding new processes listening on network ports
SELECT DISTINCT process.name, listening.port, listening.address, process.pid 
    FROM processes 
    AS process 
    JOIN listening_ports 
    AS listening 
    ON process.pid = listening.pid;

-- Finding suspicious outbound network activity
select s.pid, p.name, local_address, remote_address, family, protocol, local_port, remote_port 
    from process_open_sockets s 
    join processes p on s.pid = p.pid 
    where remote_port not in (80, 443) and family = 2;



-- see sudo command histroy
SELECT uid,time,command 
    FROM shell_history 
    WHERE command LIKE 'sudo%';

--show firewall exceptions
SELECT * FROM alf_exceptions;

--applications that have never been opened
SELECT name, bundle_version,path,last_opened_time  FROM apps WHERE path LIKE "/Applications%" AND last_opened_time < 1;

--show third party kernal exstentions
SELECT * FROM kernel_extensions WHERE name NOT LIKE "com.apple.%";

-- show apps
SELECT name, bundle_version,path,last_opened_time  FROM apps WHERE path LIKE "/Applications%";

--show logged in console users
SELECT * FROM logged_in_users WHERE tty LIKE "console";

--computer info
SELECT hostname,hardware_model,hardware_serial FROM system_info;

--join to see failed login attempts
SELECT creation_time,failed_login_count,failed_login_timestamp,username,users.uid FROM account_policy_data INNER JOIN users on account_policy_data.uid = users.uid;

-- List /Library/LaunchDaemons
SELECT path, name, program_arguments FROM launchd WHERE path LIKE "/Library/LaunchDaemons%";

-- list users laughagents
SELECT path, name, program_arguments FROM launchd WHERE path LIKE "/Users/%";

-- list users laughagents
SELECT COUNT(path) FROM launchd WHERE path LIKE "/Users/%";

-- Top 5 system processes
SELECT pid, name, user_time, system_time FROM processes ORDER by system_time desc LIMIT 5;

-- Top 5 user processes
SELECT pid, name, user_time, system_time FROM processes ORDER by user_time desc LIMIT 5;

SELECT pid, name, user_time, system_time FROM processes ORDER by (user_time + system_time) desc LIMIT 5;

-- Top 5 apps using memory in MBS
SELECT pid, name, round((total_size * 10e-7),2) as Memory_in_MBs FROM processes ORDER by total_size desc LIMIT 5;



-- current connected USB devices
SELECT * FROM usb_devices;

-- show mounted usb drives
SELECT * FROM mounts WHERE path LIKE "/Volumes%";

-- showing all running apps that are not apple
SELECT * FROM running_apps WHERE bundle_identifier NOT LIKE "%com.apple%" AND bundle_identifier NOT LIKE "";


-- enteries to /etc/hosts
SELECT * FROM etc_hosts 
WHERE address not in (
    '127.0.0.1', 
    '::1',
    '255.255.255.255');

-- Find listening ports
SELECT pid,family,protocol,port,name,uid,disk_bytes_read,disk_bytes_written,start_time
    FROM listening_ports
    JOIN processes USING (pid)
    WHERE port > 0;

