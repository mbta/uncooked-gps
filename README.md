# UncookedGps

uncooked_gps retrieves GL raw GPS data from OCS and uploads it to S3.

## Running locally

```
$ S3_BUCKET=<s3_bucket> TEAM_EMAIL=<team_email> OCS_URL="<ocs_url>" mix run --no-halt
```

## Running in docker locally

```
$ docker build . -t uncooked_gps && docker run -e TEAM_EMAIL=<team_email> -e OCS_URL="<ocs_url>" -t uncooked_gps
```

## Deployment

On ECS, similar to [trike](https://github.com/mbta/trike).
