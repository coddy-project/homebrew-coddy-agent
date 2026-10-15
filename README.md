# Homebrew tap for Coddy

[Coddy](https://coddy.dev/) is a coding agent with a console, an editor protocol and an HTTP
gateway. This tap carries its Homebrew cask: the prebuilt macOS binary of the latest release, with
`man coddy` and the bash and zsh completions.

## Install

```bash
brew install coddy-project/coddy/coddy
```

Homebrew adds the tap, trusts this one cask and installs it. From then on `brew upgrade` follows
new releases, and `coddy update` points at `brew upgrade --cask coddy`.

Homebrew 7 does not load anything else from a third-party tap until it is trusted. To refer to the
cask by its short name in every command, trust the tap once:

```bash
brew trust coddy-project/coddy
brew install --cask coddy
```

Remove it with `brew uninstall --cask coddy`; `brew zap --cask coddy` also deletes `~/.coddy`
(sessions, skills, credentials and the config).

The [installation guide](https://coddy.dev/docs/getting-started/homebrew) covers the details and the
other ways to install Coddy.

## How this tap is updated

`Casks/coddy.rb` is generated. The release workflow of
[coddy-agent](https://github.com/coddy-project/coddy-agent) renders it from
`packaging/homebrew/coddy.rb.tmpl` with the checksums of the two macOS archives of each release and
commits it here, then installs it on a macOS runner by the command above. Do not edit it by hand:
change the template in coddy-agent.

Report problems in the [coddy-agent issues](https://github.com/coddy-project/coddy-agent/issues).
