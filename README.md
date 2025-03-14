# Dotfiles

This repository contains the automated setup of my machines. My primary targets are MacOS and Ubuntu machines.

# How to Set Up a new Machine

```bash
GITHUB_USERNAME="Ecuashungo"
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```