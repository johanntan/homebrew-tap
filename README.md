# Johann's Homebrew Tap

Personal Homebrew formulae and casks that are not suitable for the official
Homebrew repositories.

## Install

Install a formula directly:

```sh
brew install johanntan/tap/<formula>
```

Install a cask directly:

```sh
brew install --cask johanntan/tap/<cask>
```

Or tap the repository first:

```sh
brew tap johanntan/tap
```

## Casks

### Astris

[Astris](https://github.com/V380-Ori/Astris.Binaries) is a Nintendo Switch 1
emulator based on Ryujinx for Apple silicon Macs running macOS 15 or newer.

Install it with:

```sh
brew install --cask johanntan/tap/astris
```

Astris is ad-hoc signed and not notarized by Apple. The cask automatically
removes the `com.apple.quarantine` attribute from the installed `Astris.app`,
bypassing Gatekeeper for this app. Only install it if you trust the upstream
release.

The cask checks upstream for a new release every six hours and updates itself
through GitHub Actions.

## Brewfile

```ruby
tap "johanntan/tap"
cask "astris"
```
