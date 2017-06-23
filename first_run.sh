#!/bin/sh

# Set timezone & locale vars
VNAME="${VPN_NAME:-roxxorvpn}"
VEX_NYC="${EXTERNAL_NIC_NAME:-roxxorexnic}" 
VEX_NYC_ADRESS="${EXTERNAL_NIC_ADDRESS_NAME:-roxxorexnic_public_IP}"
VPUB_IP="${PUBLIC_IP_RANGE:-10.0.0.1/32}" 
VPN_PUB_ADDRESS=$(ipcalc $VPUB_IP | grep Address | awk '{print $2}')
VPN_PUB_NETMASK=$(ipcalc $VPUB_IP | grep Netmask | awk '{print $2}')
VINTERFACE="${VPN_INTERFACE:-tun0}"

export LANG

if [ -f /.first_run ]; then
        exit 0
fi

# Create directory structure
mkdir -p /etc/tinc/$VNAME/hosts

# Configure externalnyc
echo -e "Name = $VEX_NYC" > /etc/tinc/$VNAME/tinc.conf
echo -e "AddressFamily = ipv4" >> /etc/tinc/$VNAME/tinc.conf
echo -e "Interface = $VINTERFACE" >> /etc/tinc/$VNAME/tinc.conf

# Create an externalnyc hosts configuration file
echo -e "Address = $VEX_NYC_ADRESS" > /etc/tinc/$VNAME/hosts/$VEX_NYC
echo -e "Subnet = $VPUB_IP" >> /etc/tinc/$VNAME/hosts/$VEX_NYC

# Generate the public/private keypair for this host
tincd -n $VNAME -K4096

	# Create the script that will run whenever our netname VPN is started
echo -e "#!/bin/sh" > /etc/tinc/$VNAME/tinc-up
echo -e "ifconfig $VINTERFACE $VPN_PUB_ADDRESS netmask $VPN_PUB_NETMASK" >> /etc/tinc/$VNAME/tinc-up

echo -e "#!/bin/sh" > /etc/tinc/$VNAME/tinc-down
echo -e "ifconfig $VINTERFACE down" >> /etc/tinc/$VNAME/tinc-down

# Make tinc network scripts executable
chmod 755 /etc/tinc/$VNAME/tinc-*

touch /.first_run

echo "=================================================="
echo "You can now configure your clients using:"
echo ""
echo "$VNAME/tinc.conf"
echo " Name = your_node_name"
echo " AddressFamily = ipv4"
echo " Interface = $VINTERFACE"
echo " ConnectTo = $VEX_NYC"
echo ""
echo "Then, configure client IP and interface according"
echo "to tinc documentation."
echo "=================================================="
