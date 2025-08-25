# vi: ft=sh
portlist() { sudo lsof -i :"$@" }

docker-clean() {
    docker ps -aq | xargs docker rm -f
    docker images -aq | xargs docker rmi -f
}

bun-init() {
    mkdir $@ && cd $@
    bun init --yes
    bun add @biomejs/biome --dev
    bunx @biomejs/biome init --jsonc
    bun pm trust @biomejs/biome
    git init && git add . && git commit -m "Initial commit"
}
