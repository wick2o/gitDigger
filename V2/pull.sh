#!/bin/bash


db_host="172.16.1.122"
db_user="root"
db_pass="toor"
db_name="gitdigger"

echo "Dumping:"

echo "    github usernames..." 
mysql -h$db_host -u$db_user -p$db_pass -D$db_name -N -e 'SELECT DISTINCT username FROM projects ORDER BY username ASC' > github-usernames.txt
tar -czf github-usernames.tar.gz github-usernames.txt
rm github-usernames.txt

echo "    github repositores..."
mysql -h$db_host -u$db_user -p$db_pass -D$db_name -N -e 'SELECT DISTINCT name FROM projects ORDER BY username ASC' > github-repositories.txt
tar -czf github-repositories.tar.gz github-repositories.txt
rm github-repositories.txt

