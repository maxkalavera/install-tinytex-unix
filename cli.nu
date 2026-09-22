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
# Repository commands
###############################################################################

def "main release create-tag" [
  tag: string # Tag name or version name example: 1.0.0 or v1.0.0
  --message: string # Use the given tag message
] {
  (^git tag 
    -a $tag
    -m ($message | default $"Release ($tag) - TinyTeX custom installer")
  )
  ^git push origin $tag
}

def "main release create" [
  tag: string # Tag name or version name example: 1.0.0 or v1.0.0
  --title: string # Release title
  --notes: string # Release notes
  --create-tag # Create tag 
] {
  if not ( $dist_dir | path exists ) {
    main build
  }

  if $create_tag {
    print "There is not dist/ folder, procedding to build the package"
    main release create-tag $tag
  }

  (^gh release create $tag
    --title ($tag | default $tag)
    --notes ($notes | default $"
## Release ($tag)

Updated install TinyTex custom script.
    ")
    --verify-tag
    --prerelease
    ./dist/install-bin-unix.sh
  )
}

def "main test" [
  --flag
] {
  print $flag
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
