#!/bin/bash


db_host="172.16.1.122"
db_user="root"
db_pass="toor"
db_name="gitdigger"
db_namebb="bitdigger"

echo "Dumping:"

echo "    Github Usernames..." 
mysql -h$db_host -u$db_user -p$db_pass -D$db_name -N -e 'SELECT DISTINCT username FROM projects ORDER BY username ASC' > github-usernames.txt
tar -czf github-usernames.tar.gz github-usernames.txt
rm github-usernames.txt

echo "    Github Repositores..."
mysql -h$db_host -u$db_user -p$db_pass -D$db_name -N -e 'SELECT DISTINCT name FROM projects ORDER BY username ASC' > github-repositories.txt
tar -czf github-repositories.tar.gz github-repositories.txt
rm github-repositories.txt

echo "    All Directories with Counts..."
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'SELECT count,name FROM dirs ORDER BY count DESC' | awk '{print $1" " substr($0, index($0,$2))}' > all_dirs-wc.txt
tar -czf all_dirs-wc.tar.gz all_dirs-wc.txt
rm all_dirs-wc.txt

echo "    All Directories without Counts..."
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'SELECT name FROM dirs ORDER BY count DESC' > all_dirs.txt
tar -czf all_dirs.tar.gz all_dirs.txt
rm all_dirs.txt

echo "    All Files with Counts..."
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'SELECT count,name FROM files ORDER BY count DESC' | awk '{print $1" " substr($0, index($0,$2))}' > all_files-wc.txt

echo "    All Files without Counts..."
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'SELECT name FROM files ORDER BY count DESC' > all_files.txt

echo "    BitBucket Usernames..." 
mysql -h$db_host -u$db_user -p$db_pass -D$db_namebb -N -e 'SELECT DISTINCT name FROM bb_users WHERE scanned=1 ORDER BY name ASC' > bitbucket-usernames.txt
tar -czf bitbucket-usernames.tar.gz bitbucket-usernames.txt
rm bitbucket-usernames.txt

echo "    BitBucket Repositores..."
mysql -h$db_host -u$db_user -p$db_pass -D$db_namebb -N -e 'SELECT DISTINCT name FROM bb_projects ORDER BY name ASC' > bitbucket-repositories.txt
tar -czf bitbucket-repositories.tar.gz bitbucket-repositories.txt
rm bitbucket-repositories.txt



echo "    Creating Sub Files..."
mkdir -p content
mkdir -p cat/conf
mkdir -p cat/database
mkdir -p cat/language
mkdir -p cat/project
mkdir -p sec

egrep -iv '\.' all_files.txt > extensionless.txt
tar -czf extensionless.tar.gz extensionless.txt
egrep -iv '\.' all_files-wc.txt > extensionless-wc.txt
tar -czf extensionless-wc.tar.gz extensionless-wc.txt
rm extensionless*.txt

echo "        Dumping Content"
content_itms=('admin' 'debug' 'error' 'help' 'index' 'install' 'log' 'readme' 'root' 'setup' 'test')
for itm in "${content_itms[@]}"
do
	grep -i $itm all_files.txt > content/$itm.txt
	tar -czf content/$itm.tar.gz -C content/ $itm.txt
	rm content/$itm.txt
	
	grep -i $itm all_files-wc.txt > content/$itm-wc.txt
	tar -czf content/$itm-wc.tar.gz -C content/ $itm-wc.txt
	rm content/$itm-wc.txt
done

