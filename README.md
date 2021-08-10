# Tiny

A simple URL shortener API service.

## Claiming a shortened link

Claiming can be done easily in one of two ways. The simplest is to simply provide a URL, which returns a randomized alias in return:
```
curl -d '{"url":"https://www.apple.com/shop/refurbished/mac/mac-mini"}' -H "Content-Type: application/json" -X POST http://localhost:3000/url_aliases
```
```json
{"message":"URL Alias \"CHg7wUa\" claimed."}
```

It is also possible to specify a custom alias, if not already in use:
```
curl -d '{"alias":"TestIt", "url":"https://www.apple.com/shop/refurbished/mac/mac-mini"}' -H "Content-Type: application/json" -X POST http://localhost:3000/url_aliases.json
```
```json
{"message":"URL Alias \"TestIt\" claimed."}
```

## Using a shortened link

Simply access it by using the alias as the subdirectory of the base URL:
```
http://localhost:3000/TestIt
```
This will automatically redirect to the destination.

## Releasing a shortened link

Releasing a link is treated like a delete, though the recors is never actually deleted, simply released to allow the alias to be reused.
```
curl -X DELETE "http://localhost:3000/url_aliases/TestIt"
```
```json
{"message":"URL Alias \"TestIt\" released."}
```

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```
