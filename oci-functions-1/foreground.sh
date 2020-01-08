echo "Installing Project Fn"


# install Project Fn CLI
curl -LSs https://raw.githubusercontent.com/fnproject/cli/master/install | sh

docker pull fnproject/fnserver:latest

docker pull fnproject/node:latest

fn start &

fn version
docker images

echo 'Ready for action!'


