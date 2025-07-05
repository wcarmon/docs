# Overview
1. `RecyclerView` and related classes



# [RecyclerView.Adapter](https://developer.android.com/reference/androidx/recyclerview/widget/RecyclerView.Adapter)
1. Binds/Connects raw data to the `ViewHolder`
1. Creates `ViewHolder`s
1. [onBindViewHolder](https://developer.android.com/reference/androidx/recyclerview/widget/RecyclerView.Adapter#onBindViewHolder(VH,int)): keep small, light and efficient


# [RecyclerView.ViewHolder](https://developer.android.com/reference/androidx/recyclerview/widget/RecyclerView.ViewHolder)
1. References the UI controls (sets text, etc)
1. References the Views


# [ViewModel](https://developer.android.com/topic/libraries/architecture/viewmodel)
1. Mutable
1. Connects the UI to data


# [Fragment](https://developer.android.com/guide/fragments)
1. Owns the [View](https://developer.android.com/reference/android/view/View) hierarchy
1. Creates the `RecyclerView`
1. References the `RecyclerView`
1. References the `RecyclerView.Adapter`
