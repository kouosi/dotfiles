#/bin/sh

cd $XDG_DATA_HOME/fonts

set +ex

wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/0xProto.zip
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/ComicShannsMono.zip
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CommitMono.zip
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip

for i in *.zip
do
	unzip -n "$i" && rm -f "$i"
done

fc-cache -f
