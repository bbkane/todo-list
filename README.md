# Elm Starter Project

# Install

## Base

- Install NVM: https://github.com/creationix/nvm
- Install Elm: `npm install -g elm`

## Visual Studio Code

- Install `elm-format`: `npm install -g elm-format`
- Install VS Code from https://code.visualstudio.com/
- Add `code` command to `PATH` for command line usage
  - `Cmd-P` (Mac) or `Ctrl-P` (Linux): Launch Command Palette
  - Type `> Shell Command: Install code command in PATH`
- Install Elm Extension
  - From Command Line: `code --install-extension sbrink.elm`
  - From Web: `https://marketplace.visualstudio.com/items?itemName=sbrink.elm`
- Restart VS Code

# Use

## Start Project

```bash
elm init
```

## Develop

Note: `elm reactor` doesn't work if you have HTML or JavaScript code. See https://github.com/rtfeldman/elm-spa-example#building for that.

```
./dev_env.sh
```


# Useful Learning Links

- https://guide.elm-lang.org/
- https://github.com/evancz/elm-architecture-tutorial/
- https://elm-lang.org/0.19.0/init
- https://github.com/evancz/elm-todomvc
- https://github.com/rtfeldman/elm-spa-example

