#! /bin/sh

#
# In Mac OS X, what network location is set?
#

if [ -f "/usr/sbin/scselect" ]; then
    export LOCATION=$(/usr/sbin/scselect 2>&1 | perl -ne 'if (m/^\s+\*\s+(\S+)\s+\((.+)\)$/) { print "$2\n"; }')
fi

case ${LOCATION} in
    "Home")
	unset http_proxy
	unset https_proxy
	unset ftp_proxy
	unset RSYNC_PROXY
	cp ${HOME}/.subversion/Home/servers ${HOME}/.subversion/servers
	cp ${HOME}/.m2/Home/settings.xml ${HOME}/.m2/settings.xml
	;;
    "Halliburton")
#	PROXY=houprxy801.corp.halliburton.com
#	PROXY=np1prxy801.corp.halliburton.com
#       PORT=80
	PROXY=localhost
        PORT=3128
	export http_proxy=http://${PROXY}:${PORT}
# 
# Because git and citrix are failing with cntlm 0.92.3
#
	export https_proxy=http://np1prxy801.corp.halliburton.com:80
	export ftp_proxy=http://${PROXY}:${PORT}
	export RSYNC_PROXY=${PROXY}:${PORT}
	cp ${HOME}/.subversion/Halliburton/servers ${HOME}/.subversion/servers
	cp ${HOME}/.m2/Halliburton/settings.xml ${HOME}/.m2/settings.xml
	;;
    "Automatic")
	unset http_proxy
	unset https_proxy
	unset ftp_proxy
	unset RSYNC_PROXY
	cp ${HOME}/.subversion/Automatic/servers ${HOME}/.subversion/servers
	cp ${HOME}/.m2/Automatic/settings.xml ${HOME}/.m2/settings.xml
	;;
    *)
	unset http_proxy
	unset https_proxy
	unset ftp_proxy
	unset RSYNC_PROXY
	cp ${HOME}/.subversion/Automatic/servers ${HOME}/.subversion/servers
	cp ${HOME}/.m2/Automatic/settings.xml ${HOME}/.m2/settings.xml
	;;
esac

