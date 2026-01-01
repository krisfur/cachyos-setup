# CachyOS Setup

## Core things:

1. Get a good terminal editor:

```bash
pacman -S ghostty
```

Then make it default in the settings.

2. Install yay:

```bash
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

3. Install a good browser:

```bash
yay -S zen-browser-bin
```

And log in to `mozilla account` for sync, `proton pass` for passwords and passkeys, and `github`. Can grab wallpapers from `proton drive` now as well.

3. Get `arch-browse` to make installing stuff easy.

The repo lives [here](https://github.com/krisfur/arch-browse.git).

```bash
git clone https://github.com/krisfur/arch-browse.git
cd arch-browse
chmod +x arch-browse.sh
sudo mv arch-browse /usr/local/bin/arch-browse
cd ..
rm -rf arch-browse/
```

5. Set up github:
Get `github-cli` using pacman or arch-browse, then run:

```bash
gh auth login
```

And authenticate using your browser. After that config time:

```bash
git config --global user.email "k_furman@outlook.com"
git config --global user.name "Krzysztof Furman"
git config --global init.defaultBranch main
```

## System settings

In the settings we need to change a few things:

1. Add more desktops (We want 5)

Then right click the pager and set it to show windows and icons.

2. Set keybinds:

- switching desktops (`meta+1` etc.)
- moving programs to desktops (`meta+shift+1` etc.)
- maximising (`meta+F`)
- fullscreen (`meta+shift+F`)
- ghostty (`meta+enter`)
- zen (`meta+shift+B`) (add new application)
- btop `meta+shift+T`) (add new application)

or import the included `shortcuts.kksrc` file.

3. Set wallpaper (from `proton drive`), lock screen background, accent colours, and SDMM login screen background.

## Dev stuff

1. Install `Zed`:

```bash
curl -f https://zed.dev/install.sh | sh
```

and add the `Zedokai` extension and set it to `Zedokai Darker (filter Ristretto)`. All other needed extensions will pop up when you open a file of a certain language.

2. Install `uv` (pacman)
3. Install `Rust`:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
4. Install `zig` (pacman)
5. Install `cmake` (pacman)
6 Install `go` (pacman)
7. Install `Kotlin` and `gradle` (pacman)
8. Instapp `nodejs` and `npm` (pacman)
