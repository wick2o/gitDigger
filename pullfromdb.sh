#!/bin/bash

echo "Dumping Data From Databases..."

mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'SELECT count,name FROM passwords ORDER BY count DESC' | awk '{print $1" " substr($0, index($0,$2))}' > passwords.txt
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'SELECT count,name FROM usernames ORDER BY count DESC' | awk '{print $1" " substr($0, index($0,$2))}' > usernames.txt
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'SELECT count,name FROM salts ORDER BY count DESC' | awk '{print $1" " substr($0, index($0,$2))}' > static_salts.txt
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'SELECT DISTINCT username FROM projects ORDER BY username ASC' > github_usernames.txt
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'SELECT DISTINCT name FROM projects ORDER BY name ASC' > github_projectnames.txt
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'select distinct substring_index(name,'@',+1) as uname from emails order by uname asc' > email_usernames.txt
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'SELECT count,name FROM files ORDER BY count DESC' | awk '{print $1" " substr($0, index($0,$2))}' > all_files.txt
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'SELECT count,name FROM dirs ORDER BY count DESC' | awk '{print $1" " substr($0, index($0,$2))}' > all_dirs.txt

echo "Creatating sub files from all_files.txt"

egrep -iv '\.' all_files.txt > all-extensionless.txt

grep -i admin all_files.txt > content/admin.txt
grep -i debug all_files.txt > content/debug.txt
grep -i error all_files.txt > content/error.txt
grep -i help all_files.txt > content/help.txt
grep -i index all_files.txt > content/index.txt
grep -i install all_files.txt > content/install.txt
grep -i log all_files.txt > content/log.txt
grep -i readme all_files.txt > content/readme.txt
grep -i root all_files.txt > content/root.txt
grep -i setup all_files.txt > content/setup.txt
grep -i test all_files.txt > content/test.txt

egrep -i '\.conf$' all_files.txt > cat/conf/conf.txt
egrep -i '\.config$' all_files.txt > cat/conf/config.txt
egrep -i '\.htaccess$' all_files.txt > cat/conf/htaccess.txt
egrep -i '\.properties$' all_files.txt > cat/conf/properties.txt

egrep -i '\.inc$' all_files.txt > cat/database/inc.txt
egrep -i '\.ini$' all_files.txt > cat/database/ini.txt
egrep -i '\.mdb$' all_files.txt > cat/database/mdb.txt
egrep -i '\.mdf$' all_files.txt > cat/database/mdf.txt
egrep -i '\.sql$' all_files.txt > cat/database/sql.txt
egrep -i '\.xml$' all_files.txt > cat/database/xml.txt
egrep -i '\.kdbx$' all_files.txt > cat/database/kdbx.txt

egrep -i '\.ascx$' all_files.txt > cat/language/ascx.txt
egrep -i '\.asp$' all_files.txt > cat/language/asp.txt
egrep -i '\.aspx$' all_files.txt > cat/language/aspx.txt
egrep -i '\.c$' all_files.txt > cat/language/c.txt
egrep -i '\.cfm$' all_files.txt > cat/language/cfm.txt
egrep -i '\.cpp$' all_files.txt > cat/language/cpp.txt
egrep -i '\.cs$' all_files.txt > cat/language/cs.txt
egrep -i '\.css$' all_files.txt > cat/language/css.txt
egrep -i '\.html$' all_files.txt > cat/language/html.txt
egrep -i '\.jar$' all_files.txt > cat/language/jar.txt
egrep -i '\.java$' all_files.txt > cat/language/java.txt
egrep -i '\.js$' all_files.txt > cat/language/js.txt
egrep -i '\.jsp$' all_files.txt > cat/language/jsp.txt
egrep -i '\.php$' all_files.txt > cat/language/php.txt
egrep -i '\.php3$' all_files.txt > cat/language/php3.txt
egrep -i '\.php5$' all_files.txt > cat/language/php5.txt
egrep -i '\.phpt$' all_files.txt > cat/language/phpt.txt
egrep -i '\.pl$' all_files.txt > cat/language/pl.txt
egrep -i '\.py$' all_files.txt > cat/language/py.txt
egrep -i '\.rb$' all_files.txt > cat/language/rb.txt
egrep -i '\.sh$' all_files.txt > cat/language/sh.txt
egrep -i '\.swf$' all_files.txt > cat/language/swf.txt
egrep -i '\.tpl$' all_files.txt > cat/language/tpl.txt
egrep -i '\.vb$' all_files.txt > cat/language/vb.txt
egrep -i '\.wsdl$' all_files.txt > cat/language/wsdl.txt

egrep -i '\.csproj$' all_files.txt > cat/project/csproj.txt
egrep -i '\.pdb$' all_files.txt > cat/project/pdb.txt
egrep -i '\.resx$' all_files.txt > cat/project/resx.txt
egrep -i '\.sln$' all_files.txt > cat/project/sln.txt
egrep -i '\.suo$' all_files.txt > cat/project/suo.txt
egrep -i '\.vbproj$' all_files.txt > cat/project/vbproj.txt

egrep -i '\.pem$' all_files.txt > sec/pem.txt
egrep -i '\.cer$' all_files.txt > sec/cer.txt
egrep -i '\.key$' all_files.txt > sec/key.txt
egrep -i '\.crt$' all_files.txt > sec/crt.txt
egrep -i '\.jks$' all_files.txt > sec/jks.txt
egrep -i '\.pfx$' all_files.txt > sec/pfx.txt
egrep -i '\.pkcs10$' all_files.txt > sec/pkcs10.txt
egrep -i '\.pkcs12$' all_files.txt > sec/pkcs12.txt
egrep -i '\.rsa$' all_files.txt > sec/rsa.txt
egrep -i '\.dsa$' all_files.txt > sec/dsa.txt
egrep -i '\.ppk$' all_files.txt > sec/ppk.txt

echo "Pulling updated stats for readme"

mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'SELECT format(count(id),0) from projects' | awk '{print "Repositories Cloned: "$1}'
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'select format(count(id),0) from projects where processed = 2' | awk '{print "Repositories Processed: "$1}'
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'select format(count(distinct username),0) from projects' | awk '{print "Repository Users: "$1}'
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'select format(count(id),0), format(sum(count),0) from passwords' | awk '{print "Passwords Carved: "$1" unique from "$2" total"}'
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'select format(count(id),0), format(sum(count),0) from usernames' | awk '{print "Usernames Carved: "$1" unique from "$2" total"}'
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'select format(count(id),0), format(sum(count),0) from dirs' | awk '{print "Directories: "$1" unique from "$2" total"}'
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'select format(count(id),0), format(sum(count),0) from files' | awk '{print "Files: "$1" unique from "$2" total"}'
mysql -h172.16.1.122 -uroot -ptoor -Dgitdigger -N -e 'select format(count(id),0), format(sum(count),0) from emails' | awk '{print "Emails: "$1" unique from "$2" total"}'

echo "done"