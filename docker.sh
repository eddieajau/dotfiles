#!/usr/bin/env bash
# Inspired by https://github.com/jfrazelle/dotfiles/blob/master/.dockerfunc

#
# Helper Functions
#
dcleanup(){
	docker rm $(docker ps -aq 2>/dev/null) 2>/dev/null
	docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
	docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}

del_stopped(){
	local name=$1
	local state=$(docker inspect --format "{{.State.Running}}" $name 2>/dev/null)

	if [[ "$state" == "false" ]]; then
		docker rm $name
	fi
}
