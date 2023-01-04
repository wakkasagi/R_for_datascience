library(tidyverse)

# EDA‚É‚¨‚¢‚Ä–ð‚É—§‚ÂŽ¿–â
# (1)•Ï”“à‚Å”­¶‚·‚é•Ï“®‚ÌŽí—Þ‚Í‰½‚©H
# (2)•Ï”ŠÔ‚Å”­¶‚·‚é‹¤•Ï‚ÌŽí—Þ‚Í‰½‚©H

#7.3 variation(•Ï“®):Œë·‚È‚Ç
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x=cut))

diamonds %>%
  count(cut)

ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)

diamonds %>%
  count(cut_width(carat, 0.5))

smaller <- diamonds %>%
  filter(carat < 3)

ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.1)
