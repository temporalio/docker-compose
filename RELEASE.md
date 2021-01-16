Create new release
==================

To update image tags in `docker-compose*.yml` files run:

```bash
$ make release SERVER_TAG=<current_release_server_tag> WEB_TAG=<current_release_web_tag>
```

For example:

```bash
$ make release SERVER_TAG=1.5.1 WEB_TAG=1.5.0
```
