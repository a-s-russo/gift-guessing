# Install and/or load libraries
packages = c("tidyverse", "scales")
package.check <-
  lapply(
    packages,
    FUN = function(x) {
      if (!require(x, character.only = TRUE)) {
        install.packages(x, dependencies = TRUE)
        library(x, character.only = TRUE)
      }
    }
  )

# Define function to generate all permutations of n items
permutations <- function(n) {
  if (n == 1) {
    return(matrix(1))
  } else {
    sp <- permutations(n - 1)
    p <- nrow(sp)
    A <- matrix(nrow = n * p, ncol = n)
    for (i in 1:n) {
      A[(i - 1) * p + 1:p, ] <- cbind(i, sp + (sp >= i))
    }
    return(A)
  }
}

# Define function to determine # items in correct position for n permutations
list_perms <- function(n) {
  # Generate list of permutations
  permutation_list <-
    as_tibble(permutations(n), .name_repair = "unique_quiet") %>%
    rename_with(~ gsub("...", "V", .x))
  
  # Determine items in the correct spot
  correct_spots <- tibble(integer(nrow(permutation_list))) %>%
    select()
  for (column_index in 1:n) {
    this_column <- pull(permutation_list, column_index)
    correct <- this_column == column_index
    correct_spots <- correct_spots %>%
      add_column(correct, .name_repair = "unique_quiet")
  }
  
  # Tally number correct per permutation
  correct_tally <-
    mutate(correct_spots, total_correct = rowSums(correct_spots))
  
  # Tally overall corrections
  correct_overall <- tibble(case = 0:n, number = integer(n + 1))
  total_col <- pull(correct_tally, total_correct)
  for (case in 0:n) {
    this_case <- length(total_col[total_col == case])
    correct_overall[case + 1, "number"] <- this_case
  }
  return(correct_overall)
}

# Define function to plot proportion of all permutations resulting in 0 to n items in the correct position for 1 to n permutations
plot_perms <- function(n) {
  # Extract # items in correct position for 1 to n permutations
  combined_data <- tibble(case = 0:n)
  for (perm in 1:n) {
    this_total <- list_perms(perm)
    combined_data <- left_join(combined_data, this_total, by = 'case')
  }
  combined_data <-
    rename_with(combined_data, ~ paste0("perm", 1:n), starts_with("number"))
  
  # Convert from wide to long format
  long_data <-
    gather(
      combined_data,
      key = "permutation",
      value = "no_correct",
      starts_with("perm"),
      na.rm = TRUE
    ) %>%
    mutate(
      case = factor(case, levels = unique(str_sort(case, numeric = TRUE))),
      permutation = as.numeric(gsub("perm", "", permutation)),
      total_perms = factorial(permutation),
      success_rate = no_correct / total_perms
    )
  
  # Plot data
  g <- ggplot(data = long_data, aes(x = permutation, y = success_rate)) +
    geom_line(aes(colour = case)) +
    geom_point(aes(colour = case)) +
    xlab("Number of presents") +
    ylab("Success rate") +
    scale_x_continuous(breaks = seq(1:n)) +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
    labs(colour = "Number correctly tagged:") +
    theme(legend.position = "top", panel.grid.minor = element_blank())
  return(g)
}
