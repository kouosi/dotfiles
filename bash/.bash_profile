. ~/.bashrc
if [ "$(tty)" == "/dev/tty1" ]; then
    start-sway
fi
