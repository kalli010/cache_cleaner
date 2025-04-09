# description

A script to clean temporary files for 42 Schools.

## Installation

1. Clone the repository and give the script permission to execute:
```
git clone https://github.com/kalli010/cache_cleaner.git && chmod +x cache_cleaner/clean.sh
```
2. add it as a command:
```
echo 'alias clean="$HOME/cache_cleaner/./clean.sh"' >> "$HOME/.$(basename "$SHELL")rc"
```
3. Apply the changes by running:
```
source ~/.$(basename "$SHELL")rc
```

## Usage

To clean temporary files, use the following command::
```
clean
```
