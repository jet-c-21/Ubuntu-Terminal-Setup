use_sudo() {
  : <<COMMENT
straight way:
  echo "$sudo_pwd" | sudo -S your command
example:
  echo "$sudo_pwd" | sudo -S apt-get update
COMMENT

  local cmd="echo ${sudo_pwd} | sudo -S "
  for param in "$@"; do
    cmd+="${param} "
  done
  eval "${cmd}"
}

echo "Please enter your sudo password:"
read -s sudo_pwd