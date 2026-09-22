# tinytex-installer

A small, portable installer for [TinyTeX](https://yihui.org/tinytex/) — a lightweight, cross-platform LaTeX distribution.

This project ships **two parallel implementations** of the same installer:

- a **hand-written Bash script** (`src/install-tinytex-unix.sh`), ready to use today
- an **Amber language version** (`src/main.ab`), a forward-looking rewrite hoping for future Amber support of POSIX targets

> **Status:** Experimental. The Bash script is the stable, recommended installer. The Amber version is a work in progress that mirrors the same logic.

---

## Motivation

TinyTeX is great, but installing it consistently across machines — macOS, Linux, containers, CI runners — usually means copy-pasting a fragile one-liner. This project aims to provide a **single, auditable, well-tested installer** that works everywhere a Unix shell does.

Two tracks:

1. **Bash now** — because every Unix-like system ships a POSIX shell.
2. **Amber later** — because Amber compiles to Bash and, if it ever targets strict POSIX, the same `.ab` source could be compiled into a truly portable installer for an even wider range of machines.

The Amber version is written in the *hope* that Amber's output remains portable enough (or becomes POSIX-compliant) that the compiled script can be dropped onto almost any Unix box.

## Requirements

### To *use* the installer

- A Unix-like system (macOS, Linux, BSD, WSL, or a container)
- `curl` or `wget`
- A POSIX shell (`sh`, `bash`, `zsh`, `dash`, `ash`, `ksh` — anything reasonable)

### To *develop* this project

You do **not** need Amber installed. Everything runs inside Docker.

- **Docker** (Engine 20+ or Docker Desktop)
- **Nushell** (`nu`) — used as the interactive shell inside the dev container and for scripts

That's it. Amber, Bash, TeX, and friends all live in the container image.

---

## Quick start (users)

### Install TinyTeX from the Bash script

> ⚠️ **Experimental — use at your own risk.** This project is under active
> development and not yet stable. The Amber version in particular targets a
> pre-1.0 compiler and may break. Review the scripts before running them,
> test in a container or scratch `$HOME`, and don't point it at a machine
> you can't afford to fix by hand.

```sh
curl -sL https://github.com/maxkalavera/install-tinytex-unix/releases/download/v0.1.0-alpha/install-bin-unix.sh | sh
````

Or, after cloning:

```sh
./cli.nu docker build
./cli.nu build
./dist/install-bin-unix.sh
````

