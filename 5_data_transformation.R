library(nycflights13)
library(tidyverse)

# 5.2 filter
# filterで欲しい列の要素の条件を指定するとそのデータセットが手に入る
# 変数に代入することもできる
jan1 <- filter(flights, month == 1, day == 1)

# comparisons
# 演算子を上手く使って効率的にフィルタしよう
filter(flights, month==11 | month == 12)

# 短く書く
# x %in% yで、ｙにベクトルを入れると、xで指定した列のy要素をそれぞれ指定できる
nov_dec <- filter(flights, month %in% c(11, 12))

df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)

# exercises
# 1-1)
flights
filter(flights, arr_delay>=2)

#1-2)
?flights
flights$dest
filter(flights, dest %in% c("IAH", "HOU"))

# 1-3)
filter(flights, carrier %in% c("DL", "AA"))
flights$carrier





