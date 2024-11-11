#!/bin/bash

echo "1) k9s"
echo "2) trivy"
echo "3) rust"
echo "4) helm"
echo "5) quit"

read -p "Please select the application you want to install : " choice

case $choice in
    1) wget -O - https://raw.githubusercontent.com/ilham-suyadi/Shell-Script-Installer/main/k9s.sh | bash;;
    2) wget -O - https://raw.githubusercontent.com/ilham-suyadi/Shell-Script-Installer/main/trivy.sh | bash;;
    3) curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh ;;
    5) wget -O - https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash ;;
    6) echo "We're done";;
    *) echo "Oops, Invalid choice";;
esac