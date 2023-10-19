# Dotfiles

These are basic configurations of my working environment of things like editor,
shell and terminal configurations.

## Setup

> The setup focuses on MacOS, since this is my daily environment.

Clone of this repo on system user root:

```shell
git clone http://github.com/cange/dotfiles.git
```

### Installation

Once the repo has been cloned, the required dependencies can be installed using
[Homebrew](https://brew.sh/). To do this, navigate to the root of the repo and
run the following command:

```sh
./bootstrap install # or uninstall
```

> **Note** Use `./bootstrap --help` flag to see available options.

<details>
  <summary>Details</summary>

Each tool directory can contain a `Brewfile` and a `links.prop` file for
symlinks. These files then contain individual settings of the particular tool.
The mapping of a `links.prop` definition is done by `<source>=<destination>`
assignment per line.

</details>

#### Secrets

User details such as tokens are stored in `$HOME/config/secrets/` individually.
