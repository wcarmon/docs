# Overview
1. TODO


# Preconditions
1. Ensure gradle.properties has ...
    - `android.useAndroidX=true`


# Concepts

## [Graph](TODO)
1. Node: Destination
1. Edge: Action
1. Can build in [xml or via the DSL](TODO)
1. Defined by: App Developer


## [Action](TODO)
1. Edge of a Graph
1. Connects Source and Destination
1. Can have (typed) arguments (see Safe Args)


## [Global Action](TODO)
1. Allows connection to a Destination **from anywhere**


## [Destination](TODO)
1. A Fragment (or Activity)
1. Use [Hosted](TODO)
1. a node in the Nav Graph


## [NavController](https://developer.android.com/reference/kotlin/androidx/navigation/NavController)
1. All the logic for Navigation
1. Traverses the Nav Graph
1. Handles Deep linking
1. Owns ...
    1. the Nav Graph
    1. the [back stack](TODO)
1. Lookup:
    - [`fragment.findNavController()`](https://developer.android.com/reference/kotlin/androidx/navigation/fragment/package-summary#(androidx.fragment.app.Fragment).findNavController())
    - [`view.findNavController()`](https://developer.android.com/reference/kotlin/androidx/navigation/package-summary#%28android.view.View%29.findNavController%28%29)
1. Navigate:
    1. `navController.navigate(...)`(https://developer.android.com/reference/androidx/navigation/NavController#navigate(kotlin.Int))


## [NavHost](https://developer.android.com/reference/androidx/navigation/NavHost)
1. Router outlet
1. Container for Fragments
1. Exposes the [`NavController`](https://developer.android.com/reference/androidx/navigation/NavHost#getNavController())
1. Defined by: App Developer


### [NavHostFragment](https://developer.android.com/reference/kotlin/androidx/navigation/fragment/NavHostFragment)
1. root of views


## [Route](TODO)
1. a String
    1. Like a URI in the web
1. Represents one Destination + arg placeholders    
1. Idiom: only include the minimum data (like ids, uuids, flags)


## Arguments
1. A way to pass data to a destination (Fragment, Activity, ...)
1. Pass ...
    1. https://developer.android.com/guide/navigation/use-graph/pass-data
1. Lookup ...
    1. [`getArguments()`](https://developer.android.com/reference/kotlin/androidx/fragment/app/Fragment#getArguments())
        - Call from `onCreateView(...)`
1. TODO: Safe Args
