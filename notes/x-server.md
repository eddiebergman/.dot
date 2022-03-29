#### X server stuff
Can query window properties
```bash
xprop  # Select window with just terminal and with vim
```

We can dynamically alter X window properties with xprop. Using the following to get currently active window and set properties.

```bash
xprop -id $(xdotool getactivewindow) -set <prop> <val>
```

Can set new properties with format

```bash
xprop -format _NET_WM_OPACITY 32c -set _NET_WM_OPACITY 0xFFFFFFFF
```
