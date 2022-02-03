# How to compile (Nintendo Switch)
1. Have [devKitPro](https://devkitpro.org/wiki/Getting_Started) installed with switch development
2. Have zip installed with msys2 or pacman (`sudo pacman -S zip`)
3. Download the switch dependency [here](https://github.com/retronx-team/love-nx/releases/download/11.3-nx3/love.elf) and put it in `./resources/switch`
4. go to the base directory where the Makefile is located
5. run the command `make switch`. This will compile a lovefile and the switch nro

# The easier way of "compiling" for switch
1. zip all contents in src/love (DO NOT JUST ZIP UP THE LOVE FOLDER. main.lua MUST BE IN THE BASE DIRECTORY OF THE ZIP)
2. Download & Extract the love-nx NRO from [here](https://github.com/retronx-team/love-nx/releases/tag/11.3-nx3)
3. rename the zipped file to "game.love" and put the file in the same directory of the love-nx NRO