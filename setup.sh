#!/bin/bash
# Powered by Kureha Belonging to KanagawaUniversity MoritaLab
# Affiliated with the GravityWallToolsDevelopmentLAB Project

sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt install ssh
mkdir ~/tmp_setup/
cp /etc/ssh/sshd_config ~/tmp_setup/
echo "Port 12345" >> ~/tmp_setup/sshd_config
echo "PermitRootLogin yes" >> ~/tmp_setup/sshd_config
sudo mv ~/tmp_setup/sshd_config /etc/ssh/
sudo systemctl enable ssh
wget "https://github.com/coder/code-server/releases/download/v4.4.0/code-server_4.4.0_arm64.deb" -P ~/tmp_setup/
sudo dpkg -i ~/tmp_setup/code-*
screen -dmS code-server-test && screen -S code-server-test -X stuff 'code-server-test '`echo -ne '\015'`
kill -9 `ps -ef | grep [S]CREEN\ -dmS\ code-server-test | awk -F ' ' '{print $2}'`
rm -rf "/home/$USER/.config/code-server/config.yaml"
touch "/home/$USER/.config/code-server/config.yaml"
echo "bind-addr: 0.0.0.0:44444" >> "/home/$USER/.config/code-server/config.yaml"
echo "auth: password" >> "/home/$USER/.config/code-server/config.yaml"
echo "password: 123456" >> "/home/$USER/.config/code-server/config.yaml"
echo "cert: false" >> "/home/$USER/.config/code-server/config.yaml"
curl -s -L https://bit.ly/3NBAP2q >> ~/tmp_setup/10-code-server
sudo mv ~/tmp_setup/10-code-server /etc/update-motd.d/
rm -rf ~/tmp_setup/
reboot
