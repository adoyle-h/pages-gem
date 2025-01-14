DOCKER=docker

TAG=gh-pages

# Build the docker image
image:
	${DOCKER} build -t ${TAG} .
image_alpine:
	${DOCKER} build -t ${TAG} . -f Dockerfile.alpine
image_alpine_cn:
	${DOCKER} build -t ${TAG} . -f Dockerfile.alpine \
		--build-arg 'APK_PROXY=mirrors.ustc.edu.cn' \
		--build-arg 'GEM_PROXY=gems.ruby-china.com'

# Produce a bash shell
shell:
	${DOCKER} run --rm -it \
		-p 4000:4000 \
		-u `id -u`:`id -g` \
		-v ${PWD}:/src/gh/pages-gem \
		${TAG} \
		/bin/bash

# Spawn a server. Specify the path to the SITE directory by
# exposing it using `export SITE="../path-to-jekyll-site"` prior to calling or
# by prepending it to the make rule e.g.: `SITE=../path-to-site make server`
server:
	test -d "${SITE}" || \
		(echo -E "specify SITE e.g.: SITE=/path/to/site make server"; exit 1) && \
	${DOCKER} run --rm -it \
		-p 4000:4000 \
		-u `id -u`:`id -g` \
		-v ${PWD}:/src/gh/pages-gem \
		-v `realpath ${SITE}`:/src/site \
		-w /src/site \
		${TAG}

.PHONY:
	image image_alpine server shell

.PHONY: build
build:
	gem build ./github-pages.gemspec
