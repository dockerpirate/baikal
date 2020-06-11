## Alpine Baikal Docker Container

### Usage:

```shell
docker run \
    --publish 80:80 \
    --volume `pwd`/config:/baikal/Specific
    --name baikal \
    --restart unless-stopped \
    --detach \
    dockerpirate/baikal
```

Setup Baikal using http://localhost/admin

### License

[The MIT License](LICENSE)
