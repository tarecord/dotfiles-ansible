# dotfiles

Tanner's dotfiles written as Ansible roles. Sets up a full local development environment with a **single command.** (based on [sloria's dotfiles](https://github.com/sloria/dotfiles-old))

Fully supports macOS

## a few neat features

- zsh configured with [prezto](https://github.com/sorin-ionescu/prezto).
- nice fonts for the terminal and coding.
- a tmux.conf that's pretty neat.
- pluggable. Everything is optional. Fork this. Remove what you don't use. Configure what you do use.
- Mac packages installed with [homebrew][]. Mac apps installed with [homebrew-cask][] and [mas][].
- git commit signing with GPG

## prerequisites

- homebrew (If on macOS) - **Install this first**
- git: `brew install git`
- ansible >= 1.6: `brew install ansible`

## install

- [Fork](https://github.com/tarecord/dotfiles-ansible/fork) this repo.
- Clone your fork.

```bash
# Replace git url with your fork
# NOTE: It is important that you clone to ~/dotfiles
git clone https://github.com/YOU/dotfiles-ansible.git ~/dotfiles
cd ~/dotfiles
```

- Update the following variables in `group_vars/local` (at a minimum)
  - `full_name`: Your name, which will be attached to commit messages, e.g. "Tanner Record"
  - `git_user`: Your Github username.
  - `git_email`: Your git email address.
- Optional, but recommended: Update `group_vars/local` with the programs you want installed by [homebrew][], [homebrew-cask][], and npm.
  - `mac_homebrew_packages`: Utilities that don't get installed by the roles.
  - `mac_cask_packages`: Mac Apps you want installed with [homebrew-cask][].
- Edit `local_env.yml` as you see fit. Remove any roles you don't use. Edit roles that you do use.
- Optional: If you want to sign Git commits with a GPG key, follow the
  instructions [here](https://github.com/pstadler/keybase-gpg-github)
  to generate a GPG key from Keybase. Then set the
  `GIT_SIGNING_KEY_ID` environment variable before running the
  `dot-bootstrap` script.

```
export GIT_SIGNING_KEY_ID=631262B829DDB506
```

Note: After running the dot-bootstrap script, you should put the above
line in `~/.localrc`.

- Run the installation script.

```bash
./bin/dot-bootstrap
```


## authenticating with github

You won't be able to push to repos until you authenticate with GitHub.
You can use `gh` for this, which should have been installed by `dot-bootstrap` above.

```
gh auth login
```

## updating your local environment

Once you have the dotfiles installed you can run the following command to rerun the ansible playbook:

```bash
./bin/dot-update
```

You can optionally pass role names

```bash
./bin/dot-update git python
```

## updating your dotfiles repo

To keep your fork up to date with the `sloria` fork:

```
git remote add tarecord https://github.com/tarecord/dotfiles-ansible.git
git pull sloria master
```

## commands

There are three main commands in the `bin` directory for setting up and updating development environments:

- `dot-bootstrap`: sets up local environment by executing all roles in `local_env.yml`.
- `dot-update`: updates local environment by executing all roles in `local_env.yml` except for the ones tagged with "bootstrap".

## special files

All configuration is done in `~/dotfiles`. Each role may contain (in addition to the typical ansible directories and files) a number of special files

- **role/\*.zsh**: Any files ending in `.zsh` get loaded into your environment.
- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made available everywhere.

## notes

**cursor**

Use built-in Settings Sync to sync Cursor settings.

**macOS keyboard settings**

There are a few keyboard customizations that must be done manually:

- Turning repeat speed up to 11.

![Keyboard settings](https://user-images.githubusercontent.com/2379650/34223505-91f95072-e58d-11e7-9b36-78aec4203b0d.png "Key repeat settings")

**login message**

You can add a message to the login screen using the following command:

```
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "This laptop is connected to an iCloud account and is valueless if lost. Contact (123) 456-7890 if found. Reward included."
```

## troubleshooting

If you get an error about Xcode command-line tools, you may need to run

```
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```

[homebrew]: http://brew.sh/
[homebrew-cask]: https://github.com/caskroom/homebrew-cask
[mas]: https://github.com/mas-cli/mas

## license

[MIT Licensed](http://sloria.mit-license.org/).
