# homebrew-tap

Homebrew formulae for [leue21](https://github.com/leue21)'s tools.

```sh
brew install leue21/tap/morse
```

## Formulae

- **[morse](https://github.com/leue21/morse)** — send a notification to Telegram
  from the command line. One message, one exit; the caller decides when there is
  something worth saying.

## Updating a formula

Point `url` at the new tag, replace `sha256` with what the tarball hashes to,
and push:

```sh
curl -sL https://github.com/leue21/morse/archive/refs/tags/vX.Y.Z.tar.gz | shasum -a 256
```
