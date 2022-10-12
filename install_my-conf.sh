#!/bin/bash

# Colours Variables
RESTORE='\033[0m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'
LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'


# Директория для установки шрифтов
DEST_DIR_Sagoe="$HOME/usr/share/fonts/Microsoft/TrueType/Segoe UI/"
DEST_DIR_XO="$HOME/usr/share/fonts/myoffice/"
DEST_DIR_ASTRA="$HOME/usr/share/fonts/astra/"


function banner(){
    echo -e $LBLUE"=============================================================================================================================================================================================================="
    echo -e $LYELLOW"                                                                                                                                                                                                    "
    echo -e "                                              ____    ____   ______    __           _______. __  ___         .______     .______                                                                            "
    echo -e "                                              \   \  /   /  /  __  \  |  |         /       ||  |/  /         |   _  \    |   _  \                                                                           "
    echo -e "                                               \   \/   /  |  |  |  | |  |        |   (----'|  '  /   ______ |  |_)  |   |  |_)  |                                                                          "
    echo -e "                                                \      /   |  |  |  | |  |         \   \    |    <   |______||      /    |   _  <                                                                           "
    echo -e "                                                 \    /    |  '--'  | |  '----..----)   |   |  .  \          |  |\  \---.|  |_)  |                                                                          "
    echo -e "                                                  \__/      \______/  |_______||_______/    |__|\__\         | _| \ ____||______/                                                                           "
    echo "                                                                                                                                                                                                               "
    echo "                                                                                                                                                                                                               "
    date
    echo -e "$LBLUE=====================================================================================================================================================================================Скрпит версии 1.3" $RESTORE
    echo " "
    inxi -b
    echo " "
    echo "Добрый день. Это скрипт настройки Ubuntu 18.04 с окружением KDE Plasma"
    echo " "
    echo " "
}


# Проверяем есть ли интернет соединение
function checkconnect(){
    echo -e "$LYELLOW [ * ]   Проверка интернет соединения"
    sleep 1
    echo -e "GET http://yandex.ru HTTP/1.0\n\n" | nc yandex.ru 80 > /dev/null 2>&1
    # Предварительная настройка удаления нетплан
    rm /etc/netplan/01-netcfg* &
    if [ $? -ne 0 ]; then
        echo -e "$RED [ X ]  $LYELLOW Интернет соединение ➜$RED ОТСУТСТВУЕТ!\n";
        echo -e "$RED Извините, но вы реально вставили кабел в дырочку?"
        exit 0
    else
        echo -e "$GREEN [ ✔ ]  $LYELLOW Интернет соединение ➜$GREEN ПОДКЛЮЧЕНО!\n";
        sleep 1
    fi
}


function checkwget(){
    echo -e "$LYELLOW [ * ]   Провекра доступности утилиты Wget"
    sleep 1
    which wget > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
    echo -e "$GREEN [ ✔ ]  $LYELLOW Wget ➜$GREEN УСТАНОВЛЕНА\n"
        sleep 1
    else
        echo -e "$RED [ X ]  $LYELLOW Wget ➜$RED НЕ УСТАНОВЛЕНА\n"
        continueWget
    fi
}


continueWget() {
  echo -e "$LGREEN [ * ]   Вы хотите установить утилиту Wget? (y)es, (n)o :"
  read  -p ' ' INPUT
  case $INPUT in
    [Yy]* ) wgetinstall;;
    [Nn]* ) end;;
    * ) echo -e "$RED\n Извините, что то пошло не так."; continueWget;;
  esac
}


function wgetinstall(){   
    sleep 1
    sudo apt update > /dev/null 2>&1
    sudo apt install -y wget > /dev/null 2>&1
}


function cekfont(){
    echo -e "$LYELLOW [ * ]   Проверяем установлены ли шрифты Segoe-UI, Astra, XO"
    sleep 1
    checkFontsSagoe
    checkFontsXO
    checkFontsASTRA
    
}

