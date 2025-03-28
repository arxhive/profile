
# Go helpers
gocover () {
    t="/tmp/go-cover.$$.tmp"
    go test -coverprofile=$t $@ && go tool cover -html=$t && unlink $t
}

vdlogs() {
  docker logs $@ >& container_logs
  v container_logs
  rm container_logs
}

chmod-sh() {
  chmod 744 $@
}

chmod-pem() {
  chmod 0400 $@
}

chmod-pub() {
  chmod 600 $@ # or 644 to make them readable for all
}

chmod-ssh-dir() {
  chmod 700 $@
}

ports() {
  lsof -i :$@
}

lports() {
  sudo lsof -i -P | grep LISTEN | grep :$@
}

grepy() {
  grep -HIFrni --color=always $@ .
}

safari() {
  cd $HOME/ext/safaribooks/
  pya
  python3 safaribooks.py --kindle $@
  cd Books/*$@*
  ls

  echo "Pass to send it to Kindle or cancel:"
  read pass # TODO: find a way how to hide input

  to=$(echo $KINDLE_EMAIL | openssl aes-256-cbc -pbkdf2 -d -a -salt -pass pass:$pass)
  from=$(echo $GMAIL_EMAIL | openssl aes-256-cbc -pbkdf2 -d -a -salt -pass pass:$pass)
  code=$(echo $SWAKS_GMAIL_CODE | openssl aes-256-cbc -pbkdf2 -d -a -salt -pass pass:$pass)

  # zip $@.zip $@.epub
  title=$(pwd | sed -E 's|.*/Books/(.*) \([0-9]+\)|\1|')
  title=$title.epub
  cp $@.epub $title

  swaks --body $@ --header "Subject: "$@ --to $to -attach @$title -s smtp.gmail.com:587 -tls --auth-user $from --auth-password $code --auth-hide-password
}

catcsv() {
    cat "$@" | column -t -s, | less -F -S -X -K
}

lesscsv() {
  csvlook "$@" | less -S -K -X -F
}

# Script to open the GitHub page of the current repository in a browser
gh() {
  fetch_url=$(git config --get remote.origin.url)
  # outputs:
  # git@github.com:some-name/some-repo-name.git
  # https://github.com/some-name/some-repo-name.git
  # ssh://arxhive/arxhive/profile.git

  # Detect the base URL
  if [[ $fetch_url == *"https"* ]]; then
      # Remove the .git from the end of the URL
      url_portion="${fetch_url%.git}"
      # Remove a git access role from the URL (everything between :// and @)
      url_portion=$(echo "$url_portion" | sed 's#://[^@]*@#://#')
  elif [[ "$fetch_url" == *"ssh://"* ]]; then
      # Remove the 'ssh://' prefix
      url_without_prefix="${fetch_url#ssh://}"

      # Extract the part after the first '/'
      extracted_part="${url_without_prefix#*/}"

      # Remove the .git from the end of the URL
      url_portion="${extracted_part%.git}"
  else
      # Split the URL on ':' and get the 2nd portion
      url_portion="$(echo "$fetch_url" | awk -F':' '{print $2}')"

      # Remove the .git from the end of the URL
      url_portion="${url_portion%.git}"
  fi

  # route azure to edge
  if [[ "$url_portion" == *"azure.com"* ]]; then
    edge "$url_portion?path=$@"
  else
    github_url="https://github.com/$url_portion/blob/main/$@"
    chrome "$github_url"
  fi
}

