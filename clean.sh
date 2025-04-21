#!/bin/bash

total_savings=0

cache_directories=(
    $HOME/.var/app/*/cache/
    $HOME/.local/share/Trash/
    $HOME/.cache/
)

format() {
    local size=$1
    if [ "$size" -lt 1000 ]; then
        echo -e "\033[32m${size}KB\033[0m"
    elif [ "$size" -lt 1000000 ]; then
        echo -e "\033[32m$((size / 1000))MB\033[0m"
    else
        echo -e "\033[32m$((size / 1000000))GB\033[0m"
    fi
}

for dir in "${cache_directories[@]}"; do
  dir_size=$(du -sk "$dir" 2>/dev/null | awk '{print $1}')
  if [[ "$dir_size" -gt 0 ]]; then
    total_savings=$((total_savings + dir_size))
    echo -e "$(format $dir_size)\033[34m in $dir\033[0m"
  fi
done
echo

if [[ "$total_savings" -gt 0 ]]; then
  read -p "Do you want to delete $(format $total_savings) of files in these folders? (yes/no): " fk_left
  echo
else
  fk_left="yes"
fi

total_savings=0

if [ "$fk_left" = "yes" ]; then
  for dir in "${cache_directories[@]}"; do
    dir_size=$(du -sk "$dir" 2>/dev/null | awk '{print $1}')
    rm -rf "$dir"/* &>/dev/null
    new_dir_size=$(du -sk "$dir" 2>/dev/null | awk '{print $1}')
    if ! [[ "$new_dir_size" =~ ^[0-9]+$ ]]; then
      new_dir_size=0
      dir_size=0
    fi
    if [ "$dir_size" -gt "$new_dir_size" ]; then
      savings=$((dir_size - new_dir_size))
      total_savings=$((total_savings + savings))
    fi
  done
  echo -e "\033[33mTotal memory savings: $(format $total_savings)\033[0m"
else
  echo -e "\033[31mExiting without deleting.\033[0m"
  exit 0
fi
