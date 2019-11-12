# FuelSave Assignment

This is the documentation for the fuelsave-assignment response by Eduardo Varella.

## How to run

As per specification after running `docker-compose up` the app will be available on <a href="http://localhost">http://localhost</a>.

### Authentication endpoint

Request:
```
GET http://localhost/token/
Body:
{
	"username": "xxx",
	"password": "xxx"
}
```

Responses:

- Correct credentials
```
200 OK
{
    "token": "<authorization token>"
}
```

- Incorrect Credentials
```
401 Unauthorized
```

### Vehicles endpoint

Request:
```
GET http://localhost/vehicles/
Headers:
- Authorization: "bearer <authorization token>"
```

Responses:

- Success
```
[
    {
        "distance": <int>,
        "id": <int>,
        "owner_id": <int>
    },
    ...
]
```

Authentication failure
```
403 Forbidden
```


## Persistence Layer

For the persistence layer I've chosen <b>Postgres</b > as the database (added to docker-compose) and <b>SQLAlchemy</b> as the ORM.

I've leveraged the <b>prestart script</b> feature offered by the <b>tiangolo/uvicorn-gunicorn</b> Docker image to run a <i>pseudo</i>-migration to create the database structure and insert the initial data (<b>create_database.py</b>). As I haven't worked deeply with migration in Python outside DJango (that has it's own migrations tool) I didn't know which would be the best migrations package to use (in Node.js I would use db-migrate or sequelize). I took a look at Alembic's documentation, but opted not to spend more time on it and go for a 'custom made' migration script.

I've also used this prestart script to solve a sync issue between the app and postgres in docker-compose. Normally I would customize the app's image so that it would execute a <i>wait-for</i> script before starting the app. This script would keep checking if a pure `SELECT...` could be execute and, when so, would terminate and the app would start. But, as I had this prestart option in hand, I opted to just add a `sleep 5` command.

## Authentication & Authorization

I've used the JWT standard to encrypt the authenticate `user.id` in a token sent to the client and recover it on subsequent API calls. As per specification, the token expires after 10 minutes. 

## Unit Tests

As mentioned before, Python is not my primary programming language and so I'm not used to implement tests on it. I've read some documentation about it but after some issues regarding packaging/execution-scope I decided to deliver the assignment without this deliverable due to time x availability reasons. I apologize for that, and would be glad to showcase some work I've done around automatic integration tests in Node.js using jest, nock, and custom made mock components to emulate AWS services and Slack integration.

## CloudFormation

I haven't worked with CloudFormation directly, meaning that I haven't wrote a yaml manually. Normally I use the <b>Serverless</b> framework that handles the creation of the AWS CloudFormation yaml/json, and also it's deployment. In that scenario, I would create the <b>Lambda</b> functions and attach them to <b>AWS API Gateway</b>, as per the example `serversless.yml` below from one of the projects I've built (I've masked/changed some info on the code below).

```
service: xxx-api

provider:
  name: aws
  stage: local
  runtime: nodejs8.10
  deploymentBucket: xxx-serverless-deploys
  environment:
      STAGE: ${opt:stage}
      PGUSER: ${env:${opt:stage}_PGUSER}
      PGHOST: ${env:${opt:stage}_PGHOST}
      PGPASSWORD: ${env:${opt:stage}_PGPASSWORD}
      PGDATABASE: ${env:${opt:stage}_PGDATABASE}
      PGPORT: ${env:${opt:stage}_PGPORT}
      PGUSER_AUTHENTICATIONDB: ${env:${opt:stage}_PGUSER_AUTHENTICATIONDB}
      PGHOST_AUTHENTICATIONDB: ${env:${opt:stage}_PGHOST_AUTHENTICATIONDB}
      PGPASSWORD_AUTHENTICATIONDB: ${env:${opt:stage}_PGPASSWORD_AUTHENTICATIONDB}
      PGDATABASE_AUTHENTICATIONDB: ${env:${opt:stage}_PGDATABASE_AUTHENTICATIONDB}
      PGPORT_AUTHENTICATIONDB: ${env:${opt:stage}_PGPORT_AUTHENTICATIONDB}

plugins:
  - serverless-offline
  - serverless-prune-plugin
  - serverless-pseudo-parameters

custom:
  serverless-offline:
    port: 4001
  prune:
      automatic: true
      number: 2

functions:
  list:
    runtime: nodejs8.10
    handler: src/resources/handler.list
    events:
      - http:
          path: objects
          method: GET
          cors: true
  getLoanRequest:
    runtime: nodejs8.10
    handler: src/resources/handler.get
    events:
      - http:
          path: objects/{id}
          method: GET
          cors: true
          request:
            parameters:
              paths:
                id: true
  login:
    runtime: nodejs8.10
    handler: src/resources/authentication.login
    events:
      - http:
          path: login
          method: POST
          cors: true
resources:
  Outputs:
    ApiUrl:
      Description: "The API Gateway URL"
      Value:
        Fn::Join:
          - ""
          - - "https://"
            - Ref: ApiGatewayRestApi
            - ".execute-api.${self:provider.region}.amazonaws.com/${opt:stage}"
```

