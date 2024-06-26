#/bin/bash

# Colors scheme
CDEF="\033[0m"                                 	        	# default color
CCIN="\033[0;36m"                              		        # info color
CGSC="\033[0;32m"                              		        # success color
CRER="\033[0;31m"                              		        # error color
CWAR="\033[0;33m"                              		        # waring color
b_CDEF="\033[1;37m"                            		        # bold default color
b_CCIN="\033[1;36m"                            		        # bold info color
b_CGSC="\033[1;32m"                            		        # bold success color
b_CRER="\033[1;31m"                            		        # bold error color
b_CWAR="\033[1;33m"                            		        # bold warning color

# Display message colors
prompt () {
	case ${1} in
		"-s"|"--success")
			echo -e "${b_CGSC}${@/-s/}${CDEF}";;            # print success message
		"-e"|"--error")
			echo -e "${b_CRER}${@/-e/}${CDEF}";;            # print error message
		"-w"|"--warning")
			echo -e "${b_CWAR}${@/-w/}${CDEF}";;            # print warning message
		"-i"|"--info")
			echo -e "${b_CCIN}${@/-i/}${CDEF}";;            # print info message
		*)
			echo -e "$@"
		;;
	 esac
}

# Folders
target_dir="${HOME}/${HOSTNAME}"
backups_dir="./backups"
documentos_dir="./Documentos"
downloads_dir="./Downloads"
icc_dir="./icc-profiles"
imagens_dir="./Imagens"
musicas_dir="./Músicas"
scripts_dir="./scripts"
videos_dir="./Vídeos"

cd ${HOME}

# Create target_dir
if [ ! -d $target_dir ]; then
  prompt -i ">>> Creating the target folder..."
  mkdir $target_dir
  prompt -s ">>> DONE"
else
  prompt -w ">>> Deleting older target folder..."
  
  if rm -rf $target_dir; then
    prompt -s ">>> Older target folder was successfully deleted ..."
  else
    prompt -e ">>> ERROR: Can't delete older target folder..."
  fi

  prompt -i ">>> Creating the target folder..."
  mkdir $target_dir
  prompt -s ">>> DONE"
fi

# Start folders backup
if [ -d $backups_dir ]; then
  prompt -i ">>> Backing up backups folder..."

  tar cpfz backups.tar.gz $backups_dir
  mv backups.tar.gz $target_dir

  prompt -s ">>> DONE"
else
  prompt -w ">>> Backups folder doesn't exist..."
fi

if [ -d $documentos_dir ]; then
  prompt -i ">>> Backing up documents folder..."

  tar cpfz documentos.tar.gz $documentos_dir
  mv documentos.tar.gz $target_dir

  prompt -s ">>> DONE"
else
  prompt -w ">>> Documents folder doesn't exist..."
fi

if [ -d $downloads_dir ]; then
  prompt -i ">>> Backing up downloads folder..."

  tar cpfz downloads.tar.gz $downloads_dir
  mv downloads.tar.gz $target_dir

  prompt -s ">>> DONE"
else
  prompt -w ">>> Downloads folder doesn't exist..."
fi

if [ -d $icc_dir ]; then
  prompt -i ">>> Backing up icc profiles folder..."

  tar cpfz icc-profiles.tar.gz $icc_dir
  mv icc-profiles.tar.gz $target_dir

  prompt -s ">>> DONE"
else
  prompt -w ">>> ICC Profiles folder doesn't exist..."
fi

if [ -e "linux-scripts" ]; then
  prompt -i ">>> Backing up linux-scripts link..."

  tar cpfz linux-scripts.tar.gz linux-scripts
  mv linux-scripts.tar.gz $target_dir

  prompt -s ">>> DONE"
else
  prompt -w ">>> There is no linux-scripts link to make backup..."
fi

if [ -d $imagens_dir ]; then
  prompt -i ">>> Backing up pictures folder..."

  tar cpfz imagens.tar.gz $imagens_dir
  mv imagens.tar.gz $target_dir

  prompt -s ">>> DONE"
else
  prompt -w ">>> Pictures folder doesn't exist..."
fi

if [ -d $musicas_dir ]; then
  prompt -i ">>> Backing up music folder..."

  tar cpfz musicas.tar.gz $musicas_dir
  mv musicas.tar.gz $target_dir

  prompt -s ">>> DONE"
else
  prompt -w ">>> Music folder doesn't exist..."
fi

if [ -d $videos_dir ]; then
  prompt -i ">>> Backing up videos folder..."

  tar cpfz videos.tar.gz $videos_dir
  mv videos.tar.gz $target_dir

  prompt -s ">>> DONE"
else
  prompt -w ">>> Videos folder doesn't exist..."
fi

# Start windows syslinks backup
if ls windows-* >/dev/null 2>&1; then
  prompt -i ">>> Backing up windows links..."

  tar cpfz win-links.tar.gz windows-*
  mv win-links.tar.gz $target_dir

  prompt -s ">>> DONE"
else
  prompt -w ">>> There is no links to make backup..."
fi

prompt -s ">>> Backup finalizado! <<<"