echo "        Dumping Config"
conf_itms=('\.conf$' '\.config$' '\.htaccess$' '\.properties$')
for itm in "${conf_itms[@]}"
do
	egrep -i $itm all_files.txt > cat/conf/${itm:2:${#itm}-3}.txt
	tar -czf cat/conf/${itm:2:${#itm}-3}.tar.gz -C cat/conf/ ${itm:2:${#itm}-3}.txt
	rm cat/conf/${itm:2:${#itm}-3}.txt
	
	egrep -i $itm all_files-wc.txt > cat/conf/${itm:2:${#itm}-3}-wc.txt
	tar -czf cat/conf/${itm:2:${#itm}-3}-wc.tar.gz -C cat/conf/ ${itm:2:${#itm}-3}-wc.txt
	rm cat/conf/${itm:2:${#itm}-3}-wc.txt
done

echo "        Dumping Projects"
project_itms=('\.csproj$' '\.pdb$' '\.resx$' '\.sln$' '\.suo$' '\.vbproj$' '\.class$')
for itm in "${project_itms[@]}"
do
	egrep -i $itm all_files.txt > cat/project/${itm:2:${#itm}-3}.txt
	tar -czf cat/project/${itm:2:${#itm}-3}.tar.gz -C cat/project/ ${itm:2:${#itm}-3}.txt
	rm cat/project/${itm:2:${#itm}-3}.txt
	
	egrep -i $itm all_files-wc.txt > cat/project/${itm:2:${#itm}-3}-wc.txt
	tar -czf cat/project/${itm:2:${#itm}-3}-wc.tar.gz -C cat/project/ ${itm:2:${#itm}-3}-wc.txt
	rm cat/project/${itm:2:${#itm}-3}-wc.txt
done

echo "        Dumping Databases"
database_itms=('\.csv$' '\.inc$' '\.ini$' '\.mdb$' '\.mdf$' '\.sql$' '\.xml$' '\.kdbx$' '\.md$')
for itm in "${database_itms[@]}"
do
	egrep -i $itm all_files.txt > cat/database/${itm:2:${#itm}-3}.txt
	tar -czf cat/database/${itm:2:${#itm}-3}.tar.gz -C cat/database/ ${itm:2:${#itm}-3}.txt
	rm cat/database/${itm:2:${#itm}-3}.txt
	
	egrep -i $itm all_files-wc.txt > cat/database/${itm:2:${#itm}-3}-wc.txt
	tar -czf cat/database/${itm:2:${#itm}-3}-wc.tar.gz -C cat/database/ ${itm:2:${#itm}-3}-wc.txt
	rm cat/database/${itm:2:${#itm}-3}-wc.txt
done

echo "        Dumping Security Items"
sec_itms=('\.pem$' '\.cer$' '\.key$' '\.crt$' '\.jks$' '\.pfx$' '\.pkcs10$' '\.pkcs12$' '\.rsa$' '\.dsa$' '\.ppk$')
for itm in "${sec_itms[@]}"
do
	egrep -i $itm all_files.txt > sec/${itm:2:${#itm}-3}.txt
	tar -czf sec/${itm:2:${#itm}-3}.tar.gz -C sec/ ${itm:2:${#itm}-3}.txt
	rm sec/${itm:2:${#itm}-3}.txt
	
	egrep -i $itm all_files-wc.txt > sec/${itm:2:${#itm}-3}-wc.txt
	tar -czf sec/${itm:2:${#itm}-3}-wc.tar.gz -C sec/ ${itm:2:${#itm}-3}-wc.txt
	rm sec/${itm:2:${#itm}-3}-wc.txt
done

echo "        Dumping Language Items"
language_itms=('\.ascx$' '\.asp$' '\.aspx$' '\.c$' '\.cfm$' '\.cpp$' '\.cs$' '\.css$' '\.html$' '\.h$' '\.jar$' '\.java$' '\.js$' '\.jsp$' '\.php$' '\.php3$' '\.php5$' '\.phpt$' '\.pl$' '\.pm$' '\.pod$' '\.py$' '\.rb$' '\.sh$' '\.swf$' '\.tpl$' '\.vb$' '\.wsdl$')
for itm in "${language_itms[@]}"
do
	egrep -i $itm all_files.txt > cat/language/${itm:2:${#itm}-3}.txt
	tar -czf cat/language/${itm:2:${#itm}-3}.tar.gz -C cat/language/ ${itm:2:${#itm}-3}.txt
	rm cat/language/${itm:2:${#itm}-3}.txt
	
	egrep -i $itm all_files-wc.txt > cat/language/${itm:2:${#itm}-3}-wc.txt
	tar -czf cat/language/${itm:2:${#itm}-3}-wc.tar.gz -C cat/language/ ${itm:2:${#itm}-3}-wc.txt
	rm cat/language/${itm:2:${#itm}-3}-wc.txt
done

echo "    cleanup..."
tar -czf all_files.tar.gz all_files.txt
rm all_files.txt
tar -czf all_files-wc.tar.gz all_files-wc.txt
rm all_files-wc.txt


