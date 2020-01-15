###  Plot USA Lyme disease incidence at state or national level ###
### Author: Jean-Paul R. Soucy ###

# Load libraries
library(tsibble) # tidy time series
library(ggplot2) # enhanced plotting

# Load data
lyme_national <- read.csv("https://raw.githubusercontent.com/jeanpaulrsoucy/lyme-usa-1993-2009/master/lyme_usa_1993-2009.csv",
                          header = TRUE, stringsAsFactors = FALSE) # load data from GitHub
lyme_state <- read.csv("https://raw.githubusercontent.com/jeanpaulrsoucy/lyme-usa-1993-2009/master/lyme_state_1993-2009.csv",
                       header = TRUE, stringsAsFactors = FALSE) # load data from GitHub 

# Create tsibble - USA total
lyme_national <- as_tsibble(lyme_national, index = year)

# Create tsibble - USA states
lyme_state <- as_tsibble(lyme_state, key = state, index = year)

# Plot - USA total
national_plot <- ggplot(data = lyme_national, aes(x = year, y = incidence)) +
  geom_line() +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5)) + # centre title
  labs(x = "Year", y = "Incidence/1,000", title = "USA - National")
national_plot # display plot
# ggsave("national_plot.png", national_plot) # save plot to working directory

# Plot - USA states
state_plot <- ggplot(data = lyme_state, aes(x = year, y = incidence.per.1000, group = state)) +
  geom_line() +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5)) + # centre title
  labs(x = "Year", y = "Incidence/1,000", title = "USA - 50 States and DC")
state_plot # display plot
# ggsave("state_plot.png", state_plot) # save plot to working directory

# Add country-level trend to state plot
state_plot_national <- state_plot +
  geom_line(data = lyme_national, aes(x = year, y = incidence, group = 1),
            colour = "blue", size = 3, alpha = 0.5) +
  labs(title = "USA - 50 States and DC with National Trend")
state_plot_national # display plot
# ggsave("state_plot_national.png", state_plot_national) # save plot to working directory

# Plot - specific state
state <- "Connecticut" # define state of interest
specific_state_plot <- ggplot(data = lyme_state[lyme_state$state == state, ],
                              aes(x = year, y = incidence.per.1000)) +
  geom_line() +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5)) + # centre title
  labs(x = "Year", y = "Incidence/1,000", title = state)
specific_state_plot # display plot
# ggsave("specific_state_plot.png", specific_state_plot) # save plot to working directory
