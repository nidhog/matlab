import socket, time
from psychopy import core

#example PsychoPy script for communicating with a TCP/IP server 
#(e.g. the camera acquisition server in Matlab.)

#connects to server, sends a message, and gets one back. Prints the round-trip time for the communication.
#Typically this should be around 2 milliseconds. One-way communications are faster, more like 10 microseconds.

#Note that the first message exchange on a new connection is often much slower than subsequent messages.
#This is a property of all TCP/IP connections.

host = '127.0.0.1'
port = 13931
BUFFER_SIZE = 1024
message = "OWLSOWLSOWLS"
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((host, port))
clock = core.Clock();
s.send("hi there\n")
data = s.recv(BUFFER_SIZE)
t = clock.getTime()
print "Round-trip time: ", t
s.close()
print "received data:", data