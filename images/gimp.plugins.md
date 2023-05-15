# Overview
1. TODO



# Install
```bash
sudo apt install -y gimp gimp-plugin-registry gimp-gmic
sudo apt install -y python-cairo python-gobject-2
```


# Control flow
1. Gimp calls your script (python or script-fu)



# Plugins (Python)
1. Built in: `/usr/lib/gimp/2.0/plug-ins`
1. Personal: `$HOME/.config/GIMP/2.10/plug-ins`
    1. See Preferences > Folders > (double click to expand) > Plug-ins 


# Debugging
1. Filters -> Python-fu -> Console


# Example
```python
from gimpfu import *

# TODO: more here


main()   # GIMP's main(), do not write your own!
```
1. Make it runnable
```bash
chmod +x my_script.py
```
1. copy/move/simlink to `$HOME/.gimp-2.10/plug-ins/my_script.py 


# Batch mode
1. TODO


# Other resources
1. https://gimpbook.com/scripting/
1. https://www.gimp.org/docs/python/index.html#STRUCTURE-OF-PLUGIN
1. https://en.wikibooks.org/wiki/GIMP/Installing_Plugins#Linux
