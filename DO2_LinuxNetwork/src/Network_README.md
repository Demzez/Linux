## Part 1. Инструмент ipcalc

### 1.1. Сети и маски

Определить и записать в отчет:

- Адрес сети 
    - 192.167.38.54/13
        - 192.160.0.0

- Перевод маски:
    - 255.255.255.0
        - префиксная запись: /24
        - двоичная запись: 11111111.11111111.11111111.00000000
    - /15
        - обычная запись: 255.254.0.0
        - двоичная запись: 11111111.11111111.00000000.00000000
    - 11111111.11111111.11111111.11110000
        - обычная запись: 255.255.255.240
        - префиксная запись: /28

- Минимальный и максимальный хост в сети 12.167.38.4 при масках:
    - /8 : 12.0.0.1 - 12.255.255.254
    - 11111111.11111111.00000000.00000000 : 12.167.0.1 - 12.167.255.254
    - 255.255.254.0 : 12.167.38.1 - 12.167.39.254
    - /4 : 0.0.0.1 - 15.255.255.254

### 1.2. localhost

Определить и записать в отчёт, можно ли обратиться к приложению, работающему на localhost, со следующими IP:

- 194.34.23.100 - нет
- 127.0.0.2 - да
- 127.1.0.1 - да
- 128.0.0.1 - нет

### 1.3. Диапазоны и сегменты сетей

Определить и записать в отчёт:

- Какие из перечисленных ip можно использовать в качестве публичных, а какие в качестве частных:
    - 10.0.0.45 - приватный
    - 134.43.0.2 - публичный
    - 192.168.4.2 - приватный
    - 172.20.250.4 - приватный
    - 172.0.2.1 - публичный
    - 192.172.0.1 - публичный
    - 172.68.0.2 - публичный
    - 172.16.255.255 - приватный
    - 10.10.10.10 - приватный
    - 192.169.168.1 - публичный

- Какие из перечисленных IP адресов шлюза возможны у сети 10.10.0.0/18:
    - 10.0.0.1 - нет
    - 10.10.0.2 - да
    - 10.10.10.10 - да
    - 10.10.100.1 - нет
    - 10.10.1.255 - нет

## Part 2. Статическая маршрутизация между двумя машинами

С помощью команды ip a посмотреть посмотреть сущшествующие сетевые интерфейсы

![linux_network](/DO2_LinuxNetwork/src/scrn/ipa1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/ipa2.png)

Описать сетевой интерфейс, соответствующий внутренней сети, на обеих машинах и задать следующие адреса и маски: ws1 - 192.168.100.10, маска /16, ws2 - 172.24.116.8, маска /12

![linux_network](/DO2_LinuxNetwork/src/scrn/netplan1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/netplan2.png)

Выполнить команду netplan apply для перезапуска сервиса сети

![linux_network](/DO2_LinuxNetwork/src/scrn/apply1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/apply2.png)

### 2.1. Добавление статического маршрута вручную

Добавить статический маршрут от одной машины до другой и обратно при помощи команды вида ip r add.
Пропинговать соединение между машинами.

![linux_network](/DO2_LinuxNetwork/src/scrn/ipr1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/ipr2.png)

### 2.2. Добавление статического маршрута с сохранением

Добавить статический маршрут от одной машины до другой с помощью файла etc/netplan/00-installer-config.yaml

![linux_network](/DO2_LinuxNetwork/src/scrn/netplan3.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/netplan4.png)

Пропинговать соединение между машинами

![linux_network](/DO2_LinuxNetwork/src/scrn/ping1_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/ping1_2.png)

## Part 3. Утилита iperf3

### 3.1. Скорость соединения

Перевести и записать в отчёт:
- 8 Mbps в MB/s : 1 MB/s
- 100 MB/s в Kbps : 819200 Kbps
- 1 Gbps в Mbps : 1024 Mbps

### 3.2. Утилита iperf3

![linux_network](/DO2_LinuxNetwork/src/scrn/iperf3_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/iperf3_2.png)

## Part 4. Сетевой экран

