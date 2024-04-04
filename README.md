## Information 

A German translation of https://github.com/gb-mobile/pokecrystal-mobile-eng
This translation was performed via text dumps and a (somewhat) sophisticated find/replace script, with the remaining mobile feature text translated by LesserKuma.

## Setup [![Build Status][ci-badge]][ci]

For more information, please see [INSTALL.md](INSTALL.md)

After setup has been completed, you can choose which version you wish to build.
To build a specific version, run this command inside the repository directory in cygwin64:

`make`


Other languages are being worked on, but are not complete and still require a lot of polish.

## Screenshots

![image](https://github.com/gb-mobile/pokecrystal-mobile-ger/assets/110418063/ba663136-d7fa-423e-974d-7cf0f05362fd)
![image](https://github.com/gb-mobile/pokecrystal-mobile-ger/assets/110418063/b4ceadf8-592b-41ca-8cf9-ce4f397d01ab)
![image](https://github.com/gb-mobile/pokecrystal-mobile-ger/assets/110418063/062796fd-380d-4a21-8f3f-93a4fd220772)
![image](https://github.com/gb-mobile/pokecrystal-mobile-ger/assets/110418063/07190487-05ff-4bf7-b68e-cd41161c97ca)
![image](https://github.com/gb-mobile/pokecrystal-mobile-ger/assets/110418063/d3ff672c-54b5-4b28-8cc1-e327d2bd0744)
![image](https://github.com/gb-mobile/pokecrystal-mobile-ger/assets/110418063/9df60976-2b40-41f1-bc26-a7cde97adaba)
![image](https://github.com/gb-mobile/pokecrystal-mobile-ger/assets/110418063/72732978-9cf7-471d-8314-d7c5cb634f82)
![image](https://github.com/gb-mobile/pokecrystal-mobile-ger/assets/110418063/530794b4-83ea-4097-aef4-ec43b6e4907a)
![image](https://github.com/gb-mobile/pokecrystal-mobile-ger/assets/110418063/e28e5656-ea85-452d-872d-d1d2b6b8a360)
![image](https://github.com/gb-mobile/pokecrystal-mobile-ger/assets/110418063/dc35bc4e-8086-4c8d-a79d-b3d2c1e41108)
![image](https://github.com/gb-mobile/pokecrystal-mobile-ger/assets/110418063/88ae5a4b-a52f-432a-8142-ef03920594c5)
![image](https://github.com/gb-mobile/pokecrystal-mobile-ger/assets/110418063/d8c279cf-1c1e-45b4-a823-39b15d0aceb2)
![image](https://github.com/gb-mobile/pokecrystal-mobile-ger/assets/110418063/739c6d36-51bf-43ef-8677-2ce1f7fd49c6)

## Using Mobile Adapter Features

To take advantage of the Mobile Adapter features, we currently recommend the GameBoy Emulator BGB:
https://bgb.bircd.org/

and libmobile-bgb:
https://github.com/REONTeam/libmobile-bgb/releases

Simply open BGB, right click the ‘screen’ and select `Link > Listen`, then accept the port it provides by clicking `OK`.
Once done, run the latest version of libmobile for your operating system (`mobile-windows.exe` or windows and `mobile-linux` for linux).
Now right click the ‘screen’ on BGB again and select `Load ROM…`, then choose the pokecrystal-mobile `.gbc` file you have built.

## Mobile Adapter Features

A full list of Mobile Adapter features for Pokémon Crystal can be found here:
https://github.com/gb-mobile/pokecrystal-mobile-en/wiki/Pok%C3%A9mon-Crystal-Mobile-Features

## Contributors

- Pret           : Initial disassembly
- Pfero          : Old German disassembly for Pokecrystal
- Lesserkuma     : German Translations for mobile content.
- Matze          : Mobile Restoration & Japanese Code Disassembly & German Translation
- Damien         : Code
- DS             : GFX & Code
- Ryuzac         : Code & Japanese Translation
- Zumilsawhat?   : Code (Large amounts of work on the EZ Chat system)
- REON Community : Support and Assistance

[ci]: https://github.com/pret/pokecrystal/actions
[ci-badge]: https://github.com/pret/pokecrystal/actions/workflows/main.yml/badge.svg