function fontinstallSagoe(){
    mkdir -p "$DEST_DIR_Sagoe"
    wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeui.ttf?raw=true -O "$DEST_DIR_Sagoe"/segoeui.ttf > /dev/null 2>&1 # regular
    wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuib.ttf?raw=true -O "$DEST_DIR_Sagoe"/segoeuib.ttf > /dev/null 2>&1 # bold
    wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuii.ttf?raw=true -O "$DEST_DIR_Sagoe"/segoeuii.ttf > /dev/null 2>&1 # italic
    wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuiz.ttf?raw=true -O "$DEST_DIR_Sagoe"/segoeuiz.ttf > /dev/null 2>&1 # bold italic
    wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuil.ttf?raw=true -O "$DEST_DIR_Sagoe"/segoeuil.ttf > /dev/null 2>&1 # light
    wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/seguili.ttf?raw=true -O "$DEST_DIR_Sagoe"/seguili.ttf > /dev/null 2>&1 # light italic
    wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuisl.ttf?raw=true -O "$DEST_DIR_Sagoe"/segoeuisl.ttf > /dev/null 2>&1 # semilight
    wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/seguisli.ttf?raw=true -O "$DEST_DIR_Sagoe"/seguisli.ttf > /dev/null 2>&1 # semilight italic
    wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/seguisb.ttf?raw=true -O "$DEST_DIR_Sagoe"/seguisb.ttf > /dev/null 2>&1 # semibold
    wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/seguisbi.ttf?raw=true -O "$DEST_DIR_Sagoe"/seguisbi.ttf > /dev/null 2>&1 # semibold italic
    fc-cache -f "$DEST_DIR_Sagoe"
    echo -e "$GREEN\n Шрифты установлены в $LBLUE'$DEST_DIR_Sagoe'"
}

function fontinstallXO(){
    mkdir -p "$DEST_DIR_XO"

    fc-cache -f "$DEST_DIR_XO"
    echo -e "$GREEN\n Шрифты установлены в $LBLUE'$DEST_DIR_XO'"
}

function fontinstallXO(){
    mkdir -p "$DEST_DIR_ASTRA"

    echo -e "$GREEN\n Шрифты установлены в $LBLUE'$DEST_DIR_ASTRA'"
}


function checkFontsSagoe(){
    
    fc-list | grep -i "Segoe UI" >/dev/null 2>&1
    if [ "$?" -eq "0" ]; then
    echo -e "$GREEN [ ✔ ]  $LBLUE    Шрифты Segoe-UI ➜$GREEN УСТАНОВЛЕНЫ\n"
        sleep 1
    else
        echo -e "$RED [ X ]$LBLUE    Шрифты Segoe-UI ➜$RED НЕ УСТАНОВЛЕНЫ\n"
        echo -e "$LYELLOW Начинается автоматическая установка недостающих шрифтов"
        fontinstallSagoe
    fi
}

function checkFontsXO(){
    sleep 1
    fc-list | grep -i "Segoe UI" >/dev/null 2>&1
    if [ "$?" -eq "0" ]; then
    echo -e "$GREEN [ ✔ ]  $LBLUE   Шрифты XO ➜$GREEN УСТАНОВЛЕНЫ\n"
        sleep 1
    else
        echo -e "$RED [ X ]$LBLUE   Шрифты XO ➜$RED НЕ УСТАНОВЛЕНЫ\n"
        echo -e "$LYELLOW Начинается автоматическая установка недостающих шрифтов"
        
    fi
}

function checkFontsASTRA(){
    sleep 1
    fc-list | grep -i "PT Astra" >/dev/null 2>&1
    if [ "$?" -eq "0" ]; then
    echo -e "$GREEN [ ✔ ]  $LBLUE Шрифты PT Astra ➜$GREEN УСТАНОВЛЕНЫ\n"
        sleep 1
    else
        echo -e "$RED [ X ]$LBLUE Шрифты PT Astra ➜$RED НЕ УСТАНОВЛЕНЫ\n"
        echo -e "$LYELLOW Начинается автоматическая установка недостающих шрифтов"
        
    fi
}


