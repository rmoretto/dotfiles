#!/usr/bin/env bash

set -e


echo "Setting up environment for Ubuntu"

echo "Installing basic packages"
sudo apt-get install -y git wget vim nano make build-essential \
	                cmake nitrogen python3-pip python3-dev \
			dunst jq ddcutils


mkdir -p /tmp/dotfilessetup
cd /tmp/dotfilessetup

echo "Compiling I3-Gaps from source"
echo "Installing dev dependencies"


sudo apt-get install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
                     libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
                     libstartup-notification0-dev libxcb-randr0-dev \
                     libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
                     libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
                     autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev ninja-build

sudo pip3 install meson

echo "Cloning I3-Gaps"
git clone https://www.github.com/Airblader/i3 --depth=1 i3-gaps

echo "Building I3-Gaps"
cd i3-gaps

mkdir -p build && cd build
meson ..
ninja
sudo ninja install

echo "Installing i3lock-color"
sudo apt-get install i3lock


echo "Copiling polybar from source"

cd /tmp/dotfilessetup

echo "Installing polybar dependencies"
sudo apt install -y cmake-data pkg-config python3-sphinx libcairo2-dev \
                    libxcb1-dev libxcb-util0-dev libxcb-randr0-dev \
		    libxcb-composite0-dev python3-xcbgen xcb-proto \
		    libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev \
		    libpulse-dev libasound2-dev libnl-genl-3-dev  \
		    libcurlpp-dev libjsoncpp-dev 


wget -O polybar.tar https://github.com/polybar/polybar/releases/download/3.5.4/polybar-3.5.4.tar.gz
sha256sum -c <<<"133af4e8b29f426595ad3b773948eee27275230887844473853e7940c7959c2b ./polybar.tar"

tar xf ./polybar.tar
rm -f ./polybar.tar

cd polybar

mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install

echo "Compiling picom from source"
cd /tmp/dotfilessetup

echo "Installing picom dependencies"
sudo apt-get install -y libxext-dev libxcb1-dev libxcb-damage0-dev \
	                libxcb-xfixes0-dev libxcb-shape0-dev \
			libxcb-render-util0-dev libxcb-render0-dev \
			libxcb-randr0-dev libxcb-composite0-dev \
			libxcb-image0-dev libxcb-present-dev \
			libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev \
			libdbus-1-dev libconfig-dev libgl1-mesa-dev \
			libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev

echo "Cloning picom"
git clone git@github.com:yshui/picom.git --recurse-submodules 
cd picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
ninja -C build install


echo "Compiling rofi from source"

cd /tmp/dotfilessetup

echo "Installing rofi dependencies"
sudo apt-get install -y bison flex librsvg2-dev

echo "Downloading rofi"
wget -O rofi.tar.gz https://github.com/davatorium/rofi/releases/download/1.5.4/rofi-1.5.4.tar.gz

tar xf rofi.tar.gz
cd rofi-1.5.4

cd /tmp/dotfilessetup/rofi-1.5.4

mkdir build && cd build
../configure --disable-check
make
sudo make install

echo "Copiling alacrity from source"

cd /tmp/dotfilessetup

echo "Installing alacritty dependencies"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo apt-get install -y libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev

source $HOME/.cargo/env
rustup override set stable
rustup update stable

echo "Cloning alacritty"
git clone https://github.com/alacritty/alacritty.git

echo "Building alacritty"
cd alacritty
cargo build --release

sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

echo "Installing Pywal"

pip3 install --user pywal
pip3 install --user colorz


echo "Installing Startship"
curl -fsSL https://starship.rs/install.sh | bash

