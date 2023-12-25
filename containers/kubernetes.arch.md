# Overview
1. TODO


1. `Node` -|o---o|< `Pod`
1. `Pod` -|---|< `Container`
1. `Pod` -|o---|- ipAddress
1. `Container` -|o---o|< port
1. `Image` -|---o|< `Container`


## Storage
1. `Node` -|---o|< `Volume`
1. `PersistentVolume` -|---|- `PersistentVolumeClaim`
1. `Pod` -|o---o|< `PersistentVolume`
1. `Pod` -|---o|< `PersistentVolumeClaim`


## Service
1. `Service` -|o---|< ipAddress
1. `Service` -|o---|< port
1. `Service` >|o---o|< `Pod` (via selectors)




- TODO: make a diagram

# Other resources
1. TODO
