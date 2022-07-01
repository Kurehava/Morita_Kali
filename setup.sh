#!/bin/bash
# Powered by SHO Belonging to KanagawaUniversity MoritaLab
# Affiliated with the GravityWallToolsDevelopmentLAB Project
# https://github.com/Kurehava/Morita_Kali

# PATH DEFINE
mkdir /home/$USER/tmp_setup/
export SET_TMP_PATH="/home/$USER/tmp_setup"

# SSH
sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt install ssh
cp /etc/ssh/sshd_config $SET_TMP_PATH
echo "Port 12345" >> $SET_TMP_PATH/sshd_config
echo "PermitRootLogin yes" >> $SET_TMP_PATH/sshd_config
sudo mv $SET_TMP_PATH/sshd_config /etc/ssh/
sudo systemctl enable ssh

# CODE-SERVER
wget "https://github.com/coder/code-server/releases/download/v4.4.0/code-server_4.4.0_arm64.deb" -P $SET_TMP_PATH
sudo dpkg -i $SET_TMP_PATH/code-*
if [ -d "$HOME/.config/code-server/" ];then
	touch "$HOME/.config/code-server/config.yaml"
else
	mkdir -p $HOME/.config/code-server/
	touch "$HOME/.config/code-server/config.yaml"
fi
curl -s -L https://bit.ly/3Oz3BCc > "$HOME/.config/code-server/config.yaml"
#screen -dmS code-server-test && screen -S code-server-test -X stuff 'code-server-test '`echo -ne '\015'`
#kill -9 `ps -ef | grep [S]CREEN\ -dmS\ code-server-test | awk '{print $2}'`

# AUTO-RUN-CODE-SERVER
curl -s -L https://bit.ly/3a6hZTv >> "$HOME/.zshrc"
curl -s -L https://bit.ly/3nrP13H > "$SET_TMP_PATH/code-server-start.sh"
sudo chmod +x "$SET_TMP_PATH/code-server-start.sh"
sudo mv "$SET_TMP_PATH/code-server-start.sh" /etc/init.d/
(crontab -l;echo "@reboot bash /etc/init.d/code-server-start.sh > /dev/null 2>&1") | crontab

# DEL
rm -rf $SET_TMP_PATH
source $HOME/.zshrc
reboot
