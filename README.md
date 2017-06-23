# tinc-docker

## Description :
Docker container that runs Tinc VPN in alpine

## How to use this script :
**Pré-requiresites:**  
- git  
- docker  
- docker-compose 

1- Clone this repository :  
`git clone https://github.com/zerpex/tinc-docker.git`

2- Place yourself on the folder :  
`cd tinc-docker`

3- Adapt docker-compose.yml file to your needs.  

4- Execute:  
`docker-compose up -d`

5- Check that all is ok:  
`docker-compose logs`

6- Configure your client according through [tinc documentation](https://www.tinc-vpn.org/examples/).


## Environnement variables :
**- VPN_NAME** : Name of your VPN connection. Default is roxxorvpn

**- EXTERNAL_NIC_NAME** : Name of the NIC interface used for your connection. Default is roxxorexnic  

**- EXTERNAL_NIC_ADDRESS_NAME** : Address name of the public IP. Default is roxxorexnic_public_IP  

**- PUBLIC_IP_RANGE** : Public IP range of the VPN. Default is 10.0.0.1/32  

**- VPN_INTERFACE** : Interface name. Default is tun0  

## Known issues :
- You tell me
