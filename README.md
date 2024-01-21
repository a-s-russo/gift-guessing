# Gift guessing
Imagine you wrapped 5 gifts for 5 people. If you placed the gift tags on at random, what are the chances that you labelled only 3 of the gifts correctly?

What about labelling 0 or 5 correctly? What about doing so for 10 gifts?

This code calculates the chances of labelling any number of tags correctly for any number of gifts:
* the `list_perms()` function determines the number of items in the correct position(s) for *n* permutations; and
* the `plot_perms()` function plots the percentage of all permutations resulting in 0 to *n* items in the correct position(s) for 1 to *n* permutations.

However, since permutations are involved, the code runs slowly for large *n*.

 ![Success rate for correctly tagging 1 to 11 gifts](/image.png)

# Answers (spoiler alert!)
If wrapping 5 gifts for 5 people, then clearly:
* there is only way to tag 5 gifts correctly; and
* there are no ways to tag *only* 4 gifts correctly (since tagging 4 gifts correctly means there is only gift remaining for the fifth tag, which must be correct, thereby implying 5 correctly tagged gifts).

By examining a few cases, generalisations can be made. The table below shows the number of ways of obtaining a given number of correctly tagged gifts (first column) for a given number of gifts (top row):

| Number correctly tagged | n = 1 gift | n = 2 gifts | n = 3 gifts | n = 4 gifts | n = 5 gifts | n = 6 gifts | n = 7 gifts | n = 8 gifts | n = 9 gifts | n = 10 gifts | n = 11 gifts |
|------------------------:|-----------:|------------:|------------:|------------:|------------:|------------:|------------:|------------:|------------:|-------------:|-------------:|
|                   **0** |          0 |           1 |           2 |           9 |          44 |         265 |       1,854 |      14,833 |     133,496 |    1,334,961 |   14,684,570 |
|                   **1** |          1 |           0 |           3 |           8 |          45 |         264 |       1,855 |      14,832 |     133,497 |    1,334,960 |   14,684,571 |
|                   **2** |            |           1 |           0 |           6 |          20 |         135 |         924 |       7,420 |      66,744 |      667,485 |    7,342,280 |
|                   **3** |            |             |           1 |           0 |          10 |          40 |         315 |       2,464 |      22,260 |      222,480 |    2,447,445 |
|                   **4** |            |             |             |           1 |           0 |          15 |          70 |         630 |       5,544 |       55,650 |      611,820 |
|                   **5** |            |             |             |             |           1 |           0 |          21 |         112 |       1,134 |       11,088 |      122,430 |
|                   **6** |            |             |             |             |             |           1 |           0 |          28 |         168 |        1,890 |       20,328 |
|                   **7** |            |             |             |             |             |             |           1 |           0 |          36 |          240 |        2,970 |
|                   **8** |            |             |             |             |             |             |             |           1 |           0 |           45 |          330 |
|                   **9** |            |             |             |             |             |             |             |             |           1 |            0 |           55 |
|                  **10** |            |             |             |             |             |             |             |             |             |            1 |            0 |
|                  **11** |            |             |             |             |             |             |             |             |             |              |            1 |

More broadly then, for any number of gifts *n*:
* There is only one way to tag *n* gifts correctly. (This corresponds to the sequence of numbers in the main diagonal of the table.)
* There are no ways to tag *n* - 1 gifts correctly. (This corresponds to the sequence of numbers in the first diagonal above the main diagonal of the table.)
* Correctly tagging *n* - 2 gifts corresponds to the (*n* - 1)<sup>th</sup> [triangular number](https://en.wikipedia.org/wiki/Triangular_number), or (*k*<sup>2</sup> + *k*)/2 where *k* = *n* - 1.  (This corresponds to the sequence of numbers in the second diagonal above the main diagonal of the table.)
* Correctly tagging *n* - 3 gifts can be obtained via *k*(*k*<sup>2</sup> - 1)/3 where *k* = *n* - 1. (This corresponds to the sequence of numbers in the third diagonal above the main diagonal of the table.)

As can be demonstrated for the *n* - 3 case, formulae for the sequences of numbers in any of the other diagonals could also theoretically be found via arithmetic progressions that fit polynomials to the number strings.

Observe also that the sequences of numbers in the first two rows differ by only one, and alternate between a difference of +1 and -1.

## Derangements

To obtain the sequence of numbers corresponding to the first row in the table above, the well-defined concept of [derangements](https://en.wikipedia.org/wiki/Derangement) can be used. A derangement is a permutation of the elements of a set in which no element appears in its original position.

So for zero correctly tagged gifts, the article linked above provides the following recursive formula with notation given by !*n* (as opposed to *n* factorial, or *n*!): $$!n = (n-1) \times [!(n-1) + !(n-2)]$$

For other rows, similar derangements can be found. Instead of those with zero fixed points, derangements with one fixed point, two fixed points, three fixed points, etc. are required. The online encyclopaedia of integer sequences (OEIS) gives formulae for these other cases, such as for [one fixed point](https://oeis.org/A000240), [two fixed points](https://oeis.org/A000387), etc.

## Tagging 0 or 1 gifts correctly

The case for correctly tagging 1 gift can simply be expressed as a function of a derangement (with zero fixed points). If $`g(n)`$ is the number of ways of obtaining 1 correctly tagged gift for $n$ gifts, then $`g(n) = n \times !(n-1)`$.

The difference between the cases for tagging 0 correct and tagging 1 correct is the difference between $!n$ and $`g(n)`$. This is: $$(n-1) \times [!(n-1) + !(n-2)] - n \times !(n-1) = (n-1) \times !(n-2) - !(n-1)$$ By recursion and the fact that $`!0=1`$ and $`!1=0`$, the difference between $`!n`$ and $`g(n)`$ will be 1 when $n$ is even, and -1 when $n$ is odd, as shown in the table above.

The article linked above also explains why the proportion of all permutations for these two cases converges to around $`1/e = 0.37`$ as the number of gifts increases, as shown in the graph above. Other cases also seem to converge as $n$ tends to infinity.
