# Haskell codespace

A Haskell development container for [GitHub Codespaces][1].

You can use this container by putting this in your [`.devcontainer.json`][2] file:

``` json
{
  "image": "ghcr.io/tfausak/haskell-codespace:ghc-9.2",
  "postCreateCommand": "cabal update"
}
```

The `postCreateCommand` is not required, but it is recommended.

This image includes the following tools:

- [GHCup][3]
- [GHC][4]
- [Cabal][5]
- [HLint][6]
- [Brittany][7]

[1]: https://github.com/features/codespaces
[2]: https://code.visualstudio.com/docs/remote/devcontainerjson-reference
[3]: https://www.haskell.org/ghcup/
[4]: https://www.haskell.org/ghc/
[5]: https://www.haskell.org/cabal/
[6]: https://github.com/ndmitchell/hlint
[7]: https://github.com/lspitzner/brittany
