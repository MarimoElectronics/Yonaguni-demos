from socket import socket, AF_INET, SOCK_DGRAM

# Define IP address and port number
# Note: The IP address and port number should be set for RF-SOM.
IPADDR = "192.168.1.228"
HOST = ''
PORT = 25000

# Receive UDP message
sock_sv = socket(AF_INET, SOCK_DGRAM)
sock_sv.bind((HOST, PORT))
while True:
    data,address = sock_sv.recvfrom(2048)
    print(data.decode("utf-8"))

sock_sv.close()
