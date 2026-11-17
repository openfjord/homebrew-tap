# OpenFjord Homebrew tap

Homebrew formulas for OpenFjord's command-line tools.

## Install a tool

```bash
brew install openfjord/tap/<tool>
```

Homebrew adds this tap the first time you install from it.

## Tools

| Tool | What it does | Install |
|---|---|---|
| [`of-lang`](https://github.com/openfjord/of-lang) | Checks packages written in the OpenFjord modeling language, runs their rules and tests | `brew install --HEAD openfjord/tap/of-lang` |

`of-lang` has no release yet, so it installs from the latest source with
`--HEAD`.
