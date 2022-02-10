# configs_and_scripts
Репозитория предназначен для хранения всяческих конфигов и скриптов для автоматизации установки ПО, которым я пользуюсь на постоянной основе.

# Структура репозитория на момент создания (10.02.2022)

5 directories, 3 files
.
├── README.md
├── configs
│   ├── config.fish
│   ├── init.vim
│   ├── nvim
│   │   └── init.vim
│   ├── vim
│   │   └── vimrc
│   └── vimrc
├── fonts
│   ├── AnonymousPro.zip
│   └── Hack.zip
└── scripts
    ├── import_nvim_config.sh
    ├── renew_config_from_machine.sh
    └── useful-scripts
        ├── dotnet-install.ps1
        ├── dotnet-install.sh
        ├── exec.sh
        └── gs.sh

6 directories, 14 files

# Основные разделы

## Configs

В данной директории на данный момент хранится конфиг для **fish** shell, для **vim**, для **neovim**, которым я в последнее время больше пользуюсь.
Так как данные конфиги не содержат личной информации, я решил их разместить в публичном поле на тот случай, если вдруг они пригодянся еще кому-то помимо меня.

## Fonts

В данной директории я решил сохранять те шрифты, которыми я пользуюся для терминалов.
Данные шрифты содержат дополнительный набор блифов, они моноширинные, поэтому отлично подходят под использование в терминале.

## Scripts

В данной директории содержатся все полезные скрипты, которые я решил сохранить.
На данный момент в корне директории находятся скрипты, которые писал я сам (и они конечно же такие себе), а так же в директории **useful-scripts** находятся сторонние скрипты, которые писал уже не я, но к которым мне уже приходилось не раз обращаться, поэтому я решил их сохранить в своем репозитории, чтобы потом, когда они понадобятся, не искать их.

### import_nvim_config

Простой скрипт для ускорения обновления конфига nvim из данного репозитория.
Правда скрипт написан плохо, поэтому наверное не стоит им в данный момент пользоваться.
Может быть когда-нибудь у меня доберутся руки до правки.

### renew_config_from_machine

Так же простой скрипт моей разработки, предназначен для перезаписи конфига **nvim**, расположенного на машине, в данный репозиторий.

### dotnet-install

Скрипты установки **dotnet** для **Linux** и **Windows**.
Скачать их если что можно по [данной ссылке](https://docs.microsoft.com/ru-ru/dotnet/core/tools/dotnet-install-script)
Так же на данной странице можно прочитать краткую документацию по применению скрипта.

### exec.sh и gs.sh

Разработка моего коллеги (Семена) для пакетной обработки файлов.
В какой-то момент возникла задача обработать большое количество PDF файлов, расположенних в древовидной структуре папок, и расположить данные файлы в копии этой древовидной структуры.
Для этого был написан скрипт общего назначения, который в качестве входных параметром принимает исходную директорию, директорию назначения, regexp выражение для фильтрации файлов, а так же команду, которая должна выполняться для каждого файла.

Скрипт **exec.sh** как раз ответственнен за поиск файлов, обработку путей исходного файла и файла назначения, а так же за запуск команды, а скрипт **gs.sh** - конкретная реализация команды, которая обрабатывает файлы при помощи утилиты **gs**.
Пример запуска команды (Примечание: для этого оба скрипта должны находится в текущей рабочей директории):

```bash
./exec.sh -s /mnt/d/PDF\ на\ обработку/ -o /mnt/d/Processed_PDF_medium-quality -c ./gs.sh
```

В данном случае:

- ключ s отвечает за указание директории источника
- ключ o отвечает за указание директории назначения
- ключ с отвечает за указание команды для выполнения
- так же есть ключ, который позволяет уточнить фильтр файлов, по умолчанию он установлен на [pP][dD][fF]