function instRep(){
    echo -e "$LYELLOW [ * ]  Добавляем необходимые репозитории"
    sleep 1
    echo -e $LYELLOW "==================================================== Добавляем репозиторий LibreOffice ======================================================================"$RESTORE
    add-apt-repository -y ppa:libreoffice/ppa

    echo -e $LYELLOW "==================================================== Добавляем репозиторий Open Broadcast Studio ============================================================"$RESTORE
    add-apt-repository -y ppa:obsproject/obs-studio

    echo -e $LYELLOW "==================================================== Добавляем репозиторий программы резервного копирования Time Shift ======================================"$RESTORE
    add-apt-repository -y ppa:teejee2008/timeshift

    echo -e $LYELLOW "==================================================== Добавляем репозиторий Firefox-ESR ======================================================================"$RESTORE
    add-apt-repository -y ppa:mozillateam/ppa

    echo -e $LYELLOW "==================================================== Добавляем репозиторий Only Office ======================================================================"$RESTORE
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
    echo 'deb https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee -a /etc/apt/sources.list.d/onlyoffice.list
}

function instProg(){
    echo -e "$LYELLOW [ * ]  Устанавливаем обновления и программы" $RESTORE
    sleep 1
    apt update & apt install libreoffice libreoffice-kde5 libreoffice-help-ru libreoffice-l10n-ru obs-studio timeshift playonlinux libglade2-0 jbigkit-bin firefox-esr -y
#     sleep 1
#     apt install -y /install/Prog/Any/*.deb
}


function oldKernl(){
    echo -e "$LYELLOW [ * ]  Начинаю работу с ядрами системы"
    sleep 1
    echo -e $LYELLOW "==================================================== Удаляем все версии старых ядер системы ================================================================="$RESTORE
    apt purge -y linux-image-4.15.0*
    apt purge -y linux-image-4.16.0*
    apt purge -y linux-image-4.17.0*
    apt purge -y linux-headers-4.15.0*
    apt purge -y linux-image-signed-4.16.0*
    apt purge -y linux-headers-4.16.0*
    apt purge -y linux-image-signed-4.16.0*
    apt purge -y linux-image-signed-4.17.0*
    apt purge -y linux-headers-4.17.0*
    apt purge -y linux-image-signed-4.17.0*
    apt purge -y linux-image-unsigned-4.15.0*
    echo -e $LYELLOW "================================================= Вывожу информацию о оставшиххся ядрах в системе ==========================================================="$RESTORE
    apt list --installed | egrep "linux-image|linux-headers"
}

function otherPref(){
    echo -e "$LYELLOW [ * ]  Дополнительные настройки системы"
    sleep 1
    echo -e $LYELLOW "==================================================== Отключаем браузер капс ================================================================================"$RESTORE
    systemctl disable cups-browsed
    echo -e $LYELLOW "==================================================== Добавляем 32 bit архитектуру для Винишка ==============================================================="$RESTORE
    echo -e $LBLUE"================================================================================================================================================================"$RESTORE
    echo -e $LBLUE"================================================================================================================================================================"$RESTORE
    echo -e $LBLUE"================================================================================================================================================================"$RESTORE
    echo -e $LYELLOW "==================================================== Красного полусладкого... Санкционного... ==============================================================="$RESTORE
    dpkg --add-architecture i386
    echo -e $LYELLOW "Устанавливаем ZRAM"$RESTORE
    apt install zram-config
    echo -e $LYELLOW "Добавляем user в группы"$RESTORE
    usermod -a -G cdrom,dip,plugdev,lpadmin,sambashare user
    apt purge git -y
}

