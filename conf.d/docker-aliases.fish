#!/usr/bin/fish

# Remove all images
function dri
	docker rmi (docker images -q)
end

# Dockerfile build, e.g., $dbu tcnksm/test 
function dbu
	docker build -t=$1 .
end

# Show all alias related docker
function dalias
	alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort
end

# Bash into running container
function dbash
	docker exec -it (docker ps -aqf "name=$1") bash
end
