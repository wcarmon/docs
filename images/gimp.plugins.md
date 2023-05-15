# Overview
1. How to use python for gimp plugins



# Install
```bash
sudo apt install -y gimp gimp-plugin-registry gimp-gmic
sudo apt install -y python-cairo python-gobject-2
```

## Ubuntu
1. Install latest gimp using flatpack  <-- may require newer gnome


# Control flow
1. Gimp calls your script (python or script-fu)



# Plugins (Python)
1. Built in: `/usr/lib/gimp/2.0/plug-ins/*.py`
1. Personal: `$HOME/.config/GIMP/2.10/plug-ins/*.py`
    1. See Preferences > Folders > (double click to expand) > Plug-ins 
1. chmod 755 /path/to/my-plugin.py    


# Scripts (Scheme)
1. Built in: `/usr/share/gimp/2.0/scripts/*.scm`
1. Personal: `$HOME/.config/GIMP/2.10/scripts/*.scm` <-- doesn't seem to work
    1. See Preferences > Folders > (double click to expand) > Scripts 


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
