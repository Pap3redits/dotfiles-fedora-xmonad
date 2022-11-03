#!/bin/bash

# Copying over config files
cp -r .config $HOME/.config
cp -r .xmonad $HOME/.xmonad
sudo cp dnf.conf /etc/dnf/dnf.conf
mkdir ~/Documents ~/Pictures ~/Downloads

# Turning on gui
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

# DNF package install
sudo dnf -y --allowerasing install $(cat packages|xargs)
sudo systemctl enable sddm

# Obsidian Install 
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install md.obsidian.Obsidian

# Vim Plugin Install 
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# i3lock-color Install 
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./build
./install-i3lock-color.sh

# BetterLockScreen Install
cd
wget https://github.com/betterlockscreen/betterlockscreen/archive/refs/heads/main.zip
unzip main.zip
cd betterlockscreen-main/
chmod u+x betterlockscreen
cp betterlockscreen /usr/local/bin/
cp system/betterlockscreen@.service /usr/lib/systemd/system/
systemctl enable betterlockscreen@$USER

# Enable Sound
systemctl --user enable pipewire-pulse.service pipewire-pulse.socket

# Enable Virtualization
sudo systemctl enable libvirtd
sudo usermod -aG libvirt $USER

echo
echo "################################################################################################"
echo "#################################    Nvidia Setup   ############################################"
echo "################################################################################################"
echo

sudo akmods --force
sudo dracut --force


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
