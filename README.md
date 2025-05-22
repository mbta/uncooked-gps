# UncookedGps

uncooked_gps is an ephemeral task that retrieves GL raw GPS data from OCS and uploads it to S3.

## Running locally

```
$ mix escript.build && S3_BUCKET=<s3_bucket> TEAM_EMAIL=<team_email> OCS_URL="<ocs_url>" ./uncooked_gps
```

## Deployment

On ECS, similar to [bye-bye-bye](https://github.com/mbta/bye-bye-bye).
