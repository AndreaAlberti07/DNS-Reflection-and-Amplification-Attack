from scapy.all import srp, Ether, ARP

def ping_sweep(network):
    # Craft an ARP request packet
    arp_request = Ether(dst="ff:ff:ff:ff:ff:ff") / ARP(pdst=network)

    # Send the packet and capture the response
    result = srp(arp_request, timeout=2, verbose=0)[0]

    # Extract the IP addresses of active hosts
    active_hosts = []
    for sent, received in result:
        active_hosts.append(received.psrc)

    return active_hosts

# Example usage
network = "10.87.187.0/24"  # Replace with your desired network range
active_hosts = ping_sweep(network)
print("Active hosts:")
for host in active_hosts:
    print(host)