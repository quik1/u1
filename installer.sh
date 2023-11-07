#!/bin/bash

hyprlandp="
	hyprland-git
	xdg-desktop-portal-hyprland-git
xdg-desktop-portal-wlr-git
xdg-desktop-portal-gtk 
    xorg-xwayland
    qt5-wayland
    catppuccin-gtk-theme-mocha
    qt6-wayland
    qt5ct
    qt6ct
    libva
    linux-headers 
    pipewire 
    pipewire-alsa 
    pipewire-pulse 
    pipewire-jack 
    pavucontrol
    wireplumber
    dunst
    
"

components="
	mako
 clipman
    jq
    waybar
    rofi-lbonn-wayland
    polkit-kde-agent
    swaybg
    gtklock
    swww
    fish
    fish
    cliphist
    swayimg
    python-pywal
    pamixer 
    grimblast-git
    network-manager-applet 
    kitty
    thunar
    thunar-archive-plugin 
    file-roller 
    gtk-engine-murrine 
    gnome-themes-extra
    xdg-user-dirs-gtk
    micro
    rustup
"

programs="
	firefox
	eog
	nwg-look
	marker
 geany
 geany-plugins
	spotify
	vlc
"


font="
    ttf-jetbrains-mono
    ttf-nerd-fonts-symbols
    papirus-icon-theme
"

read -rep $'Proceed with installation? (y - n)' ANSWER

if [[ $ANSWER == "Y" || $ANSWER == "y" ]]; then
	echo "Installing paru.."
	sleep 3
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    rm -R ./yay
    echo
    echo
    echo
    echo
    echo "yay installation success..!"
    echo 
elif [[ $ANSWER == "N" || $ANSWER == "n" ]]; then
    echo "Bye Bye.."
else
    echo "Error! type 'y' or 'n' Exit..."
fi

read -rep $'Install required packages?' ANSWER
if [[ $ANSWER == "Y" || $ANSWER == "y" ]]; then
	echo "Installing packages.."
	sleep 3
	yay -S --needed $hyprlandp $components $font
	echo
    echo
    echo
    echo
    echo "Packages installation success..!"
    echo 
	echo "Activation service.."
	sleep 1
	systemctl --user enable --now pipewire.service pipewire.socket pipewire-pulse.service wireplumber.service
	echo
	echo "Activation service success..!"
	echo
elif [[ $ANSWER == "N" || $ANSWER == "n" ]]; then
	echo "Skipping packages install.."
else
    echo "Error! type 'y' or 'n' Exit..."
fi

read -rep $'Install fish?' ANSWER
if [[ $ANSWER == "Y" || $ANSWER == "y" ]]; then
	echo "Installing fish.."
	sleep 3
	fish
	curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
	fisher install jorgebucaran/nvm.fish
	fisher install IlanCosman/tide@v5
	chsh -s /usr/bin/fish
	set -U fish_greeting
	echo
    echo
    echo
    echo
    echo "Fish installation success..!"
    echo 
elif [[ $ANSWER == "N" || $ANSWER == "n" ]]; then
	echo "Skipping fish install.."
else
    echo "Error! type 'y' or 'n' Exit..."
fi

read -rep $'Install sddm?' ANSWER
if [[ $ANSWER == "Y" || $ANSWER == "y" ]]; then
	echo "Installing sddm.."
	sleep 3
	yay -S --needed sddm
	systemctl enable sddm.service
	echo
    echo
    echo
    echo
    echo "Sddm installation success..!"
    echo 
elif [[ $ANSWER == "N" || $ANSWER == "n" ]]; then
    echo "Skipping sddm install.."
else
    echo "Error! type 'y' or 'n' Exit.."
fi

read -rep $'Install additional programs(alacritty firefox eog spotify vivaldi vlc nwg-look)?' ANSWER
if [[ $ANSWER == "Y" || $ANSWER == "y" ]]; then
	echo "Installing additional programs.."
	yay -S --needed $programs
	echo
    echo
    echo
    echo
    echo "Programs installation success..!"
    echo 
elif [[ $ANSWER == "N" || $ANSWER == "n" ]]; then
    echo "Skipping programs install.."
else
    echo "Error! type 'y' or 'n' Exit.."
fi

read -rep $'Choose Rice (Mocha - Monet - Minimal) ' ANSWER
if [[ $ANSWER == "Mocha" || $ANSWER == "mocha" ]]; then
    echo "Coping configs Mocha.."
	sleep 2
	cp Mocha/wallpaper.png ~/
    cp -R Mocha/.config/* ~/.config/
	echo "Coping success..!"

elif [[ $ANSWER == "Monet" || $ANSWER == "monet" ]]; then
    echo "Coping configs Monet.."
	sleep 2
	cp -R Monet/.wallpaper/ ~/
    cp -R Monet/.config/* ~/.config/
    cp -R Monet/.themes/* ~/
    cp Monet/.config/wal/templates/swayimg ~/.cache/wal
    cp Monet/.config/wal/templates/colors-hyprland.conf ~/.cache/wal
    cp Monet/.config/wal/templates/colors-mako ~/.cache/wal
    wal -i ~/.wallpaper/Japan.png -n -t
    echo
    echo
	echo "Coping success..!"
	
elif [[ $ANSWER == "Minimal" || $ANSWER == "minimal" ]]; then
    echo "Coping configs Minimal.."
	sleep 2
	cp Monet/wallpaper.png ~/
    cp -R Minimal/.config/* ~/.config/
    echo "Coping success..!"
    
else
    echo "Error! type (Mocha - Monet - Minimal) Exit.."
fi

gsettings set org.gnome.desktop.interface icon-theme Papirus
gsettings set org.gnome.desktop.interface font-name "JetBrains Mono Regular 11"
gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Mocha-Standard-Blue-Dark"
