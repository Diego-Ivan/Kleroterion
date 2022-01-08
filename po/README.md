# 🌎 Translating Random
## ☝️ First things first
- Fork this Codeberg repo... with that button up there that says "Fork"
- Clone the forked repository
	- In GNOME Builder, paste the URL `https://codeberg.org/your_username/random` (replace `your_username` with your username)
	- From the command line, paste the command `git clone https://codeberg.org/your_username/random` (replace `your_username` with your username)
## ✌️ Second things second
- Know the language code you will be translating to (for example, `de_AT` for Austrian German)
- Add that code to the end of the LINGUAS file in a new line
## 😧 PAIN!
- Copy the POT file and translate it to your language (I reccomend using POEdit)
	- Make sure to read the comments on the POT file- they're very important and annoying to fix later!
- Save the translated file as `language_code.po` in this folder (replace `language_code` with your language code)
	- If using POEdit, delete the `.mo` file generated too.
## 😌 You made me a believer... in translating Random!
- Commit the file.
	- Run `git add -A && git commit` in the embedded terminal of Builder or in a terminal emulator.
- Then, push it.
	- Run `git push`, same way as mentioned above.
- And then, open a PR to Random.
	- Click [here](https://codeberg.org/foreverxml/random/compare/main...main) if you're too lazy to click on the buttons from here.
- And prepare to update the translation again and again.

Congrats, you translated Random!

## 📜 Also, updating the POT file.
If you made translations in other places, you should either:
- Hand-update the POT file
- Run `meson _build --prefix=/usr && meson compile -C _build randomgtk-pot`

## 😕 This is so slow...
Compiling all of Random, just for the PO files? That's not... great. Instead of doing that, run:

```sh
meson _build --prefix=/usr
meson compile -C _build randomgtk-update-po
```

###### *This was made by help from ocsfdezdz. Thank you!*
