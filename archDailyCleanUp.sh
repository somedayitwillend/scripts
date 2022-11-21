#!/bin/bash
sudo pacman -Syyy
sudo pacman -Syu --noconfirm
sudo pacman -Sc --noconfirm
sudo pacman -Rns $(pacman -Qtdt) --noconfirm
sudo rm -rf ~/.cache/*
sudo reflector -c Hungary -a 6 --sort rate --save /etc/pacman.d/mirrorlist
