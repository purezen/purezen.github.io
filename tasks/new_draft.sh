#!/bin/bash

main() {
  local title="$(
    echo -n "${@}" | \
    sed -e 's/[^[:alnum:]]/-/g' | \
    tr -s '-' | \
    tr '[:upper:]' '[:lower:]'
  )"
  local file="_drafts/$title.md"
  cat > "$file" <<EOF
---
layout: post
title: "$@"
comments: true
tags:   [tag1]
---
EOF
}

main "$*"
