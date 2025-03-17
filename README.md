# Dotfiles

This repository contains the automated setup of my machines. My primary targets are MacOS and Ubuntu machines.

# How to Set Up a new Machine

## Ubuntu

```bash
bash -c "$(wget -qO - https://raw.githubusercontent.com/Ecuashungo/dotfiles/refs/heads/feature/advanced/setup.sh)"
```

With debug:
```bash
DOTFILES_DEBUG=1 bash -c "$(wget -qO - https://raw.githubusercontent.com/Ecuashungo/dotfiles/refs/heads/feature/advanced/setup.sh)"
```


## MacOS
```bash
bash -c "$(curl -fsLS https://raw.githubusercontent.com/Ecuashungo/dotfiles/refs/heads/feature/advanced/setup.sh)"
```



## Old
```bash
GITHUB_USERNAME="Ecuashungo"
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```