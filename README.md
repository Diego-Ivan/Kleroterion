<img align="left" style="vertical-align: middle;" width="160" height="160" src="https://codeberg.org/foreverxml/random/raw/branch/main/data/icon.png">

# Random
Make randomization easy

[![Please do not theme this app](https://stopthemingmy.app/badge.svg)](https://stopthemingmy.app) [![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://codeberg.org/foreverxml/random/src/branch/main/COPYING) [![Matrix](https://img.shields.io/matrix/randomgtk:matrix.org?label=Chat&server_fqdn=matrix.org)](https://matrix.to/#/#randomgtk:matrix.org)

<p align="center"><img alt="A screenshot of the main chrome of Random" src="https://codeberg.org/foreverxml/random/raw/branch/main/screenshots/number.png" /></p>

<p align="center"><a href='https://flathub.org/apps/details/page.codeberg.foreverxml.Random'><img width='240' alt='Download on Flathub' src='https://flathub.org/assets/badges/flathub-badge-en.png'/></a></p>

<br />

<details align="center">
<summary>More screenshots</summary>
<img alt="Roulette UI of Random" src="https://codeberg.org/foreverxml/random/raw/branch/main/screenshots/roulette.png" />
<img alt="Coin UI of Random" src="https://codeberg.org/foreverxml/random/raw/branch/main/screenshots/coin.png" />
</details>

## 🎰 Uses
- Choose what to do for a date
- Play a number-guess game
- Choose between coffee or tea
- For science!
## 📩 Download Random!
Download it from Flathub by clicking the really big button above.
## 👩‍💻️ Techy stuff
<details>
<summary>Show the techy stuff</summary>

### 📲 Another way to download
Head on over to the [Releases](https://codeberg.org/foreverxml/random/releases) page and grab the latest Flatpak, then install it.
#### 📝 A note
You can get it through the user-submitted AUR repo, but that will usually be out of date. The method I support the most is Flathub/Flatpak.
### 🛠️ Building Random
#### Flatpak
Clone this repo on GNOME Builder >= 3.28, open it, and click the *Build* button.
#### Native / Host
Clone this repo, and in the cloned directory run these commands:
```sh
meson _build --prefix=/usr && cd _build
sudo ninja install
```
You will need to install:
```
gdk-pixbuf2
glib2
gtk4
libadwaita
appstream-glib
meson
vala
```
#### Windows
I don't support anything but Flatpak. You will have to run this app through WSL, although Windows is such a privacy nightmare I do not support WSL. The app may be broken on Windows too. My reccomendation is to use this app on GNOME *NIX systems.
### 🌐 Translating Random
Help me make some po files! I'm not very fluent in any language except English, so translations would be appreciated. Do NOT include .mo files, I will reject your PR if so.
### 🛣️ Roadmap for Random
- [x] [GNOME GitLab mirror](https://gitlab.gnome.org/foreverxml/random)
- [x] ~~GitHub mirror~~ Ewww, GitHub? No thanks.
- [x] Copy result keyboard shortcut and menu item
- [x] Working translations (thanks to [teackot](https://codeberg.org/teackot) and [dimmednerd](https://codeberg.org/DiegoIvan)) 
- [ ] More translations
#### Roadmap for 1.1 - 1.2
- [x] Move Randomization functionality to different file
- [ ] DBus search
    - [ ] *Open in Random* prefills fields
#### Unimportant
- [ ] Windows package (LTS)
### 👩‍💻️ How to contribute to Random
<details>
<summary>Contributing</summary>
Hey there! So, you want to contribute to Random.

- Make a PR (or message me on Matrix) adding yourself to the Contributors section in this README.
- Next, here are some things I will label as wontfix.
    - Anything against GNOME HIG
    - Something too advanced for this simple app And don't forget to test before your PR! Have a great day.
</details>
</details>

## 🤝 Conduct
This project follows the [GNOME Code of Conduct](https://wiki.gnome.org/Foundation/CodeOfConduct).

## 👥 Contributors to Random
<details>
<summary>See the Contributors</summary>

- [foreverxml](https://codeberg.org/foreverxml) - 🐛🎨🤔🚧👀🌍⚠️💻
- [teackot](https://codeberg.org/teackot) - 🐛🌍⚠️💻
- [dimmednerd](https://codeberg.org/DiegoIvan) - 🐛🌍⚠️💻
</details>

Uses the [All Contributors Emoji Key](https://allcontributors.org/docs/en/emoji-key).
## 🖥️ Supported OS?

<details><summary>Long thing about OS support</summary>

### 🐧 Linux
Already supported; this is the main support!
### 🪟 Windows
Not for right now. Check the Roadmap for details on Windows support. And if you do want Windows, get ready to build it yourself.
### 🍏 MacOS and/or iOS
No, never. I am against all Apple platforms, and Random will never have a Mac package. I don't think GTK is supported on iOS either, though.
### 🤖 Android
GTK isn't supported yet, but I would publish on [F-Droid](https://fdroid.org).

</details>

## 💸 Donations
I am well off and do not need donations. Instead, donate [to trans people in need](https://nitter.snopyta.org/search?q=%23TransCrowdFund).
