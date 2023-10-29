#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $current_dir/utils.sh

get_ngrok_data()
{
  tunnels=$(curl http://127.0.0.1:4040/api/tunnels --silent)
  public_url=$(jq -r .tunnels[].public_url <<< "$tunnels" | head -n1)
  echo $public_url
}

main()
{
  # storing the refresh rate in the variable RATE, default is 5
  RATE=$(get_tmux_option "@dracula-refresh-rate" 5)
  ngrok_label=$(get_tmux_option "@dracula-ngrok-label" "ngrok")
  ngrok_public_url=$(get_ngrok_data)
  echo "$ngrok_public_url"
  sleep $RATE
}

# run the main driver
main
