#!/bin/sh
cd /sys/bus/iio/devices

#----------------------------------------
#----- DEVICE0 -> adrv9002-phy
#----- Note: Retry until "profile_config" is successfully.
cd iio:device0
until
 cat /home/analog/yonaguni_wlan11a_demo/SW/90_json/Yonaguni_custom_40_lvds_trx_coe_api.json > profile_config
do sleep 1;done
#----- RX_LO & TX_LO
 echo 5713920000 > out_altvoltage0_RX1_LO_frequency
 echo 5713920000 > out_altvoltage1_RX2_LO_frequency
 echo 5713920000 > out_altvoltage2_TX1_LO_frequency
 echo 5713920000 > out_altvoltage3_TX2_LO_frequency
#-----
