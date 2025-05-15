#!/bin/bash


# rzeczy do zarchiwizowania
SRC_ITEMS=(
  "$HOME/Documents/Skryptowe_Lab_10/raport.txt"
  "$HOME/Documents/Test"
)

# archiwum wraz z data utworzenia
BACKUP_DIR="$HOME/backups"
ARCHIVE_NAME="backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

# ponizsze wartosci nalezy dostosowac pod swoje wymagania

FTP_HOST="nazwa_hosta"
FTP_USER="nazwa_usera"
# poprosi uzytkownika o podanie hasla, ale ukryje go zeby nie byl wyswietlony na ekranie 
read -s -p "Hasło FTP: " FTP_PASS; echo

FTP_REMOTE_DIR="/home/$FTP_USER/Documents/Skryptowe_Lab_10/kopie_zapasowe"

# lokalny katalog
mkdir -p "$BACKUP_DIR"

# archiwum + kompresja
tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" "${SRC_ITEMS[@]}"

# wyslanie przez FTP
ftp -inv "$FTP_HOST" <<EOF
user $FTP_USER $FTP_PASS
binary
mkdir -p $FTP_REMOTE_DIR
cd $FTP_REMOTE_DIR
put "$BACKUP_DIR/$ARCHIVE_NAME"
bye
EOF

echo "Gotowe"
