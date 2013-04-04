These files demonstrate TCP/IP communications (sockets) in Matlab and Python. 

Matlab-Matlab communication:
(1) Run "jtcpserver.m" in Matlab
(2) Run "jtcpclient.m" in another copy of Matlab
The two Matlabs are assumed to be on the same machine. 
Change the IP / hostname in jtcpclient if you want to test communications between two machines.

Matlab-Python communication:
(1) Run "jtcpserver.m" in Matlab
(2) Run "socketTest.py" in PsychoPy (or Python, if you take out the PsychoPy-specific clock part)
Both are assumed to be on the same machine. 
Change the IP / hostname in socketTest.py if you want to test communications between two machines.
