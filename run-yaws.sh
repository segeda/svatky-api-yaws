#!/bin/sh
docker run -it --rm -v "$PWD":/var/app -w /var/app/src -v "$PWD"/yaws.conf:/etc/yaws/yaws.conf --name yaws -p 8080:80 segeda/yaws:github-alpine
