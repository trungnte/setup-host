### Some script to setup something

Public this repo, let linux host download from github and run it

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/trungnte/setup-host/refs/heads/master/install_python3_centos8.sh)"
```

### Some error

- From centos 8

```sh
Error: Failed to download metadata for repo 'appstream': Cannot prepare internal mirrorlist: No URLs in mirrorlist
``

Resolve

```sh
cd /etc/yum.repos.d/
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
```