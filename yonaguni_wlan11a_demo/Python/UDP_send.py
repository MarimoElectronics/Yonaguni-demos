from socket import socket, AF_INET, SOCK_DGRAM
import time

# Define IP address and port number
# Note: The IP address and port number should be set for RF-SOM.
IPADDR = "192.168.1.228"
PORT = 25000

# Send UDP message
sock = socket(AF_INET, SOCK_DGRAM)
for num in range(3):
    s = "hello RF-SOM" + str(num)
    sock.sendto(s.encode("utf-8"), (IPADDR, PORT))
    time.sleep(1)

sock.close()
