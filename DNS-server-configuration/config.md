# DNS server configuration

## Modules required:

- bind9
- bind9utils
- bind9-doc

## File /etc/bind/named.conf.options

This file contains all the configurations included the ip addresses allowed to perform the query.  
In this file are also specified the security measures,
in this server they are not set up, in order to ease the msdos attack.

## File /etc/bind/named.conf.local

This file is typically used to define local DNS zones for a private domain. We will update this file to include our forward and reverse DNS zones.  
During the test it is configured using private NS.

```bash
 GNU nano 6.2   /etc/bind/named.conf.local
zone "ediproject.com" {
    type primary;
    file "/etc/bind/zones/db.ediproject.com"; # zone file path
};

zone "128.10.in-addr.arpa" {
    type primary;
    file "/etc/bind/zones/db.10.128";  # 10.128.0.0/16 subnet
};
```

## File /etc/bind/zones/db.ediproject.com

It contains all informations about the domain name, including all resource records ...
This domain has :

- 7 Name servers
- 6 Mail servers
- 2 IPv4 addresses for the domain ediproject.com.

```bash
  GNU nano 6.2    /etc/bind/zones/db.ediproject.com

  GNU nano 6.2                                                                             /etc/bind/zones/db.ediproject.com *
$TTL    604800
@       IN      SOA     ns1.ediproject.com. admin.ediproject.com. (
                  3     ; Serial
             604800     ; Refresh
              86400     ; Retry
            2419200     ; Expire
             604800 )   ; Negative Cache TTL
;
; name servers - NS records
@     IN      NS        davide.ediproject.com.
@     IN      NS        cristian.ediproject.com.
@     IN      NS        matteo.ediproject.com.
@     IN      NS        andrea.ediproject.com.
@     IN      NS        karim.ediproject.com.
@     IN      NS        www.ediproject.com.
@     IN      NS        ns2.ediproject.com.
@     IN      MX  10    ediproject.com
@     IN      MX  8     email.ediproject.com
@     IN      MX  6     email2.ediproject.com
@     IN      MX  3     email3.ediproject.com
@     IN      MX  2     email4.ediproject.com
@     IN      MX  1     email5.ediproject.com

ns1.ediproject.com.          IN      A       10.128.10.11
davide.ediproject.com.       IN      A       10.128.10.13
karim.ediproject.com.        IN      A       10.128.10.12
andrea.ediproject.com.       IN      A       10.128.10.14
matteo.ediproject.com.       IN      A       10.128.10.15
cristian.ediproject.com.     IN      A       10.128.10.16
ediproject.com.              IN      A       10.128.10.17
ediproject.com.              IN      A       10.128.10.18
www.ediproject.com.          IN      A       10.128.10.19
ns2.ediproject.com.          IN      A       10.128.10.20
```

## File /etc/bind/zones/db.10.128

It contains all informations about the reverse name server

```bash
  GNU nano 6.2    /etc/bind/zones/db.10.128
$TTL    604800
@       IN      SOA     ediproject.com. admin.ediproject.com. (
                              3         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
; name servers
      IN      NS      ns1.project.com.


```
