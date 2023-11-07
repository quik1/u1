#!/bin/bash

# Variables
LOG=""
hyprlandp=""
components=""
programs=""
font=""
themes=("Mocha" "Monet" "Minimal")  # Updated themes

# Function to create and copy config files
copy_config_files() {
    directories=("dunst" "hypr" "kitty" "pipewire" "rofi" "swaylock" "waybar" "wlogout" "alacritty" "ranger" "wofi" "fuzzel")
    for dir in "${directories[@]}"; do
        mkdir -p "dotconfig/$dir"
        # Add commands here to create the config files in the directories
        cp -r "dotconfig/$dir" ~/.config/ 2>&1 | tee -a $LOG
    done
}

# Install yay
echo "Installing yay.."
sleep 3
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
rm -R ./yay
echo "yay installation success..!"

# Install packages
echo "Installing packages.."
sleep 3
yay -S --needed $hyprlandp $components $font
echo "Packages installation success..!"
echo "Activation service.."
sleep 1
systemctl --user enable --now pipewire.service pipewire.socket pipewire-pulse.service wireplumber.service
echo "Activation service success..!"
mkdir ~/.config/hypr/themes 

# Install themes
copy_config_files

# Reboot
echo "Rebooting now..."
sudo reboot
