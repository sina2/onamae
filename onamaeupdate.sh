#!/bin/sh
{

#
# 0.config
#
HOSTNAME="【更新するホスト名】"
DOMNAME="【更新するドメイン名】"
UNAME="【お名前.comのユーザ名】"
PASSWD="【お名前.comのパスワード】"

. ./user.txt

#
# 1.get external IP for IP change
#

echo -n `date`
IP1=` curl -s https://ugtop.com/ | grep IP |tr "<" " "  | awk '{ print $3 }' `
echo -n "    $IP1"
IP2=`dig @01.dnsv.jp $HOSTNAME.$DOMNAME +short`
echo -n "    $IP2"

#
# 2. if IP is changed , then update to onamae.com
#
if [ $IP1 != $IP2  ]
then
  echo "    NG "
  expect ./onamae.exp $IP1 $HOSTNAME $DOMNAME $UNAME $PASSWD
else
  echo "    OK "
fi

exit
}
