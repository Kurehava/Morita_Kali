clear
port="`grep bind-addr:\  $HOME/.config/code-server/config.yaml | awk '{print $2}' | sed 's/0.0.0.0://g'`"
nowip="`ip addr | grep eth0 | grep inet | awk '{print $2}' | sed 's/\/.*//g'`:$port"
if [ "`ps -ef | grep [c]ode-server`" == "" ];then
	screen -dmS code-server && screen -S code-server -X stuff 'code-server '`echo -ne '\015'`
	if [ "`ps -ef | grep [c]ode-server`" == "" ];then
		echo -e "[\e[91mERROR\e[0m] : CODE-SERVER START EROOR."
		echo -e "[\e[91mERROR\e[0m] : You can start it manually by copying the following command."
		echo "screen -dmS code-server && screen -S code-server -X stuff 'code-server '`echo -ne '\015'`"
	else
		echo -e "[\e[92mSTATUS\e[0m] : CODE-SERVER RUNNING"
		echo -e "[\e[92mSTATUS\e[0m] : $nowip"
	fi
else	
	echo -e "[\e[91mERROR\e[0m] : CODE-SERVER EXSIT."
fi
