# CachyOS Setup

![screenshot](./screenshot.png)

## Core things:

1. Get a good terminal emulator:

```bash
pacman -S ghostty
```

Then make it default in the settings.

2. Install a good browser:

```bash
paru -S helium-browser-bin
```

And log in to `proton pass` for passwords and passkeys, and `github`.

3. Get `huginn` to make installing stuff easy.

The repo lives [here](https://github.com/krisfur/huginn.git).

On x86_64 just grab the tarball:

```bash
curl -L -O https://github.com/krisfur/huginn/releases/download/v1.0.2/huginn-v1.0.2-linux_x86_64.tar.gz
tar -xzf huginn-v1.0.2-linux_x86_64.tar.gz
sudo cp huginn-v1.0.2-linux_x86_64/huginn /usr/local/bin/huginn
```

Otherwise build from source:

- get the odin compiler

```bash
paru -S odin-git
```

- clone and build

```bash
git clone https://github.com/krisfur/huginn.git
cd huginn
odin build .
sudo cp huginn /usr/local/bin/huginn
```

4. Set up github:
Get `github-cli` using `pacman` or `huginn`, then run:

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

NOTE: change desktop with meta+number doesn't always set by default from import

3. Set `wallpaper` (from `proton drive` or this repo), `lock screen` background, `accent colours` (`#aaffff`), and `SDDM login screen` background.

## Fastfetch config:

From this repo in the `fastfetch/` folder copy the config and the logo to `~/.config/fastfetch/`. Might need to create the folder using `fastfetch --gen-config` or just `mkdir`.

```bash
git clone https://github.com/krisfur/cachyos-setup.git
fastfetch --gen-config
cp cachyos-setup/fastfetch/* ~/.config/fastfetch/
fastfetch --logo-recache
```

You can also change the bottom left icon to the orange logo: click the current logo, click settings in top right of the menu, then change logo.

## Dev stuff

1. Install `Zed`:

```bash
curl -f https://zed.dev/install.sh | sh
```

and add the `Zedokai` extension and set it to `Zedokai Darker (Filter Spectrum)`. All other needed extensions will pop up when you open a file of a certain language, other than `odin`.

2. Install `Claude Code`:

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

2. Install `uv` (pacman)
3. Install `Rust`:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

4. Install `zig` (pacman)
5. Install `cmake` (pacman)
6. Install `go` (pacman)
7. Install `odin` (this is compiled from source! takes ages every update on slow machines):

```bash
paru -S odin-git
```

8. Install `bun`:

```bash
curl -fsSL https://bun.sh/install | bash
```

9. Install `texlive-bin` (pacman)

## Troubleshooting issues

1. `DNS` fails to work with Steam Cloud saves (use the desired SSID):

```bash
# 1. Force your Wi-Fi to use Google (8.8.8.8) and Cloudflare (1.1.1.1)
nmcli connection modify "{SSID}" ipv4.dns "8.8.8.8 1.1.1.1"

# 2. Tell it to IGNORE whatever DNS your router is trying to assign
nmcli connection modify "{SSID}" ipv4.ignore-auto-dns yes

# 3. Apply the changes by reloading the connection
nmcli connection up "{SSID}"
```

this happens after installing a system-wide vpn instead of just a browser extension.

2. Turn off `fish` auto-capitalisation which drives me mad:

```bash
set -g fish_case_insensitive 0
```

3. Fingerprint reader on older thinkpads

If you're lucky all you need is:

```bash
paru -S fprintd
```

if you need boader compatibiliy:

```bash
paru -S open-fprintd fprintd-clients python-validity
```

and then:

```bash
sudo systemctl start python3-validity
sudo systemctl enable python3-validity
sudo systemctl start open-fprintd
sudo systemctl enable open-fprintd
```

after that try:

```bash
fprintd enroll
```

to see if it worked.

If it did now we make it useable by adding:

`auth      sufficient    pam_fprintd.so`

at the top of the file (2nd line) in these two files:

```bash
sudo vim /etc/pam.d/sudo
```

```bash
sudo vim /etc/pam.d/sddm
```

warning: sddm can sometimes bug out and always require a fingerprint and not the password, looking into that.

then you can go to `KDE settings -> users -> add fingerprint` and register your fingers.
