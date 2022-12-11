set -euo pipefail


if [ "$#" -ne 2 ]; then
    echo "Expected two parameters: Command and VPN name"
    exit 1
fi

COMMAND=$1
VPN_NAME=$2


datamole_connect ()
{
    sudo openvpn --config ~/.openvpn/jknotek-datamole-bundle.ovpn 
}

datamole_disconnect ()
{
    echo "This is not implemented. The session is cancelled via ctrl-c"
}

ujv_connect()
{
    openvpn3 session-start --config ~/.openvpn/profile-1528.ovpn
}

ujv_disconnect()
{
    openvpn3 session-manage --config ~/.openvpn/profile-1528.ovpn  --disconnect
}

utia_connect()
{
    sudo true
    ,getpass.sh --stdout |sudo openconnect --protocol=pulse --user=knotek udun.site.cas.cz --authgroup=ZOI --passwd-on-stdin
}

utia_disconnect()
{
    echo "This is not implemented. The session is cancelled via ctrl-c"
}

case $COMMAND in 
    "connect" ) 
        if [ $VPN_NAME == 'datamole' ]; then
            datamole_connect
        elif [ $VPN_NAME == 'ujv' ]; then
            ujv_connect
        elif  [ $VPN_NAME == 'utia' ]; then
            utia_connect
        else 
            echo "Unknown VPN name: $VPN_NAME"
        fi
        ;;
    "disconnect" )
        if [ $VPN_NAME == 'datamole' ]; then
            datamole_disconnect
        elif [ $VPN_NAME == 'ujv' ]; then
            ujv_disconnect
        elif  [ $VPN_NAME == 'utia' ]; then
            utia_disconnect
        else 
            echo "Unknown VPN name: $VPN_NAME"
        fi 
        ;;
    *)
    echo "Unknown command $COMMAND"
esac
