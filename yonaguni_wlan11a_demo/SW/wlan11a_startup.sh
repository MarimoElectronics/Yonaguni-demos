#!/bin/bash
############################################################
# IP address
############################################################
D_IP1="192.168.1.229"
############################################################
# check ADRV9002 driver testing/API
############################################################
DIR="/sys/bus/iio/devices/iio:device0"
if [ ! -d $DIR ]; then
  echo "system reboot. directory iio:device0(adrv9002) is not exist."
  reboot
fi
############################################################
# execute WLAN11a demo program
############################################################
sleep 1
s="/home/analog/yonaguni_wlan11a_demo/SW/01_TRX/TEST_PRG $D_IP1"
$s

############################################################
# shut down
############################################################
# LED off
for gpio_number in 2016 2017 2018 2019
do
  echo "${gpio_number}" > /sys/class/gpio/export
  echo "out" > /sys/class/gpio/gpio${gpio_number}/direction
  echo "1" > /sys/class/gpio/gpio${gpio_number}/value
  echo "${gpio_number}" > /sys/class/gpio/unexport
done
echo "system shut down."
#shutdown -h now
