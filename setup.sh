#!/bin/bash

# set some colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"
INSTLOG="install.log"

#clear the screen
clear

# set some expectations for the user
echo -e "$CNT - You are about to execute a script that would attempt to setup Hyprland.
Please note that Hyprland is still in Beta.
Please note that VMs are not fully supported and if you try to run this on
a Virtual Machine there is a high chance this will fail.
Please note that support for Nvidia GPUs is limited and may require
more work which is beyond the scope of this script.
\n"

read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to continue with the install (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    echo -e "$COK - Starting install script.."
else
    echo -e "$CNT - This script would now exit, no changes were made to your system."
    exit
fi


echo -e "\n
$CNT - This script will run some commands that require sudo. You will be prompted to enter your password.
If you are worried about entering your password then you may want to review the content of the script."

#### Check for yay ####
ISYAY=/sbin/yay
if [ -f "$ISYAY" ]; then
    echo -e "$COK - yay was located, moving on."
else
    echo -e "$CWR - Yay was NOT located"
    read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to install yay (y,n) ' INSTYAY
    if [[ $INSTYAY == "Y" || $INSTYAY == "y" ]]; then
        git clone https://aur.archlinux.org/yay.git &>> $INSTLOG
        cd yay
        makepkg -si --noconfirm &>> ../$INSTLOG
        cd ..

    else
        echo -e "$CER - Yay is required for this script, now exiting"
        exit
    fi
fi

### Disable wifi powersave mode ###
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to disable WiFi powersave? (y,n) ' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
    LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
    echo -e "$CNT - The following file has been created $LOC."
    echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC &>> $INSTLOG
    echo -e "\n"
    sleep 1
    sudo systemctl restart NetworkManager &>> $INSTLOG
    sleep 3
fi

### Install all of the above pacakges ####
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to install the packages? (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    # update the DB first
    echo -e "$COK - Updating yay database..."
    yay -Syu --noconfirm &>> $INSTLOG

    PACKAGES="ttf-dejavu" # need to fix fonts
    PACKAGES="$PACKAGES ttf-jetbrains-mono-nerd noto-fonts-emoji otf-font-awesome"
    PACKAGES="$PACKAGES git tk polkit-gnome python-requests pamixer pavucontrol brightnessctl mpv xorg-xev"
    PACKAGES="$PACKAGES less wl-clipboard xorg-xhost wf-recorder zenity jq xdg-utils ntfs-3g"
    PACKAGES="$PACKAGES pipewire wireplumber pipewire-pulse pipewire-audio pipewire-alsa"
    PACKAGES="$PACKAGES hyprland-git alacritty waybar swww swaylock-effects wofi wlogout swayidle"
    PACKAGES="$PACKAGES swaync-git xdg-desktop-portal-hyprland swappy grim slurp thunar kdeconnect breeze-icons"
    PACKAGES="$PACKAGES bluez bluez-utils blueman network-manager-applet gvfs thunar-archive-plugin tumbler"
    PACKAGES="$PACKAGES file-roller btop pacman-contrib lxappearance xfce4-settings sddm thunar-volman"
    PACKAGES="$PACKAGES gst-libav phonon-qt5-gstreamer gst-plugins-good qt5-quickcontrols qt5-graphicaleffects qt5-multimedia"

    ### These are personal applications I use, feel free to remove or change ###
    APPS="google-chrome gparted slack-desktop-wayland spotify"

    PACKAGES="$PACKAGES $APPS"

    echo -e "\n$CNT - Installing main packages, this may take a while..."
    yay -S $PACKAGES --noconfirm --needed --overwrite &>> $INSTLOG


    echo -e "$CNT - Set default applications..."
    xdg-mime default google-chrome.desktop x-scheme-handler/https x-scheme-handler/http
    xdg-settings set default-web-browser google-chrome.desktop

    # start pipewire
    echo -e "$CNT - Starting the Pulseaudio Service..."
    systemctl --user enable pipewire.service &>> $INSTLOG
    systemctl --user enable pipewire-pulse.service &>> $INSTLOG

    # Start the bluetooth service
    echo -e "$CNT - Starting the Bluetooth Service..."
    sudo systemctl enable bluetooth.service &>> $INSTLOG
    sleep 2

    # Enable the sddm login manager service
    echo -e "$CNT - Enabling the SDDM Service..."
    sudo systemctl enable sddm &>> $INSTLOG
    sleep 2

    # Clean out other portals
    echo -e "$CNT - Cleaning out conflicting xdg portals..."
    yay -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk xdg-desktop-portal-dde &>> $INSTLOG
fi


### These are personal applications I use, feel free to remove or change ###
PACKAGES="docker docker-compose docker-buildx virtualbox virtualbox-host-dkms linux-headers virtualbox-guest-iso virtualbox-ext-oracle tlp"

read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like install these packages? '"${PACKAGES}"' (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    echo -e "\n$CNT - Installing additional packages, this may take a while..."
    yay -Syu --noconfirm &>> $INSTLOG
    yay -S $PACKAGES --noconfirm --needed --overwrite &>> $INSTLOG

    echo -e "\n$CNT - Adding user to groups..."
    sudo usermod -aG docker,vboxusers,storage,disk,input $USER

    echo -e "\n$CNT - Enabling docker and vbox services..."
    sudo systemctl enable docker.service
    # sudo systemctl enable systemd-modules-load.service

    # enable tlp
    echo -e "\n$CNT - Configuring tlp service..."
    sudo systemctl enable tlp.service
    sudo systemctl mask systemd-rfkill.service
    sudo systemctl mask systemd-rfkill.socket
    echo -e "TLP_DEFAULT_MODE=BAT" | sudo tee -a /etc/tlp.conf
    echo -e "STOP_CHARGE_THRESH_BAT0=80" | sudo tee -a /etc/tlp.conf
    echo -e "RESTORE_THRESHOLDS_ON_BAT=1" | sudo tee -a /etc/tlp.conf
fi

### Copy Config Files ###
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to copy config files? (y,n) ' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
    echo -e "$CNT - Copying config files..."
    for DIR in alacritty hypr swappy swaylock waybar wlogout wofi swaync
    do
        DIRPATH=~/.config/$DIR
        if [ -d "$DIRPATH" ]; then
            echo -e "$CAT - Config for $DIR located, backing up."
            mv $DIRPATH $DIRPATH-back-$(date +"%Y%m%d%H%M%S") &>> $INSTLOG
            echo -e "$COK - Backed up $DIR to $DIRPATH-back."
        fi
        echo -e "$CNT - Copying $DIR config to $DIRPATH."
        cp -R $DIR ~/.config/ &>> $INSTLOG
    done

    # Set some files as exacutable
    echo -e "$CNT - Setting some file as executable."
    chmod +x ~/.config/hypr/scripts/*
    chmod +x ~/.config/mako/scripts/*

    # Copy the SDDM theme
    echo -e "$CNT - Setting up the login screen."
    sudo cp -R ./sddm/aerial-sddm-theme /usr/share/sddm/themes
    sudo chown -R $USER:$USER /usr/share/sddm/themes/aerial-sddm-theme
    sudo mkdir -p /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=aerial-sddm-theme" | sudo tee /etc/sddm.conf.d/10-theme.conf &>> $INSTLOG
    WLDIR=/usr/share/wayland-sessions
    if [ -d "$WLDIR" ]; then
        echo -e "$COK - $WLDIR found"
    else
        echo -e "$CWR - $WLDIR NOT found, creating..."
        sudo mkdir -p $WLDIR
    fi
    sudo cp extras/hyprland.desktop /usr/share/wayland-sessions/
    sudo sudo sed -i 's/Exec=Hyprland/Exec=\/home\/'$USER'\/start-hypr/' /usr/share/wayland-sessions/hyprland.desktop
    cp extras/start-hypr ~/

    #setup the first look and feel as dark
    xfconf-query -c xsettings -p /Net/ThemeName -s "Adwaita-dark"
    xfconf-query -c xsettings -p /Net/IconThemeName -s "Adwaita-dark"
    gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
    gsettings set org.gnome.desktop.interface icon-theme "Adwaita-dark"

    # Set deskstop wallpaper
    # Cycle wallpapers in ~/.config/hypr/wallpapers every 5 mins
    echo -e "$CNT - Configuring desktop wallpapers..."
    mkdir -p ~/.config/systemd/user
    cp -r systemd/user/. ~/.config/systemd/user
    systemctl --user daemon-reload
    systemctl --user enable bgaction.timer
    systemctl --user start bgaction.timer
    systemctl --user status bgaction.timer
fi

### Enable hiDPI for hi-res screens ###
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to enable hiDPI? (y,n) ' HIDPI
if [[ $HIDPI == "Y" || $HIDPI == "y" ]]; then
    sudo cp ./sddm/sddm.conf.d/hidpi.conf /etc/sddm.conf.d/
fi

### Install the starship shell ###
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to activate the starship shell? (y,n) ' STAR
if [[ $STAR == "Y" || $STAR == "y" ]]; then
    # install the starship shell
    echo -e "$CNT - Hansen Crusher, Engage!"
    echo -e "$CNT - Updating .bashrc..."
    echo -e '\neval "$(starship init bash)"' >> ~/.bashrc
    echo -e '\neval "$(starship init zsh)"' >> ~/.zshrc
    echo -e "$CNT - copying starship config file to ~/.confg ..."
    cp extras/starship.toml ~/.config/
fi

### Install software for Asus ROG laptops ###
read -n1 -rep $'[\e[1;33mACTION\e[0m] - For ASUS ROG Laptops - Would you like to install Asus ROG software support? (y,n) ' ROG
if [[ $ROG == "Y" || $ROG == "y" ]]; then
    echo -e "$CNT - Adding Keys..."
    sudo pacman-key --recv-keys 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35 &>> $INSTLOG
    sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35 &>> $INSTLOG
    sudo pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35 &>> $INSTLOG
    sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35 &>> $INSTLOG

    LOC="/etc/pacman.conf"
    echo -e "$CNT - Updating $LOC with g14 repo."
    echo -e "\n[g14]\nServer = https://arch.asus-linux.org" | sudo tee -a $LOC &>> $INSTLOG
    echo -e "\n"
    echo -e "$CNT - Update the system..."
    sudo pacman -Suy --noconfirm &>> $INSTLOG

    echo -e "$CNT - Installing ROG pacakges..."
    sudo pacman -S --noconfirm asusctl supergfxctl rog-control-center &>> $INSTLOG
    echo -e "$CNT - Activating ROG services..."
    sudo systemctl enable --now power-profiles-daemon.service &>> $INSTLOG
    sleep 2
    sudo systemctl enable --now supergfxd &>> $INSTLOG
    sleep 2

    #add the keybinding file to the config
    echo -e "\nsource = ~/.config/hypr/rog-g15-strix-2021-binds.conf" >> ~/.config/hypr/hyprland.conf
fi

### Install grub theme ###
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would like to install grub theme? (y,n) ' GRUB
if [[ $GRUB == "Y" || $GRUB == "y" ]]; then
    workdir=$(pwd)
    extract_dir="/tmp/grub2-cybre"

    rm -rf $extract_dir
    mkdir -p $extract_dir

    echo -e "$CNT - Installing grub theme..."
    tar xvf ./extras/Grub2-theme_CyberRe-1.0.0.tar.gz --directory "${extract_dir}" &>> $INSTLOG && \
        cd "${extract_dir}/CyberRe 1.0.0" && ./install.sh && \
        echo -e "GRUB_GFXMODE=1920x1080x32" | sudo tee -a /etc/default/grub &>> $INSTLOG && \
        sudo grub-mkconfig -o /boot/grub/grub.cfg &>> $INSTLOG

    cd $workdir
fi

### Script is done ###
echo -e "$CNT - Script had completed!"
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to start Hyprland now? (y,n) ' HYP
if [[ $HYP == "Y" || $HYP == "y" ]]; then
    exec sudo systemctl start sddm &>> $INSTLOG
else
    exit
fi
