#!/bin/bash


db_host="172.16.1.122"
db_user="root"
db_pass="toor"
db_name="gitdigger"

echo "Dumping:"

echo "    github usernames..." 
mysql -h$db_host -u$db_user -p$db_pass -D$db_name -N -e 'SELECT DISTINCT username FROM projects ORDER BY username ASC' > github-usernames.txt

echo "    github repositores..."
mysql -h$db_host -u$db_user -p$db_pass -D$db_name -N -e 'SELECT DISTINCT name FROM projects ORDER BY username ASC' > github-repositories.txt


echo "Compressing data..."

tar -czf github_users.tar.gz github_users.txt
tar -czf github_projects.tar.gz github_projects.txt

echo "Cleaning up..."

