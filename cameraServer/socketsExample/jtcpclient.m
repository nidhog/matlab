format long;

port = 13931;
host = 'Ecco'; %Best to use the machine's hostname, but IP address works too.

jtcpobj = jtcp('REQUEST',host,port,'SERIALIZE',false);

pause(0.1);

%send server a message
serverMessage = [];
clientTime=clock;

jtcp('WRITE', jtcpobj,double('OWLSOWLSOWLS'));
%disp('wrote message');

%receive a message response back from server
while(true)
    %Read will block forever and you'll have to force-quit Matlab to make
    %it stop, so only read if you're sure you have bytes there!
    if jtcpobj.socketInputStream.available > 0
        serverMessage = jtcp('READ',jtcpobj);
        break;
    end
end

clientTime2=clock;
disp(['Server message was: ' serverMessage]);

disp(['Round-trip time: ' num2str(etime(clientTime2,clientTime))]);

pause(0.2);
jtcp('close', jtcpobj);