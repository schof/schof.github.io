DumpComstock.com
================

## Running locally

Events are all future dates so we want to generate those at build time

```
bundle exec jekyll build --future
```

## Docker build

```
docker build -t 232121879002.dkr.ecr.us-east-1.amazonaws.com/dumpcomstock .
ecr login
docker push 232121879002.dkr.ecr.us-east-1.amazonaws.com/dumpcomstock
```

Webp Conversion
---------------
These files don't work on Safari or Firefox so they need to be converted

```
brew install webp
dwebp comstock-aca-protest.webp -o comstock-aca-protest.png
```