### 4.1. Утилита iptables 

Создать файл /etc/firewall.sh, имитирующий фаерволл

- на ws1 применить стратегию когда в начале пишется запрещающее правило, а в конце пишется разрешающее правило (это касается пунктов 4 и 5)
- на ws2 применить стратегию когда в начале пишется разрешающее правило, а в конце пишется запрещающее правило (это касается пунктов 4 и 5)
- открыть на машинах доступ для порта 22 (ssh) и порта 80 (http)
- запретить *echo reply* (машина не должна "пинговаться”, т.е. должна быть блокировка на OUTPUT)
- разрешить *echo reply* (машина должна "пинговаться")

![linux_network](/DO2_LinuxNetwork/src/scrn/iptables_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/iptables_2.png)

Запустить файлы на обеих машинах командами chmod +x /etc/firewall.sh и /etc/firewall.sh

![linux_network](/DO2_LinuxNetwork/src/scrn/chmod_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/chmod_2.png)

- Разница в том, что если запрещающее правило стоит первым, то следующее разврешающее правило не будет работать

### 4.2. Утилита nmap

Nmap (“Network Mapper”) это утилита с открытым исходным кодом для исследования сети и
       проверки безопасности. Она была разработана для быстрого сканирования больших сетей, хотя
       прекрасно справляется и с единичными целями. Nmap использует сырые IP пакеты оригинальными
       способами, чтобы определить какие хосты доступны в сети, какие службы (название приложения
       и версию) они предлагают, какие операционные системы (и версии ОС) они используют, какие
       типы пакетных фильтров/брандмауэров используются и еще дюжины других характеристик. В тот
       время как Nmap обычно используется для проверки безопасности, многие сетевые и системные
       администраторы находят ее полезной для обычных задач, таких как контролирование структуры
       сети, управление расписаниями запуска служб и учет времени работы хоста или службы.

![linux_network](/DO2_LinuxNetwork/src/scrn/ping2_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/ping2_2.png)

## Part 5. Статическая маршрутизация сети

![linux_network](/DO2_LinuxNetwork/src/scrn/part5_network.png)

### 5.1. Настройка адресов машин

- w11
![linux_network](/DO2_LinuxNetwork/src/scrn/netplan5.png)
- w21
![linux_network](/DO2_LinuxNetwork/src/scrn/netplan6.png)
- w22
![linux_network](/DO2_LinuxNetwork/src/scrn/netplan7.png)
- r2
![linux_network](/DO2_LinuxNetwork/src/scrn/netplan8.png)
- r1
![linux_network](/DO2_LinuxNetwork/src/scrn/netplan9.png)

Команда netplan apply проверит наш конфиг на наличие ошибок и применит его в случае успеха. Если ошибок нет, то командой `ip -4 a` (IPv4) проверить, что адрес машины задан верно.
![linux_network](/DO2_LinuxNetwork/src/scrn/n_apply_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/n_apply_2.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/n_apply_3.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/n_apply_4.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/n_apply_5.png)

Пропинговать ws22 с ws21 и r1 с ws11.
![linux_network](/DO2_LinuxNetwork/src/scrn/ping_3_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/ping_3_2.png)

### 5.2. Включение переадресации IP-адресов.

Для включения переадресации IP, выполнить команду на роутерах:
`sysctl -w net.ipv4.ip_forward=1` 
![linux_network](/DO2_LinuxNetwork/src/scrn/sysctl_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/sysctl_2.png)

IP-переадресация включена на постоянной основе.
![linux_network](/DO2_LinuxNetwork/src/scrn/ipforward_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/ipforward_2.png)

### 5.3. Установка маршрута по-умолчанию

Настроить маршрут по-умолчанию (шлюз) для рабочих станций. Для этого добавить gateway4 ip роутера в файле конфигураций.

- w11
![linux_network](/DO2_LinuxNetwork/src/scrn/netplan10.png)
- w21
![linux_network](/DO2_LinuxNetwork/src/scrn/netplan11.png)
- w22
![linux_network](/DO2_LinuxNetwork/src/scrn/netplan12.png)

Вызвать `ip r` и показать, что добавился маршрут в таблицу маршрутизации.
![linux_network](/DO2_LinuxNetwork/src/scrn/appl1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/appl2.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/appl3.png)

Пропинговать с ws11 роутер r2 и показать на r2, что пинг доходит. Для этого использовать команду:
`tcpdump -tn -i eth1`
![linux_network](/DO2_LinuxNetwork/src/scrn/ping_4_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/ping_4_2.png)

### 5.4. Добавление статических маршрутов

Добавить в роутеры r1 и r2 статические маршруты в файле конфигураций.
![linux_network](/DO2_LinuxNetwork/src/scrn/netplan13.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/netplan14.png)

Вызвать `ip r` и показать таблицы с маршрутами на обоих роутерах.
![linux_network](/DO2_LinuxNetwork/src/scrn/iprr_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/iprr_2.png)

Запустить команды на ws11:
`ip r list 10.10.0.0/[маска сети]` и `ip r list 0.0.0.0/0`
![linux_network](/DO2_LinuxNetwork/src/scrn/iprl_1.png)

Маршрут подбирается по таблице марштрутизаторов. Если маршрут выбран успешно то он будет передан. Если не успешно - пакет не будет передан. Если несколько совпадений - то для переадсресации будет выбран маршрут с самой длинной маской.

### 5.5. Построение списка маршрутизаторов

Запустить на r1 команду дампа:
`tcpdump -tnv -i eth0`
![linux_network](/DO2_LinuxNetwork/src/scrn/tcpdump_1.png)

При помощи утилиты **traceroute** построить список маршрутизаторов на пути от ws11 до ws21
![linux_network](/DO2_LinuxNetwork/src/scrn/traceroute_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/icml.png)

Каждый пакет проходит на своем пути определенное количество узлов, пока достигнет своей цели. Причем, каждый пакет имеет свое время жизни. Это количество узлов, которые может пройти пакет перед тем, как он будет уничтожен. Этот параметр записывается в заголовке TTL, каждый маршрутизатор, через который будет проходить пакет уменьшает его на единицу. При TTL=0 пакет уничтожается, а отправителю отсылается сообщение Time Exceeded.

Команда traceroute linux использует UDP пакеты. Она отправляет пакет с TTL=1 и смотрит адрес ответившего узла, дальше TTL=2, TTL=3 и так пока не достигнет цели. Каждый раз отправляется по три пакета и для каждого из них измеряется время прохождения. Пакет отправляется на случайный порт, который, скорее всего, не занят. Когда утилита traceroute получает сообщение от целевого узла о том, что порт недоступен трассировка считается завершенной.

### 5.6. Использование протокола ICMP при маршрутизации

Запустить на r1 перехват сетевого трафика, проходящего через eth0 с помощью команды:
`tcpdump -n -i eth0 icmp`
![linux_network](/DO2_LinuxNetwork/src/scrn/ping_5_1.png)
Пропинговать с ws11 несуществующий IP с помощью команды `ping`
![linux_network](/DO2_LinuxNetwork/src/scrn/ping_5_2.png)

## Part 6. Динамическая настройка IP с помощью DHCP

Для r2 настроить в файле */etc/dhcp/dhcpd.conf* конфигурацию службы **DHCP**. Указать адрес маршрутизатора по-умолчанию, DNS-сервер и адрес внутренней сети.
![linux_network](/DO2_LinuxNetwork/src/scrn/dhcp1_1.png)
В файле *resolv.conf* прописать `nameserver 8.8.8.8.`
![linux_network](/DO2_LinuxNetwork/src/scrn/resolv1_1.png)
Перезагрузить службу **DHCP** командой `systemctl restart isc-dhcp-server`.
![linux_network](/DO2_LinuxNetwork/src/scrn/sysctl_3.png)
Машину ws21 перезагрузить при помощи `reboot` и через `ip a` показать, что она получила адрес. Также пропинговать ws22 с ws21.
![linux_network](/DO2_LinuxNetwork/src/scrn/ipaa.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/ping6_1.png)

Указать MAC адрес у ws11, для этого в *etc/netplan/00-installer-config.yaml* надо добавить строки: `macaddress: 10:10:10:10:10:BA`, `dhcp4: true`
![linux_network](/DO2_LinuxNetwork/src/scrn/ntplan_1.png)
Для r1 настроить аналогично r2, но сделать выдачу адресов с жесткой привязкой к MAC-адресу (ws11). Провести аналогичные тесты

![linux_network](/DO2_LinuxNetwork/src/scrn/dhcp2_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/range1_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/name1_1.png)
ip до обновления и после.
![linux_network](/DO2_LinuxNetwork/src/scrn/ipaa1_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/ipaa1_2.png)

Запросить с ws21 обновление ip адреса
![linux_network](/DO2_LinuxNetwork/src/scrn/ipaa2_1.png)
Пинг с обновленным ip у машины ws21
![linux_network](/DO2_LinuxNetwork/src/scrn/ping7_1.png)

## Part 7. **NAT**

В файле /etc/apache2/ports.conf на ws22 и r1 изменить строку Listen 80 на Listen 0.0.0.0:80, то есть сделать сервер Apache2 общедоступным.
Запустить веб-сервер Apache командой service apache2 start на ws22 и r1.

![linux_network](/DO2_LinuxNetwork/src/scrn/ports1_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/ports1_2.png)

Добавить в фаервол, на r2 следующие правила:
- Удаление правил в таблице filter - iptables -F
- Удаление правил в таблице "NAT" - iptables -F -t nat
- Отбрасывать все маршрутизируемые пакеты - iptables --policy FORWARD DROP

![linux_network](/DO2_LinuxNetwork/src/scrn/iptables2_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/chmod2_1.png)

Проверить соединение между ws22 и r1 командой `ping`

![linux_network](/DO2_LinuxNetwork/src/scrn/ping8_1.png)

Добавить в файл ещё одно правило:
- Разрешить маршрутизацию всех пакетов протокола **ICMP**
![linux_network](/DO2_LinuxNetwork/src/scrn/chmod3_1.png)

Проверить соединение между ws22 и r1 командой `ping`
![linux_network](/DO2_LinuxNetwork/src/scrn/ping9_1.png)

Добавить в файл ещё два правила:
- Включить **SNAT**, а именно маскирование всех локальных ip из локальной сети, находящейся за r2 (по обозначениям из Части 5 - сеть 10.20.0.0)
- Включить **DNAT** на 8080 порт машины r2 и добавить к веб-серверу Apache, запущенному на ws22, доступ извне сети
![linux_network](/DO2_LinuxNetwork/src/scrn/frwall1_1.png)

Проверить соединение по TCP для **SNAT**, для этого с ws22 подключиться к серверу Apache на r1.
![linux_network](/DO2_LinuxNetwork/src/scrn/telnet1_1.png)
Проверить соединение по TCP для **DNAT**, для этого с r1 подключиться к серверу Apache на ws22 командой `telnet` 
![linux_network](/DO2_LinuxNetwork/src/scrn/telnet1_2.png)

## Part 8. Дополнительно. Знакомство с **SSH Tunnels**

Запустить веб-сервер **Apache** на ws22 только на localhost (то есть в файле */etc/apache2/ports.conf* изменить строку `Listen 80` на `Listen localhost:80`)
![linux_network](/DO2_LinuxNetwork/src/scrn/ports3_1.png)

Воспользоваться *Local TCP forwarding* с ws21 до ws22, чтобы получить доступ к веб-серверу на ws22 с ws21
Воспользоваться *Remote TCP forwarding* c ws11 до ws22, чтобы получить доступ к веб-серверу на ws22 с ws11

![linux_network](/DO2_LinuxNetwork/src/scrn/lhost1_1.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/lhost1_2.png)


![linux_network](/DO2_LinuxNetwork/src/scrn/lhost1_3.png)
![linux_network](/DO2_LinuxNetwork/src/scrn/lhost1_4.png)
