#################################################################################################################
##USER Define
code-server-start(){
	clear
	nowip=`ip addr | grep eth0 | grep inet | awk '{print $2}'`
    nowip="`echo ${nowip%/*}`:44444"
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
}
alias server-start="code-server-start"
code-server-status(){
    if [ "`ps -ef | grep [c]ode-server`" != "" ];then
        nowip=`ip addr | grep eth0 | grep inet | awk '{print $2}'`
        nowip="`echo ${nowip%/*}`:44444"
        SCREEN_PID="`screen -ls | grep code-server | sed 's:\.:\ :g' | awk '{print $1}'`"
        echo -e "[\e[92mSTATUS\e[0m] : CODE-SERVER RUNNING"
        echo -e "[\e[92mSTATUS\e[0m] : SCREEN_PID - $SCREEN_PID"
        echo -e "[\e[92mSTATUS\e[0m] : $nowip"
    else
        echo -e "[\e[91mSTATUS\e[0m] : CODE-SERVER ERROR"
        echo -e "[\e[91mSTATUS\e[0m] : USE COMMAND [server-start]"
    fi
}
alias server-status="code-server-status"
code-server-status
code-server-newpass(){
    echo -e "[\e[92mINFO-\e[0m] Input now password: "
    read -s nowpass
    relnopass="`grep password: $HOME/.config/code-server/config.yaml | awk '{print $2}'`"
    if [ "$nowpass" = "$relnopass" ];then
        while :;do
            echo -e "[\e[92mINFO-\e[0m] Input new password: "
            read -s newpass
            echo -e "[\e[92mINFO-\e[0m] Input new password again: "
            read -s subnewpass
            if [ "$newpass" = "$subnewpass" ];then
                sed -i "s/password: .*/password: $newpass/g" $HOME/.config/code-server/config.yaml
                echo -e "[\e[92mSUCCS\e[0m] Password changed."
                break
            else
                echo -e "[\e[91mERROR\e[0m] The password entered twice does not match.\nPlz try again.\n"
            fi
        done
    else
        echo -e "[\e[91mERROR\e[0m] Incorrect password."
    fi
}
alias server-newpassword="code-server-newpass"
