#!/usr/bin/env -S bash -e

spinner() {
  local pid=$1
  local msg=$2

  local delay=0.1
  local spin_chars="/ - \\ |"

  echo -n "$msg... "

  while kill -0 "$pid" 2>/dev/null; do
    for char in $spin_chars; do
      echo -ne "\r$msg... $char"
      sleep $delay
    done
  done

  echo -e "\r\033[32m$msg: Completed! ✔\033[0m"
}

run_background() {
  local command=$1
  local logfile=$2
  local message=$3
  
  bash -c "$command" &> "$logfile" &
  local cmd_pid=$!
  
  spinner $cmd_pid "$message"
  
  wait "$cmd_pid"
  local exit_code=$?
  
  if [[ $exit_code -ne 0 ]]; then
    echo -e "\r\033[31m$message... Failed! ❌ Check $logfile\033[0m"
  fi
}

if [[ $EUID -eq 0 ]]; then
  echo "Please run this script as a regular user, not root!"
  exit 1
fi

echo -ne "Welcome to cybercoder-naj's Hyprland install script!\n\n"
echo -e "\033[32m"
echo " ██████╗██╗   ██╗██████╗ ███████╗██████╗  ██████╗ ██████╗ ██████╗ ███████╗██████╗       ███╗   ██╗ █████╗      ██╗";
echo "██╔════╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔══██╗      ████╗  ██║██╔══██╗     ██║";
echo "██║      ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║     ██║   ██║██║  ██║█████╗  ██████╔╝█████╗██╔██╗ ██║███████║     ██║";
echo "██║       ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██║     ██║   ██║██║  ██║██╔══╝  ██╔══██╗╚════╝██║╚██╗██║██╔══██║██   ██║";
echo "╚██████╗   ██║   ██████╔╝███████╗██║  ██║╚██████╗╚██████╔╝██████╔╝███████╗██║  ██║      ██║ ╚████║██║  ██║╚█████╔╝";
echo " ╚═════╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝      ╚═╝  ╚═══╝╚═╝  ╚═╝ ╚════╝ ";
echo "                                                                                                                  ";
echo -e "\033[0m"

exit 0 # remove

if ! sudo -v; then
  echo -e "\033[31mFailed to obtain sudo privileges. Exiting.\033[0m"
  exit 1
fi

run_background "yay -Syu --noconfirm" "/tmp/yay_update.log" "Updating system"

INSTALL_PKGS=$(cat <<EOF
yay -S --noconfirm \
  bat \
  bluetui \
  btop \
  code \
  docker \
  eza \
  fastfetch \
  fish \
  ghostty \
  git-delta \
  github-cli \
  gource \
  hyprpaper \
  hyprshot \
  neovim \
  waybar \
  wofi \
  zen-browser \
  zoxide
EOF
)

run_background "$INSTALL_PKGS" "/tmp/yay_install.log" "Installing the packages"
