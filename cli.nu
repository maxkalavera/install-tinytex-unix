#! /usr/bin/env nu

const root_dir = path self .
const dist_dir = $root_dir | path join "dist/"
const container_root_dir = "/root/workspace"
const container_dist_dir = $container_root_dir | path join "dist/"

def "main" [] {}

###############################################################################
# Helper commands
###############################################################################

def prepare-dist [] {
  if not ($dist_dir | path exists ) {
    mkdir $dist_dir
  }
}

###############################################################################
# Docker commands
###############################################################################

# Run docker commands contained in ./docker/cli.nu
def "main docker" [
  ...args: string
] {
  ^$"($root_dir)/docker/cli.nu" ...$args
}

###############################################################################
# Build commands
###############################################################################

def "main run" [] {
  (main docker run amber run
    ($container_root_dir | path join "src/main.ab")
  )
}

def "main build" [] {
  prepare-dist
  (main docker run amber build
    ($container_root_dir | path join "src/main.ab")
    ($container_root_dir | path join "dist/install-bin-unix.sh")
  )
}
