#!/bin/zsh
set -euo pipefail

console_user="$("/usr/bin/stat" -f '%Su' /dev/console)"
if [[ -z "${console_user}" || "${console_user}" == "root" || "${console_user}" == "loginwindow" ]]; then
  echo "kanata: no active console user for input source toggle" >&2
  exit 1
fi

console_uid="$("/usr/bin/id" -u "${console_user}")"

run_as_console_user() {
  /bin/launchctl asuser "${console_uid}" /usr/bin/sudo -u "${console_user}" "$@"
}

# if Japanese input is active, switch to Eisu
# otherwise, switch to Kana
selected_input_sources="$(run_as_console_user /usr/bin/defaults read com.apple.HIToolbox AppleSelectedInputSources)"

if printf '%s\n' "${selected_input_sources}" | /usr/bin/grep -Eq 'Bundle ID = "com\.apple\.inputmethod\.|Input Mode = "com\.apple\.inputmethod\.|com\.apple\.inputmethod\.(Japanese|Kotoeri)'; then
  run_as_console_user /usr/bin/osascript -e 'tell application "System Events" to key code 102'
else
  run_as_console_user /usr/bin/osascript -e 'tell application "System Events" to key code 104'
fi
