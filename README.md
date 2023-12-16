# Gift guessing
Imagine you wrapped 5 gifts for 5 people. If you placed the gift tags on at random, what are the chances that you labelled only 3 of the gifts correctly?

What about labelling 0 or 5 correctly? What about doing so for 10 gifts?

This code calculates the chances of labelling any number of tags correctly for any number of gifts:
* the `list_perms()` function determines the number of items in the correct position(s) for *n* permutations; and
* the `plot_perms()` function plots the percentage of all permutations resulting in 0 to *n* items in the correct position(s) for 1 to *n* permutations.

However, since permutations are involved, the code runs slowly for large *n*.

 ![Success rate for correctly tagging 1 to 11 gifts](/image.png)
