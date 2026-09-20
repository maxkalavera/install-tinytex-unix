#! /usr/bin/env nu

const root = path self | path dirname | path dirname 
let docker_dir = $root | path join "docker"
let image_name = 'mq4ksaquhbbjfu8tn2rrck'
let container_workspace = '/root/workspace'

def main [] {}

# Build docker image
def "main build" [] {
  (docker build 
    -t $image_name 
    -f $"($docker_dir)/Dockerfile" 
    .
  )
}

# Run a command inside docker container
def "main run" [
  ...args: string
] {
  prepare-build

  (docker run 
    -it
    --rm
    --init
    -v $"($root):($container_workspace)"
    -w $container_workspace
    $image_name
    ...$args
  )

}

# Run a pseudo TTY into the conainer
def "main into" [] {
  prepare-build

  (docker run
    -it
    --rm
    -v $"($root):($container_workspace)"
    -w $container_workspace
    $image_name
    /bin/sh
  )
}

# Remove images, containers and volumes created
def "main clean" [] {
  docker rmi $image_name
}

###############################################################################
# Helpers
###############################################################################


def prepare-build [] {
  let build_flag = (
    docker images --format "{{.Repository}}"
    | lines
    | where { |it| $it == $image_name }
    | is-empty
  )
  if ($build_flag) {
    main build
  }
}