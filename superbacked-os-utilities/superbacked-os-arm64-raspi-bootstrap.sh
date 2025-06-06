#! /bin/bash
# Used to patch Ubuntu for desktops 24.04.1 LTS (Raspberry Pi)

set -e
set -o pipefail

printf "%s\n" "Configuring GNOME…"

dconf load /org/gnome/terminal/legacy/profiles:/ < ./profiles/terminal.dconf

gsettings set org.gnome.desktop.background picture-uri none
gsettings set org.gnome.desktop.background picture-uri-dark none
gsettings set org.gnome.desktop.background primary-color '#000000'
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.media-handling automount false
gsettings set org.gnome.mutter center-new-windows true

printf "%s\n" "Uninstalling extraneous software…"

sudo apt remove --purge --yes \
  duplicity* \
  file-roller* \
  firefox* \
  gnome-calendar* \
  gnome-snapshot* \
  libreoffice* \
  remmina* \
  rhythmbox* \
  shotwell* \
  simple-scan* \
  thunderbird* \
  totem* \
  transmission*

sudo apt autoremove --purge --yes

sudo apt clean

sudo snap remove --purge firefox thunderbird

printf "%s\n" "Adding universe repository…"

sudo add-apt-repository --yes universe

printf "%s\n" "Installing dependencies…"

sudo apt install --yes curl libfuse2 overlayroot zbar-tools zlib1g-dev

printf "%s\n" "Disabling Bluetooth and Wi-Fi…"

cat << "EOF" | sudo tee -a /boot/firmware/config.txt
dtoverlay=disable-bt
dtoverlay=disable-wifi
EOF

printf "%s\n" "Configuring fstab…"

sudo sed --in-place 's/discard/discard,noload,ro/g' /etc/fstab
sudo sed --in-place 's/defaults/defaults,ro/g' /etc/fstab

sudo cat /etc/fstab

printf "%s\n" "Disabling fsck.repair and enabling read-only…"

sudo sed --in-place 's/quiet splash/quiet splash fsck.repair=no ro/g' /boot/firmware/cmdline.txt

sudo cat /boot/firmware/cmdline.txt

printf "%s\n" "Configuring overlayroot…"

sudo sed --in-place 's/overlayroot=""/overlayroot="tmpfs"/g' /etc/overlayroot.conf

printf "%s\n" "Disabling automatic updates…"

sudo apt remove --yes unattended-upgrades update-manager update-notifier

printf "%s\n" "Disable networking…"

sudo systemctl enable nftables
sudo systemctl start nftables
sudo nft flush ruleset
sudo nft add table inet filter
sudo nft add chain inet filter input '{ type filter hook input priority 0; policy drop; }'
sudo nft add chain inet filter forward '{ type filter hook forward priority 0; policy drop; }'
sudo nft add chain inet filter output '{ type filter hook output priority 0; policy drop; }'
sudo nft add rule inet filter input iif lo accept
sudo nft add rule inet filter output oif lo accept
sudo nft list ruleset | sudo tee /etc/nftables.conf

printf "%s\n" "Disable sudo…"

sudo deluser superbacked sudo

printf "%s\n" "Clearing Bash history…"

history -cw

printf "%s\n" "Rebooting in 10 seconds…"

sleep 10

systemctl reboot