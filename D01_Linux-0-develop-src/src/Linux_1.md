# UNIX/Linux operating systems (Basic).
1. [Установка OS](#part-1-установка-OS)
2. [Создание пользователя](#part-2-создание-пользователя)
3. [Настройка сети OS](#part-3-настройка-сети-OS)
4. [Обновление OS](#part-4-обновление-OS)
5. [Использование команды sudo](#part-5-использование-команды-sudo)
6. [Установка и настройка службы времени](#part-6-установка-и-настройка-службы-времени)
7. [Установка и использование текстовых редакторов](#part-7-установка-и-использование-текстовых-редакторов)
8. [Установка и базовая настройка сервиса SSHD](#part-8-установка-и-базовая-настройка-сервиса-SSHD)
9. [Установка и использование утилит top, htop](#part-9-установка-и-использование-утилит-top,-htop)
10. [Использование утилиты fdisk](#part-10-использование-утилиты-fdisk)
11. [Использование утилиты df](#part-11-использование-утилиты-df)
12. [Использование утилиты du](#part-12-использовани-утилиты-du)
13. [Установка и использование утилиты ncdu](#part-13-установка-и-использование-утилиты-ncdu)
14. [Работа с системными журналами](#part-14-работа-с-системными-журналами)
15. [Использование планировщика CRON](#part-15-использование-планировщика-заданий-CRON)

## Part 1. Установка OS
#### 1.1. Part 1. Установка Ubuntu 20.04 Server LTS без графической оболочки:
![linux](/src/images/part_1.png](https://github.com/Demzez/Linux/blob/main/D01_Linux-0-develop-src/src/images/filtersshd.png "Подсказка")

## Part 2. Создание пользователя
#### 2.1. Part 2. Создание пользователя и чтение логов через var_log
     $sudo useradd -G adm -s /bin/bash -m user_1
     $sudo passwd user_1 -> Задаем пароль юзеру
![user_1](/src/images/part_2.png "Подсказка")

## Part 3. Настройка сети OS
#### 3.1. Изменение имени пользователя на user-1:
     $ sudo nano /etc/hostname -> переписывает хост-имя
     $ sudo nano /etc/hosts -> переписывает хост-файл
     $ sudo reboot -> перезагружает систему
     $ hostname -> проверка нового имени
#### 3.2. Установка временной зоны:
     $ timedatectl -> просмотр установленной временной зоны
     $ ls -l /etc/localtime -> или проверить временную зону из файла
     $ cat /etc/timezone -> этот файл также содержит инфу о временной зоне
     $ timedatectl list-timezones -> просмотр листа со всеми временными зонами
     $ sudo timedatectl set-timezone Europe/Moscow -> установка новой временной зоны
![Europe/Moscow](/src/images/timezone.png "Europe/Moscow")
#### 3.3. Вывод названия сетевых интерфейсов с помощью консольной команды:
     $ ip link -> все названия (не показывает IP адрес)
     $ ip a -> показывает имена сетевых интерфейсов и IP адреса
     lo (loopback inerface) локальный интерфейс, созданный операционной системой. Только компьютер может увидеть этот интерфейс.
#### 3.4. Использование консольной команды для получения IP адреса устройства:
     $ ip r -> показывает динамический IP адрес через DHCP
     DHCP - Dynamic Host Configuraion protocol. Протокол используемый для назначения IP-адреса клиенту.
#### 3.5. Внешний ip-адрес шлюза (IP) и внутренний IP-адрес шлюза, он же IP-адрес по умолчанию (gw):
     $ ip route, & ip route | grep default -> внутренний IP адрес;
     $ ip addr
#### 3.6. Установка статического IP, gw, dns настройки и ping 8.8.8.8 + ya.ru:
     cat /etc/netplan/00-installer-config.yamlip show -> просмотр настроек сети
     $ ip route show match 0/0 -> проверка текущего адреса шлюза
     $ sudo addr add 10.0.2.16/24 broadcast 10.0.2.255 dev enp0s3 -> IP адрес, настройки трансляции
     $ sudo ip route add default via 10.0.2.2
     $ ping 8.8.8.8
![ping_8.8.8.8](/src/images/ping8888.png)
     $ ping ya.ru
![ping_ya](/src/images/ping_ya.png)

#### 3.7. Перезагрузка виртуальной машины. Статичные сетевые настройки (IP, gw, dns) соответствуют заданным в предыдущем пункте:


## Part 4. Обновление ОС
#### 4.1. Обновить системные пакеты до последней на момент выполнения задания версии:
     $ sudo apt-get update -> обновление информации о пакетах
     $ sudo apt-get upgrade -> обновление пакетов || также можно использовать $sudo apt-get dist-upgrade
![updating-os](/src/images/upgrade.png "Part 4.")
## Part 5. Использование команды sudo
#### 5.1. Разрешить пользователю, созданному в Part 2, выполнять команду sudo:
     Команда sudo предоставляет возможность пользователям выполнять команды от имени суперпользователя root
     $ sudo usermod -aG sudo user_1 -> дать права root user_1
     $ su - user_1 -> Смена на user_1
     $ sudo nano /etc/hostname 
     $ sudo nano /etc/hosts
     $ sudo reboot
     $ hostname
![change_hostname_from_user_1](/src/images/part_5.png)
## Part 6. Установка и настройка службы времени
#### 6.1. Настройка службы автоматической синхронизации времени:
     $ sudo apt-get install ntp -> установка пакетов
     $ sudo apt install systemd-timesyncd -> установка NTP
     $ sudo gedit /etc/ntp.conf: (Смена сервера синхронизации)
          server ru.pool.ntp.org
          server pool.ntp.org
          server time.nist.gov
          server ntp.psn.ru
          server ntp1.imvp.ru
     $ timedatectl set-ntp true -> активация NTP
     $ systemctl unmask systemd-timesyncd.service -> служба замаскирована, что означает, что она не может быть запущена -> исп. unmask
     $ sudo service ntp restart -> перезапуск сервиса
     $ timedatectl show
![synchronised-time](/src/images/part_61.png)
## Part 7. Установка и использование текстовых редакторов
#### 7.1. Написать свой никнейм в VIM, NANO, MCEDIT:
     ----NANO----
     $ sudo nano test_nano.txt
     $ ctrl + x -> y -> enter - сохранить изменения в файле при работе в NANO
     ----VIM----
     $ sudo vim test_vim.txt
     $ esc -> shift + : -> wq - сохранить изменения в файле при работе в VIM
     ----MCEDIT----
     $ sudo mcedit test_mcedit.txt
     $ esc or 'Fn' + 'F10' -> сохранить изменения в файле при работе в MCEDIT: yes
NANO
![nano](/src/images/part_71_nanofrancine.png)
VIM
![VIM](/src/images/part_71_vimfrancine.png)
MCEDIT
![MCEDIT](/src/images/part_71_mceditfrancine.png)
#### 7.2. Закрытие файла без сохранения изменений в VIM, NANO, MCEDIT:
     ----NANO----
     $ ctrl + x -> n -> enter - не сохранять изменения в файле при работе в NANO
     ----VIM----
     $ esc -> shift + : -> q! - не сохранять изменения в файле при работе в VIM
     ----MCEDIT----
     $ esc or 'Fn' + 'F10' -> не сохранять изменения в файле при работе в MCEDIT: No
NANO
![nano](/src/images/part_72_nano.png)
VIM
![VIM](/src/images/part_72_vim.png)
MCEDIT
![MCEDIT](/src/images/part_72_mcedit.png)
#### 7.3. Отредактировать файл ещё раз (по аналогии с предыдущим пунктом, а затем освоить функции поиска по содержимому файла (слово) и замены слова на любое другое:
----NANO---- \
$ sudo nano test_nano.txt -> открыть и изменить на "21 school 21" \
$ В nano 'ctrl' + 'W' -> поиск слова \
![search_nano](/src/images/part_73_nano_search.png) \
В nano зажать 'ctrl' + '\' и написать '21' для поиска и нажать 'Enter'
Далее ввести слово для замены, нажать 'A' для всех слов \
![replace_nano_1](/src/images/part_73_nano_replaced.png)
----VIM---- \
$ sudo vim test_vim.txt -> открыть и изменить на "21 school 21" \
$ В vim зажать 'shift' + ':' и написать /21 и нажать 'Enter' -> поиск слова. Нажатие 'n' переводит на след. слово \
![search_vim](/src/images/part_73_vim_search.png) \
$ В vim нажать 'shift' + ':' и написать %s/21/69/g и нажать 'Enter' -> поиск и замена \
  % -> диапазон от первой до последней строки файла \
  g -> заменить все вхождения шаблона поиска в текущей строке \
![search_replace_vim](/src/images/part_73_vim_replace.png) \
----MCEDIT---- \
$ sudo mcedit test_mcedit.txt -> открыть и изменить на "21 school 21" \
Поиск -> 'Fn' + 'F7' \
![search_mcedut](/src/images/part_73_mcedit_search.png)
Замена -> 'Fn' + 'F4' -> написать слово для поиска и слово для замены, затем нажать 'Enter' \
![search_replace_mcedut](src/images/part_73_mcedit_rep.png)
## Part 8. Установка и базовая настройка сервиса SSHD
#### 8.1. Установка службы SSHD:
     $ sudo apt update
     $ sudo apt install openssh-server
     $ sudo systemctl status ssh -> проверка работы SSH
![openssh-server](/src/images/part_81.png)
#### 8.2. Добавить автостарт службы при загрузке системы:
     $ sudo systemctl enabale ssh
     $ ssh localhost -> проверка работоспособности утилиты
#### 8.3. Перенастроить службу SSHd на порт 2022:
     $ sudo nano /etc/ssh/sshd_config -> установка настроек в файле конфигурации
![port_2022](/src/images/part_83.png)
#### 8.4. Показать наличие процесса sshd используя команду ps:
     $ sudo systemctl status ssh -> поиск PID (идентификатор процесса)
     $ ps -p 1953 -> если PID процесса известен можно записать его, используя флаг -p
![process](/src/images/part_84.png)
#### 8.5. Перезагрузка системы и использование netstat -tan:
     $ sudo reboot -> перезагрузка системы
     $ sudo apt install net-tools -> установка net-tools
     $ netstat -tan -> мониторинг сетей TCP / IP, который может отображать таблицы маршрутизации, фактические сетевые подключения и информацию о состоянии каждого устройства сетевого интерфейса.
       -t -> Состояние соединения по протоколу передачи;
       -a -> показать все соединения;
       -n -> использовать IP-адрес напрямую, а не через сервер доменных имен.
     Значение каждого столбца
          Proto: протокол, используемый сокетом
          Recv-Q: количество байтов, не скопированных пользовательской программой, подключенной к этому сокету.
          Send-Q: количество неподтвержденных байтов удаленного хоста
          Локальный адрес: локальный адрес (имя локального хоста) и номер порта сокета. 
          Внешний адрес: удаленный адрес (имя удаленного хоста) и номер порта сокета.
          State: состояние сокета.
     Форма «0.0.0.0» — это стандартный способ сказать «нет конкретного адреса», все адреса IPv4 на локальном компьютере.
![netstat.png](/src/images/part_85.png)
## Part 9. Установка и использование утилит top, htop
#### 9.1. По выводу команды top определить и записать в отчет:
     $ sudo apt-get update
     $ sudo apt-get install top
     $ sudo apt-get install htop
     $ top -> run top
     uptime -> 21:50:44 up 35 min
     number of authorised users -> 1 user
     total system load -> load average: 0.01, 0.01, 0.00
     total number of processes -> Tasks: 100 total
     cpu load -> 100 - id = 100 - 99.7 = 0.3 %
     memory load -> 1983.4 + 1739.0 = 3776.4
     pid of the process with the highest memory usage -> PID = 675 Определили по %MEM
     pid of the process taking the most CPU time -> PID = 1882 Определили по TIME+
#### 9.2. В отчёт вставить скрин с выводом команды htop:
Sort_pid
![sort-pid](/src/images/sortpid.png)
Sort_percent_cpu
![sort-cpu](/src/images/sortcpu.png)
Sort_percent_mem
![sort_mem](/src/images/sortmem.png)
Sort_time
![sort_time](/src/images/sorttime.png)
Filter_process_sshd
![filter_process_sshd](/src/images/filtersshd.png)
Search syslog process
![Search_syslog](/src/images/syslog1.png)
Add_infor_bar
![info_bar](/src/images/inforbar.png)
## Part 10. Использование утилиты fdisk
#### 10.1. Запустить команду fdisk -l:
     $ sudo fdisk -l | less
       name: /dev/sda;
       capacity: 10 GiB;
       number of sectors: 20971520.
## Part 11. Использование утилиты df
     $ df
       partition size: 9336140 kilobytes
       space used: 4506916 kilobytes
       space free: 4335248 kilobytes
       percentage used: 51df -%
     $ df -Th
       partition size: 9.0 Gigabyte
       space used: 4.3 Gigabyte
       space free: 4.2 Gigabyte
       percentage used: 51%
       Type: ext4
## Part 12. Использование утилиты du
$ sudo du -shb /home /var/log /var

![sudo du /home /var/log /var](/src/images/part121.png)

$ sudo du -sh /home /var/log /var

![sudo du /home /var/log /var](/src/images/part122.png)

$ sudo du /var/log/*

![human readable sizes](/src/images/part123.png)

## Part 13. Установка и использование утилиты ncdu
     $ sudo apt-get update
     $ sudo apt-get install ncdu
$ sudo ncdu /home \
![sudo ncdu /home](/src/images/part_13home.png)
$ sudo ncdu /var \
![sudo ncdu /var](/src/images/part_13var.png)
$ sudo du /var/log \
![sudo ncdu /var/log](/src/images/part_13varlog.png)

## Part 14. Работа с системными журналами
     $ sudo cat /var/log/auth.log | less
       the last successful login time: Jun 16 16:02:22;
       user name: bastion;
       login method: as root (uid = 0);
     $ sudo service sshd restart -> Restart SSHd service
     $ sudo cat /var/log/syslog | less - > check last history
![syslog_sshd](/src/images/part_14restart.png)

## Part 15. Использование планировщика заданий CRON
#### 15.1. Запустить команду uptime через каждые 2 минуты:
$ sudo crontab -e -> write order when start service \
![crontab_uptime](/src/images/part_152.png) \
$ sudo crontab -r -> remove tasks \
$ sudo crontab -l -> show lists of tasks \
![crontab_show_tasks](/src/images/final.png)
