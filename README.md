# ssh/sftp allow dynamic IP for CentOS 6.5

## require package

* ruby
* ruby-devel
* rubygems
* fcgi-devel

## require rubygems

* fcgi
* geoip

## free GeoLite database download

```
wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
gunzip GeoIP.dat.gz
```

## append to /etc/hosts.allow

```
sshd: /etc/hosts.allow.d/update_addr
```

## create allow hosts dir and permission

```
mkdir /etc/hosts.allow.d
chown root:nginx /etc/hosts.allow.d
chmod g+w /etc/hosts.allow.d
chmod o-rx /etc/hosts.allow.d
```

## example nginx configration

```
    location /allowip/ {
        auth_basic "basic authentication";
        auth_basic_user_file /etc/nginx/htpasswd;

        fastcgi_split_path_info ^(/allowip)(.*);
        fastcgi_param PATH_INFO $fastcgi_path_info;
        fastcgi_pass unix:/var/run/fcgi-allowip.sock;
        include fastcgi_params;
    }
```
