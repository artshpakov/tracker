# API Reference

### Authenticate

```shell
curl -XPOST 'HOST/auth' -d 'email=user@local.host&password=123456'
```

### Fetch current user account

```shell
curl 'HOST/me' -H "X-Api-Key: YOUR_API_TOKEN"
```

### Issues list

```shell
curl 'HOST/issues' -H "X-Api-Key: YOUR_API_TOKEN"
```

### Create an issue

```shell
curl -XPOST 'HOST/issues' -H "X-Api-Key: YOUR_API_TOKEN" -d "title=MyNewIssue"
```

### Update an issue

```shell
curl -XPATCH 'HOST/issues/:id' -H "X-Api-Key: YOUR_API_TOKEN" -d "status=2"
```

### Delete an issue

```shell
curl -XDELETE 'HOST/issues/:id' -H "X-Api-Key: YOUR_API_TOKEN"
```
