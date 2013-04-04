port = 13931; %arbitrarily chosen port number, usually anything > 10000 is good 
%13931 is especially good because it is a palindromic prime! And that's coooool.

disp('waiting for client to connect...')
jtcpobj = jtcp('ACCEPT',port,'TIMEOUT',30000,'serialize',false);
%when this starts, the client has 30 seconds to make
%a connection before the timeout happens

disp('waiting for message from client');

%receive a message from client
clientMessage = [];
while(true)
    %Read will block forever and you'll have to force-quit Matlab to make
    %it stop, so only read if you're sure you have bytes there!
    if jtcpobj.socketInputStream.available > 0
        clientMessage = jtcp('READ',jtcpobj);
        break;
    end
end
disp(['client message: ' clientMessage]);

%send a message back
%messages need to be sent as ASCII codes. Use double("string here") to do this.
jtcp('WRITE', jtcpobj, double('OWLSOWLSOWLS\n'));

%don't close the connection until the client
%has a chance to read the messages
pause(1);
%now we can close it
jtcp('close', jtcpobj);