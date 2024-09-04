#before
netsh int ipv4 show dynamicport tcp

#set port range
netsh int ipv4 set dynamicport tcp start=1025 num=64511

#after
netsh int ipv4 show dynamicport tcp