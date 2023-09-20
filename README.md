# Hypr

A collection of dot config files for hyprland with a simple install script for a fresh Arch linux with yay

## Featrues

- Dark theme
- Login and lock screen
- Date and time + day of the week
- Network manager/editor
- KDE-connect integration
- Bluetooth pairing
- Volume, mic and brightness buttons key binding
- Print Screen button key binding to screenshot
- Screen recording with MOD+SHIFT+PrtSc key binding
- CPU, temperature, memory, disk and network stats
- Battery/Power status
- Weather status
- Background change every 5 mins

## Preview

![alt hypr-sample](./assets/preview.gif)

## Key bindings

Below are the basic key bindings to get you started:

- `SUPER + ENTER` - open alacritty terminal
- `SUPER + W` - open google chrome
- `ALT + F4` - close application
- `SUPER + R` - application launcher
- `CTRL + ALT + DELETE` - lock the screen

______________________________________________________________________

## Automatic Installation

Run the setup script:

```sh
git clone https://github.com/adonespitogo/hypr.git
cd hypr
./setup.sh
```
______________________________________________________________________

## Wallpapers

You can add wallpapers in `~/.config/wallpapers`. These images will cycle randomly as wallpaper every 5 mins.

You can trigger random wallpaper change with `MOD+SHIFT+b`.
______________________________________________________________________

## Credits

This setup is based from `SolDoesTech`'s [HyprV2](https://github.com/SolDoesTech/HyprV2) config.
