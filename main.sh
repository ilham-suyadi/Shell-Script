#!/bin/bash

echo "1) k9s"
echo "2) trivy"
echo "3) quit"

read -p "Please select the application you want to install : " choice

case $choice in
    1) wget -O - https://raw.githubusercontent.com/ilham-suyadi/Shell-Script-Installer/main/k9s.sh | bash;;
    2) wget -O - https://raw.githubusercontent.com/ilham-suyadi/Shell-Script-Installer/main/trivy.sh | bash;;
    3) echo "We're done";;
    *) echo "Oops, Invalid choice";;
esac