# How-to: Wireless LAN IEEE802.11a demonstration

- [How-to: Wireless LAN IEEE802.11a demonstration](#how-to-wireless-lan-ieee80211a-demonstration)
  - [1. Overview of this demonstration](#1-overview-of-this-demonstration)
  - [2. Build of demonstration design](#2-build-of-demonstration-design)
  - [3. Hardware setup](#3-hardware-setup)
  - [4. Software setup](#4-software-setup)
  - [5. Running the demonstration](#5-running-the-demonstration)
  - [6. Conclusion](#6-conclusion)

## 1. Overview of this demonstration
In this demonstration, the ADRV9002 RF-SoM is used to transmit and receive IEEE802.11a signals.The UDP packets are modulated by the IEEE802.11a PHY implemented in the RF-SoM's SoC and transmitted via Wireless LAN radio waves.Thses are then received back over the wire, demodulated by the IEEE802.11a PHY, and converted back into the UDP packets.
In this demonstration, only three lines of text code are sent and received via radio signals.
![Demo Picture1](./img/wlan11a_demo_image.png)

## 2. Build of demonstration design
Clone Yonaguni-demo and Yonaguni-FPGA. Then copy the Yonaguni-FPGA/hdl directory to yonaguni_wlan11a_demo/ip.

```Shell
$ git clone https://github.com/MarimoElectronics/Yonaguni-demo.git
$ git clone https://github.com/MarimoElectronics/Yonaguni-FPGA.git
$ cp -r ./Yonaguni-FPGA/hdl ./Yonaguni-demo/yonaguni_wlan11a_demo/ip/
```

Build the demonstration design using Quartus Prime.
  - Use Quartus Prime Lite Edition 20.1.1.
  - Launch Quartus and select the project file "yonaguni_lvds.qpf" in the yonaguni_wlan11a_demo directory.
  - On Quartus, launch "Platform Designer" and select "system_bd.qsys".
  - In Platform Designer, run "Generate > Generate HDL...".
  - Run "Start Compilation" on Quartus.
  - Write "yonaguni_lvss.rbf", which is created in the "output_files" folder, to the BOOT partition of the SD card.
  - Change the file name to "yonaguni_cmos.rbf".


## 3. Hardware setup
Connect the RF-SoM to the PC.
  - Connect the PC and RF-SoM with an Ethernet cable and a USB UART cable.
  - Connect the RF-SoM's TX1_OUT (CN2) and RX1A_IN (CN6) with an SMA cable.
![Demo Picture2](./img/wlan11a_demo_HWsetup.png)

Set the PC's IP address to 192.168.1.229. (If necessary, turn off the firewall on your PC.)

Power on the RF-SoM and set the IP address of the RF-SoM from USB UART Terminal. (If necessary, turn off DHCP on the RF-SoM.)
```Shell
root@analog:~ $ ifconfig eth0 192.168.1.228
```


## 4. Software setup
Login to RF-SoM via SSH. The login password is "analog".

Create the yonaguni_wlan11a_demo directory under /home/analog.

Copy the cloned Yonaguni-demo/yonaguni_wlan11a_demo/SW directory into the yonaguni_wlan11a_demo directory of the RF-SoM.

Go to yonaguni_wlan11a_demo/SW/01_TRX and run make to generate TEST_PRG.
```Shell
analog@analog:~/yoneguni_wlan11a_demo/SW/01_TRX $ make
gcc -c main.c -Wall
gcc main.o  -Wall -o TEST_PRG
analog@analog:~/yoneguni_wlan11a_demo/SW/01_TRX $
```

## 5. Running the demonstration
Launch a startup script on the USB UART Terminal.
```Shell
root@analog:~ $ sh /home/analog/yonaguni_wlan11a_demo/SW/wlan11a_startup.sh
----------------------------------------------------------------------
------ WLAN11a transmit and receive program. ------
INFO-> Setup FPGA interface... finished.
INFO-> Initialize RF wideband transceiver(ADRV9002)... finished.
INFO-> Source IP address is 192.168.1.229
INFO-> ready...
```

If an error occurs during startup, before the "ready..." screen appears, a "cat: error messge" will appear and the program will automatically retry.
After a while, the USERLED 3 on the RF-SoM will flash blue after it boots successfully.

Next, on your PC, run UDP_receive.py in the cloned Yonaguni-demo/yonaguni_wlan11a_demo/python directory.
In this state, the PC waits for UDP packets received and demodulated via IEEE802.11a.
Then, run UDP_send.py.
When IEEE802.11a transmission occurs, USERLED 0 on the RF-SoM lights up blue, and when reception occurs, USERLED 1 lights up blue.
```Shell
c:\work\yonaguni_wlan11a_demo\Python> .\UDP_receive.py
c:\work\yonaguni_wlan11a_demo\Python> .\UDP_send.py
```

The received text looks like this:
```Shell
hello RF-SOM0
hello RF-SOM1
hello RF-SOM2
```

Enter ^C on the USB UART Terminal to end the script.


## 6. Conclusion
In this demonstration, UDP packets were converted into wireless signals and transmitted/received using the IEEE802.11a PHY implemented in the ADRV9002 RF-SoM.
By applying this technology, it is possible to send and receive image data by compressing images from a USB camera, turning them into UDP packets, and sending them over the air, then demodulating and expanding them on the receiving side.
![Demo Picture3](./img/wlan11a_demo_TRXvideo.png)
