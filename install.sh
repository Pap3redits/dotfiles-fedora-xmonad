#!/bin/bash


cp -r .config ~/.config
sudo chmod +x ~/.config/awesome/noobie/filesystem.sh ~/.config/awesome/noobie/memory.sh
sudo cp dnf.conf /etc/dnf/dnf.conf

mkdir ~/Documents ~/Pictures ~/Downloads

systemctl set-default graphical.target

echo
echo "################################################################################################"
echo "#################################    Enabling RPM Fusion   #####################################"
echo "################################################################################################"
echo 

sudo dnf install \
	  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install \
	  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
echo
echo "################################################################################################"
echo "#################################    Installing Required Packages   ############################"
echo "################################################################################################"
echo 

sleep 1

sudo dnf -y --allowerasing install $(cat packages|xargs)
sudo systemctl enable sddm

echo
echo "################################################################################################"
echo "#################################    Changing Shell   ##########################################"
echo "################################################################################################"
echo

chsh -s /usr/bin/fish

echo
echo "################################################################################################"
echo "#################################    Installing Brave Browser   ################################"
echo "################################################################################################"
echo 

sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser

echo
echo "################################################################################################"
echo "#################################    Installing Doom Emacs   ################################"
echo "################################################################################################"
echo

cd
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
cd ~/.emacs.d/bin
./doom install
