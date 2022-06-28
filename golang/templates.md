# Overview
- Idioms for [text](https://pkg.go.dev/text/template) and [html](https://pkg.go.dev/html/template) templates

# Name
1. [`Name()`](https://pkg.go.dev/text/template#Template.Name) allows one template to [nest (or inline)](https://pkg.go.dev/text/template#hdr-Nested_template_definitions) another template
    1. eg. `{{template "my-nested-template-name"}}`
    1. [Nesting](https://pkg.go.dev/text/template#hdr-Nested_template_definitions) is one way to reuse (associated) templates


# Associated/Related templates
1. a Template can have zero or more associated templates
1. Associate using [`t.Parse`]() or indirectly via [`t.ParseFiles`](https://pkg.go.dev/text/template#Template.ParseFiles) or [`t.ParseGlob`](https://pkg.go.dev/text/template#Template.ParseGlob)
1. https://pkg.go.dev/text/template#hdr-Associated_templates
1. [`Lookup`](https://pkg.go.dev/html/template#Template.Lookup) returns a single associated template by name
1. [`Templates`](https://pkg.go.dev/html/template#Template.Templates) returns all associated templates


# Nesting templates
1. https://pkg.go.dev/text/template#hdr-Nested_template_definitions


# Idioms
1. [`ParseFiles`](https://pkg.go.dev/text/template#Template.ParseFiles) and [`ParseGlob`](https://pkg.go.dev/text/template#Template.ParseGlob) are just simpler ways to invoke [`t.Parse`](https://pkg.go.dev/text/template#Template.Parse) multiple times
1. Avoid [`ParseFiles`](https://pkg.go.dev/text/template#Template.ParseFiles) and [`ParseGlob`](https://pkg.go.dev/text/template#Template.ParseGlob) across files
    1. (unqualified) file name becomes template.[`Name`](https://pkg.go.dev/text/template#Template.Name)
    1. On collision, last file wins


# Goland
1. Add association for `*.gotmpl`
    1. See https://www.jetbrains.com/help/go/creating-and-registering-file-types.html


# Other resources
1. [Official docs](https://pkg.go.dev/text/template)
1. https://www.practical-go-lessons.com/chap-32-templates
1. [gopheracademy](https://blog.gopheracademy.com/advent-2017/using-go-templates/)
