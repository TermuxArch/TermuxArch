pwd
v="$(pwd)"
echo $v
echo "${v##*/}"
echo "${v#*/}"
echo "${v##/*}"
echo "${v#/*}"
echo "remove ${v##/*}"
echo "${vv//v}"
echo "${v%%*/}"
echo "${v%*/}"
echo "${v%%/*}"
echo "${v%/*}"
echo "${v%/*}"
echo "${v%/*}"
vv="${v##/*}"
echo $v
echo $v
echo $v
echo $vv
echo $vv
echo "${vv//v}"
echo "${vv//$v}"
echo "${vv/v}"
echo "${vv/$v}"
