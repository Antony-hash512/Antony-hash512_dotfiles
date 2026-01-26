Don't forget to add:
```
[include]
    path = ~/.config/git/antony-hash512.config
```
to the beginning or the end of your global git config file `~/.gitconfig` or `~/.config/git/config`.

Note: Git configurations follow a "last one wins" rule:
    - If you place this at the end of the file, these settings will override any previous configurations.
    - If you place this at the beginning, your existing settings below will take precedence.
