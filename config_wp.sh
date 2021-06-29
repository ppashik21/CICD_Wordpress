my_ip=$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
retries=0
while :
do
  if wp core install --url="mysite" --title="Wordpress" --admin_user="admin" --admin_password="123" --admin_email="admin@sample.com"
  then
    break
  else
    retries=$((retries+1))
    echo "Couldn't connect to DB. Try - ${retries}. Sleeping 5 seconds and will retry ..."
    sleep 5
  fi
  if [ "${retries}" -eq "30" ]
  then
    echo "Couldn't connect to DB 30 times. Exiting."
    exit 1
  fi
done
wp theme install dynamico --activate
wp theme uninstall twentynineteen
wp theme uninstall twentyseventeen
wp theme uninstall twentytwenty
wp language core install ru_RU --activate
