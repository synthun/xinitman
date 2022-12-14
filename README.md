# xinitman

shell utility for managing 'presets' for ~/.xinitrc

## installation

+ `sudo make install` - copy the script to /usr/bin
+ `sudo make uninstall` - remove the script in /usr/bin

run `xinitman` for usage

## troubleshooting

`ERROR $EDITOR not set`

you do not have the EDITOR variable set in your shell, to do this run

```
export EDITOR=(text editor of your choice)
```

or even better, add this to your shells .rc file to prevent it completely
