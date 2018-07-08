# osquery examples



![alt text](https://cdn-images-1.medium.com/max/1600/1*XC-k2QigREIwZnBpFZ4StA@2x.png "osquery")

Query information about your devices with basic sql syntax.

<https://osquery.io>

#### Examples:

```sql

--show users accounts
SELECT * FROM users WHERE uid > 500;

--show all firewall exceptions
SELECT * FROM alf_exceptions;

--applications that have never been opened
SELECT name, bundle_version,path,last_opened_time  FROM apps WHERE path LIKE "/Applications%" AND last_opened_time < 1;

--show third party kernal exstentions
SELECT * FROM kernel_extensions WHERE name NOT LIKE "com.apple.%";

-- show applications and versions
SELECT name, bundle_version,path,last_opened_time  FROM apps WHERE path LIKE "/Applications%";

--show logged in console users
SELECT * FROM logged_in_users WHERE tty LIKE "console";

--computer info
SELECT hostname,hardware_model,hardware_serial FROM system_info;

--netwowrk interfaces
SELECT * FROM interface_addresses;

--get ethernet IPV4
SELECT * FROM interface_addresses WHERE interface LIKE "en%" AND address LIKE "%.%.%.%";

--join to see failed login attempts
osquery> SELECT creation_time,failed_login_count,failed_login_timestamp,username,users.uid FROM account_policy_data INNER JOIN users on account_policy_data.uid = users.uid;
```
