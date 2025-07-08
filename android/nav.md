# Overview
1. TODO



# Concepts

## [Graph](TODO)
1. Nodes: Destination
1. Edges: Action
1. Can build in [xml or via the DSL](TODO)


## [Action](TODO)
1. Edge of a Graph
1. Connects Source and Destination
1. Can have (typed) args (see Safe Args)


## [Global Action](TODO)
1. Allows connection to a Destination **from anywhere**


## [Destination](TODO)
1. A Fragment (or Activity)
1. Use [Hosted](TODO)


## [NavController](https://developer.android.com/reference/kotlin/androidx/navigation/NavController)
1. All the logic for Navigation
1. Owns the Graph
1. Owns the [back stack](TODO)
1. `navController.navigate(...)`(https://developer.android.com/reference/androidx/navigation/NavController#navigate(kotlin.Int))


## [NavHost](https://developer.android.com/reference/androidx/navigation/NavHost)
1. Router outlet
1. Container for Fragments
1. Exposes the [`NavController`](https://developer.android.com/reference/androidx/navigation/NavHost#getNavController())


## [NavHostFragment](https://developer.android.com/reference/kotlin/androidx/navigation/fragment/NavHostFragment)
1. TODO


## [Route](TODO)
1. String representing destination + arg placeholders
1. Like a URI in the web

