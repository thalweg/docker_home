#!/usr/bin/env bash
hosts=(cecil biggs wedge)
(
  for host in ${hosts[@]}; do
    command="source "$host/.envrc"; docker-compose"
    while read -r -d $'\0'; do
      command+=" -f $REPLY"
    done < <(find -E "$host" -type f -regex '.*/[0-9]{2}-.*\.yaml$' -print0)
    echo "$command $@"
  done
) | xargs -P${#hosts[@]} -I{} sh -c '{}'