# gifeegol

Github Feed's Game of Life

## Setup instructions

Clone the repository and submodule:

```
git clone --recurse-submodules --branch main git@github.com:lucasreta/gifeegol.git gifeegol
cd gifeegol
```

Build cligol in its subdirectory:

```
gcc -o cligol/cligol cligol/main.c
```

Generate a Github [personal access token](https://github.com/settings/tokens) with enough
permissions to access the endpoint for [repo updates](https://docs.github.com/en/free-pro-team@latest/rest/reference/repos).

Setup a cron job, replacing `$username`, `$access_token`, `$repository` and `/path/to/repo` with their correct values

```
0 0 * * * USERNAME=$username ACCESS_TOKEN=$access_token REPOSITORY=$repository /path/to/repo/move.sh
```

The above cron will run once every day, at midnight, but you can configure the frequency to your liking.


