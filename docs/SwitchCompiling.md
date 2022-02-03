# How to compile (Nintendo Switch)
1. Have [devKitPro](https://devkitpro.org/wiki/Getting_Started) installed with switch development
2. Have zip installed with msys2 or pacman (`sudo pacman -S zip`)
3. Download the switch dependency [here](https://github.com/retronx-team/love-nx/releases/download/11.3-nx3/love.elf) and put it in ./resources/switch
4. go to the base directory where the Makefile is located
5. run the command `make switch`. This will compile a lovefile and the switch nro