# Ruby-Learning
#JWT
- Header
- Payload
- Signature

JWT No Secret

```
#Payload
payload = {data: 'test'}

token = JWT.encode(payload , nil , 'none')

decode_token = JWT.decode(token , nil , false)

```


JWT With Secret

```
secret = "0a8b725d21a80a9c58a59616b6db7d6f7381e93ab8f3322917e90901a77879e2875af2d6c3893d1654c291a71f03709eb786758fc388127ebdf9a0e6c8296295"

payload = {data: 'test'}

token = JWT.encode(payload , secret , 'HS256')

decode_token = JWT.decode(token , nil , false)

```
