#!/bin/bash

# Variables
CFG=""
LOG=""
ANSWER=""
hyprlandp=""
components=""
programs=""
font=""
themes=("Mocha" "Monet" "Minimal")  # Updated themes

# Prompt for installation
read -rep $'Proceed with installation? (Y)' ANSWER
if [[ $ANSWER == "Y" || $ANSWER == "y" ]]; then
    echo "Installing yay.."
    sleep 3
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    rm -R ./yay
    echo "yay installation success..!"
fi

# Prompt for package installation
read -rep $'Install required packages?' ANSWER
if [[ $ANSWER == "Y" || $ANSWER == "y" ]]; then
    echo "Installing packages.."
    sleep 3
    yay -S --needed $hyprlandp $components $font
    echo "Packages installation success..!"
    echo "Activation service.."
    sleep 1
    systemctl --user enable --now pipewire.service pipewire.socket pipewire-pulse.service wireplumber.service
    echo "Activation service success..!"
    mkdir ~/.config/hypr/themes 
elif [[ $ANSWER == "N" || $ANSWER == "n" ]]; then
    echo "Skipping packages install.."
else
    echo "Error! type 'y' or 'n' Exit..."
fi

# Function to install themes
install_themes() {
    echo "Installing themes..."
    for theme in "${themes[@]}"; do
        # Replace this with the command to install the theme
        echo "Installing $theme..."
        # Add the command to install the theme here
    done
}

# Prompt for theme installation
read -rep $'Install all themes? (y - n)' ANSWER
if [[ $ANSWER == "Y" || $ANSWER == "y" ]]; then
    install_themes
fi

# Function to set default theme
set_default_theme() {
    echo "Please select the default theme:"
    select theme in "${themes[@]}"; do
        # Replace this with the command to set the default theme
        echo "Setting $theme as the default theme..."
        break
    done
}

# Prompt for setting default theme
read -rep $'Choose theme? (y - n)' ANSWER
if [[ $ANSWER == "Y" || $ANSWER == "y" ]]; then
    set_default_theme
fi

# Prompt for copying config files
read -n1 -rep "${CAT} Would you like to copy config files? (y,n)" CFG
if [[ $CFG =~ ^[Yy]$ ]]; then
    printf " Copying config files...\n"
    cp -r dotconfig/dunst ~/.config/ 2>&1 | tee -a $LOG
    cp -r dotconfig/hypr ~/.config/ 2>&1 | tee -a $LOG
    cp -r dotconfig/kitty ~/.config/ 2>&1 | tee -a $LOG
    cp -r dotconfig/pipewire ~/.config/ 2>&1 | tee -a $LOG
    cp -r dotconfig/rofi ~/.config/ 2>&1 | tee -a $LOG
    cp -r dotconfig/swaylock ~/.config/ 2>&1 | tee -a $LOG
    cp -r dotconfig/waybar ~/.config/ 2>&1 | tee -a $LOG
    cp -r dotconfig/wlogout ~/.config/ 2>&1 | tee -a $LOG
    cp -r dotconfig/alacritty ~/.config/ 2>&1 | tee -a $LOG
    cp -r dotconfig/ranger ~/.config/ 2>&1 | tee -a $LOG
    cp -r dotconfig/wofi ~/.config/ 2>&1 | tee -a $LOG
    cp -r dotconfig/fuzzel ~/.config/ 2>&1 | tee -a $LOG
fi

# Prompt for reboot
read -rep $'Would you like to reboot now? (y - n)' ANSWER
if [[ $ANSWER == "Y" || $ANSWER == "y" ]]; then
    echo "Rebooting now..."
    sudo reboot
elif [[ $ANSWER == "N" || $ANSWER == "n" ]]; then
    echo "Skipping reboot.."
else
    echo "Error! type 'y' or 'n' Exit..."
fi
