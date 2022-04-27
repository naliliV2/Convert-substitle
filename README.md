# Convert subtitle
<div align="center">

![:Convert-subtitle](https://img.shields.io/apm/l/Convert-subtitle?style=for-the-badge)
![:Version](https://img.shields.io/badge/Version-Alpha_1.0-brightgreen?style=for-the-badge)
![:Size](https://img.shields.io/github/size/nalili/Convert-subtitle?style=for-the-badge)

<br>

![:nalili_convert_sub](https://count.getloli.com/get/@s:nalili_convert_sub?theme=rule34)
</div>

# About the repo

This repo aims to make a simple, fast, effective converter to transform all .ass and .pgssub into .srt because a friend's anime site doesn't accept these formats very well and some connections can't keep up (especially for the pgssub format).

# How it works

For the moment it's very simple, you have to put your mkv in "Todo" and run" ``start.ps1``

<div style="color: rgb(207, 80, 80);">WARNING:</div> This programme is not really very functional yet and only works for a small number of videos with specific characteristics. THE BIGGEST BASE HAS BEEN MADE.

</br>

# Todo list for to pass in 1.0

- [ ] Add documentation 
- [ ] Added the ability to run the project via a terminal command to select the file and not put it in the `todo` folder
- [ ] Try to find another way than going through tkinter to choose a colour easily.
- [ ] Make sure that the program does not extract the subtitles if there is already a `.srt` in the mkvfile
  - [ ] Added an optional arg to force it even if there is a .srt in the mkv file
  - [ ] Added an optional arg to choose only sub to convert (useful if there are many sub of several times the same language and you want to convert only one)
  - *probably more arg*

<!-- - [ ] (Optional) Convert all python file to C++ or Rust for faster execution
- [ ] (Optional) Add a GUI
- *[ ] (Optional) Separate entirely from mkvtoolnix* -->

# Lib / Software use 
> [mkvtoolnix](https://gitlab.com/mbunkus/mkvtoolnix/) (In the dir 'dep')

# Contact me!
<a href="mailto:nalili0000007@gmail.com"> Email </a> </br>
discord: nalili#6666