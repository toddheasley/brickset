# `GetSet`

__Get LEGO® set info, images and instructions from [Brickset](https://brickset.com/article/52664/api-version-3-documentation)__

`GetSet` extends `URLSession` with async/await functions that return deserialized, modeled set info and media URLs. Search sets by set number, name or keyword query.

Requires a free [Brickset API key](https://brickset.com/tools/webservices/requestkey), persisted safely in the system keychain.

## Command-line interface

![](docs/getset-cli.png)

`GetSet` includes a basic CLI that downloads data, images and building instructions for a specific set. `getset-cli` demonstrates using the `GetSet` extensions to `URLCredential` and `URLSession` in your own apps.

### CLI Examples

Set new Brickset API key:

```zsh
% ./getset-cli key 3-26cC-J3gUn-63bi
API key: •••••••••••••••••
```

View and/or validate the currently set key:

```zsh
% ./getset-cli key -s
API key: 3-26cC-J3gUn-63bi
```

(Valid key appears green; invalid key shows red.)

Delete key from keychain:

```zsh
% ./getset-cli key -d
API key not set
```

### Supported Platforms

Written in [Swift](https://developer.apple.com/swift) 6 for Apple stuff:

* [macOS](https://developer.apple.com/macos) 15 Sequoia
* [iOS](https://developer.apple.com/ios)/[iPadOS](https://developer.apple.com/ipad)/[tvOS](https://developer.apple.com/tvos) 18
* [watchOS](https://developer.apple.com/watchos) 11
* [visionOS](https://developer.apple.com/visionos) 2

Build with [Xcode](https://developer.apple.com/xcode) 16 or newer. Command-line interface depends on [Swift Argument Parser.](https://github.com/apple/swift-argument-parser)