function kesl(){
    echo -e "$LYELLOW [ * ]  Устанавливаем антивирус касперского версии 11.1.0-3013"$RESTORE
    sleep 1
    dpkg -i /install/Prog/Kasper/kesl_11.1.0-3013.cert_amd64.deb 
    /opt/kaspersky/kesl/bin/kesl-setup.pl --autoinstall /install/Prog/Kasper/answer.ini
    echo -en "\n\e[1;32mКасперский установлен\n\e[0m"
}

function csp(){
    echo -e "$LYELLOW [ * ]  Устанавливаем СКЗИ Крипто-Про 5.0.11455 $RED 'Fury'"$RESTORE
    sleep 1
    /install/Prog/CryptoPro/linux-amd64_deb/install_gui.sh
    dpkg -i /install/Prog/CryptoPro/*.deb	
}    


function prefDeck(){
    echo -e "$LYELLOW [ * ]  Начинаю настройки рабочего окружения"$RESTORE
    sleep 1
    tar -xf /home/user/doppref.tar -C /home/user/
    mv /home/user/darkine  /usr/share/icons/
    echo -e $LYELLOW "==================================================== Добавляем преднастройку KDE Plasma для пользователя ===================================================="$RESTORE
    echo user | su -l user -c /install/kde-plasma-backup/install_buckup_kde.sh
    echo -e $LYELLOW "==================================================== Переносим ярлыки на рабочий стол ======================================================================"$RESTORE
    rm /home/user/Рабочий\ стол/*
    tar -C /home/user/'Рабочий стол'/  -xvf /install/pref/Desk.tar.gz --strip-components 1
    ln -s /usr/share/applications/firefox-esr.desktop /home/user/Рабочий\ стол/
    ln -s /usr/share/applications/chromium-gost.desktop /home/user/Рабочий\ стол/
    ln -s /usr/share/applications/com.obsproject.Studio.desktop /home/user/Рабочий\ стол/
    ln -s /usr/share/applications/libreoffice-startcenter.desktop  /home/user/Рабочий\ стол/
    ln -s /usr/share/applications/onlyoffice-desktopeditors.desktop /home/user/Рабочий\ стол/
    ln -s /usr/share/applications/org.kde.okular.desktop /home/user/Рабочий\ стол/
    ln -s /usr/share/applications/vlc.desktop /home/user/Рабочий\ стол/
    ln -s /usr/share/applications/org.kde.kcalc.desktop /home/user/Рабочий\ стол/
    ln -s /usr/share/applications/assistant.desktop /home/user/Рабочий\ стол/
}

main(){
    clear
    banner
    checkconnect
    checkwget
    cekfont
    instRep
    instProg
    oldKernl
    otherPref
    kesl
    csp
    prefDeck
}

main


mv /install/Prog/Any/*.deb /home/user/
mv /install/vipnetclient-gui_ru_amd64_4.8.0-6347.deb /home/user/
rm -R /install
rm /home/user/desk.sh
rm -R /home/user/install_conf/
rm /home/user/install_my-conf.sh
rm /home/user/doppref.tar

mv /home/user/trusted_sites.html /etc/opt/cprocsp/

apt autoremove -y

sleep 1
echo -e $LYELLOW "====================================================== Компьютер будет перезагружен через 10 секунд ==================================================="$RESTORE

sleep 10


#В работе
# echo -e $LYELLOW"Установка плагина MIS"$RESTORE
# cd /home/user/myPREF/Plugins/
# mkdir -p /opt/misdesktopapp
# mv misDesktopApp-2.0.0.AppImage /opt/misdesktopapp/misDesktopApp-2.0.0.AppImage
# cd /opt/misdesktopapp/
# chmod ugo+x misDesktopApp-2.0.0.AppImage
# echo -e $RED"Команда выполняется от пользователя"$RESTORE
# echo user | su -l user -c /opt/misdesktopapp/misDesktopApp-2.0.0.AppImage
# 
# echo user | su -l user -c /opt/misdesktopapp/misDesktopApp-2.0.0.AppImage



reboot
