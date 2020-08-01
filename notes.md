# I want to edit haskell

Start a nix shell first:
```sh
nix-shell
nvim Main.hs
```

# I want to play in a repl

```
cabal repl
import Main
main
```

# I want to add a 3rd party module

Add it in the `.cabal` file under `build-depends` and open a new `nix-shell`

# I want to rename the project

Rename it in the `.cabal` file (name and executable)
Rename it after `.exes.` in `default-nix`

# Ok, how do we build?

This is done with just a `nix-build` in the root.

# And to add it to the nixos environment?

```
nix-env -i -f default.nix
```

----

- [X] how do we get typechecking?
- [ ] how do we parse a response body and emit an error?
- [ ] how do we parse a response body and output formatted JSON?
- [ ] how do we log in, receive a cookie, then use that cookie in subsequent requests
- [ ] how do we refine the JSON response?
