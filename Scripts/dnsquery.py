import argparse
import socket
import dns.message
import dns.rdatatype
import scapy
from scapy.layers.inet import UDP, IP
from scapy.sendrecv import send


def send_dns_query(domain_name, dns_server="224.0.0.251", dns_port=5353, rr_type='A', flags=0x0100, spoofed_ip=None):
    # Create a DNS query message
    message = create_dns_query(domain_name, rr_type, flags)

    iterazioni=2
    while(iterazioni):
        response = send(IP(dst=dns_server, src=spoofed_ip) / UDP(sport=dns_port, dport=dns_port) / message.to_wire())
        iterazioni -= 1
    return response



def create_dns_query(domain_name, rr_type, flags):
    # Create a DNS query message using dnspython library
    message = dns.message.make_query(domain_name, rr_type)
    message.flags = flags

    return message

def print_dns_response(response):
    # Print the DNS response using dnspython library
    message = dns.message.from_wire(response)
    print(f'DNS Response:\n{message}')

    return message

# Parse command-line arguments
parser = argparse.ArgumentParser(description='Send DNS query and print the response')
parser.add_argument('server', type=str, help='DNS server IP address')
parser.add_argument('port', type=int, help='DNS server port number')
parser.add_argument('domain_name', type=str, help='Domain name to query')
parser.add_argument('--spoofed_ip', help='Spoofed IP address (optional)')
parser.add_argument('--rr_type', type=str, default='A', help='Resource Record type to query (default: A)')
parser.add_argument('--flags', type=int, default=0x0100, help='DNS flags (default: 0x0100)')
parser.add_argument('--qr', type=int, default=None, help='QR flag value (default: None)')
parser.add_argument('--opcode', type=int, default=None, help='OPCODE flag value (default: None)')
parser.add_argument('--aa', type=int, default=None, help='AA flag value (default: None)')
parser.add_argument('--tc', type=int, default=None, help='TC flag value (default: None)')
parser.add_argument('--rd', type=int, default=None, help='RD flag value (default: None)')
parser.add_argument('--ra', type=int, default=None, help='RA flag value (default: None)')
parser.add_argument('--z', type=int, default=None, help='Z flag value (default: None)')
parser.add_argument('--rcode', type=int, default=None, help='RCODE flag value (default: None)')
args = parser.parse_args()

# Modify the DNS flags if provided
if args.qr is not None:
    args.flags |= args.qr << 15
if args.opcode is not None:
    args.flags |= args.opcode << 11
if args.aa is not None:
    args.flags |= args.aa << 10
if args.tc is not None:
    args.flags |= args.tc << 9
if args.rd is not None:
    args.flags |= args.rd << 8
if args.ra is not None:
    args.flags |= args.ra << 7
if args.z is not None:
    args.flags |= args.z << 6
if args.rcode is not None:
    args.flags |= args.rcode

# Send DNS query and print the response
response = send_dns_query(args.domain_name, args.server, args.port, args.rr_type, args.flags, args.spoofed_ip)
# print_dns_response(response)