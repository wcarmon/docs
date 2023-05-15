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


# Scripts (Scheme)
1. Built in: `/usr/share/gimp/2.0/scripts/*.scm`
1. Personal: `$HOME/.config/GIMP/2.10/scripts/*.scm` <-- doesn't seem to work
    1. See Preferences > Folders > (double click to expand) > Scripts 
1. Restart gimp


# Plugins (Python)
1. TODO: I have not been successful with GIMP 2.10.18 on Ubuntu
1. Built in: `/usr/lib/gimp/2.0/plug-ins/*.py`
1. Personal: `$HOME/.config/GIMP/2.10/plug-ins/*.py`
    1. See Preferences > Folders > (double click to expand) > Plug-ins 
1. chmod 755 /path/to/my-plugin.py    
1. Restart gimp
1. Appears under Filters > <however-you-registered-it>


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
