# Производим поиск конфигурации nvim
if [ -e $HOME/.config/nvim/init.vim ]
then
    echo "Конфиг nvim на этой машине найден. Будет произведено его копирование в репозиторий"
    cp $HOME/.config/nvim/init.vim ../configs/init.vim
else
    echo "Конфиг nvim на данной машине не был найден"
fi

# Производим поиск конфигурации vim
if [ -e /usr/share/vim/vimrc ]
then
    echo "Конфиг vim на этой машине найден. Будет произведено его копирование в репозиторий"
    cp /usr/share/vim/vimrc ../configs/vimrc
else
    echo "Конфиг vim на данной машине не был найден"
fi
