$pwd = (Get-Location).Path -replace "C:", "c:" -replace "\\", "/"

docker run -it --rm -v ${pwd}:/var/app -w /var/app/src -v ${pwd}/yaws.conf:/etc/yaws/yaws.conf --name yaws -p 8080:80 segeda/yaws:github-alpine