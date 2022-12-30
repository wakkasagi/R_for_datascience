library(nycflights13)
library(Lahman)
library(tidyverse)

# ニューヨークから出発した飛行機のデータ（2013年）
?flights

# dplyrの主要関数
# 特定の条件に応じたデータを取得する
filter()
# 行を並び替える
arrange()
# 名前を指定して変数を取り出す
mutate()
# 多くの値をひとつの概要にまとめる
summarise()

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


# 5-3 Arrange rows with arrange()
# arrange：行を並び替える
arrange(flights, year, month, day)
# desc()：降順並べ替え
arrange(flights, desc(dep_delay))
# NAは行の最後にまとめられる
df <- tibble(x = c(5, 2, NA))
arrange(df, x)

#5.3.1 exercises
#1
arrange(df, desc(is.na(x)))
arrange(flights, desc(is.na(dep_delay)))
#2
arrange(flights, -desc(dep_delay))
#3
arrange(flights, desc(air_time))
#4
arrange(flights, desc(distance))
arrange(flights, -desc(distance))

#5.4 select()
# 名前を指定して列を取得する
select(flights, year, month, day)

# コロンで挟まれた列の要素を取得する。マイナスをつけるとそれ以外
select(flights, year:day)
select(flights, -(year:day))

rename(flights, tail_num=tailnum)

# 指定した列を先頭に持ってくる（everything()）
select(flights, time_hour, air_time, everything())

# 5.4.1 exercises
select(flights, dep_time, dep_delay, arr_time, arr_delay, everything())
select(flights, dep_time, dep_time)
vers <- c("year", "month", "day", "dep_delay", "arr_delay")
select(flights, any_of(vers))
select(flights, contains("TIME"))

# 5.5
flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time
                      )
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time * 60)

#5.5.1 useful creation functions
# mutate()で挿入する要素はベクトルである必要がある
transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100
          )
# lead:後ろにデータをずらす，lag：前にデータをずらす
# どんな場面で役に立つのか？
(x <- 1:10)
lead(x)
lag(x)

# 隣同士を次々に足していく
cumsum(x)
# 隣同士の平均を並べる
cummean(x)

# ranking
y <- c(1, 2, 2, NA, 3, 4)
min_rank(y)

# 5.6:summarise()
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

# summarise()はgroup_by()と組み合わせて使うことで便利になる
# 日ごとの平均遅れ時間でデータをまとめる
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

# 5.6.1 pipeを使って複数の操作をまとめて書く
# 距離と平均遅延との関係を見る
by_dest <- group_by(flights, dest)
delay <- summarise(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
                   )
delay <- filter(delay, count > 20, dest != "HNL")

# 目的地まで750マイルの範囲で遅延が増えているように見え，その後遅延が減っている
# フライトが長距離になればなるほど，遅延を修正する能力があるのかもしれない
ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

# pipe演算子を使ってもっと簡単に書く
delays <- flights %>%
  group_by(dest) %>%
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 20, dest != "HNL")

ggplot(data = delays, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

# 5.6.2 Missing values:na.rm = TRUE/FALSE
flights %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay, na.rm = TRUE))

# NAのデータはキャンセルされたフライトを代表すると考えよう
# まずキャンセルされたフライトを削除することで問題に取り組むこともできる
not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay))

# 5.6.3 Counts
delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarise(
    delay = mean(arr_delay)
  )

ggplot(data = delays, mapping = aes(x = delay)) +
  geom_freqpoly(binwidth = 10)

delays <- not_cancelled %>%
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )
ggplot(data = delays, mapping = aes(x = n, y = delay)) +
  geom_point(alpha = 1/10)

delays %>%
  filter(n>25) %>% 
  ggplot(mapping = aes(x = n, y = delay)) +
  geom_point(alpha = 1/10)

# 野球データの分析:打率（ヒット数/打席数）と平均成績との関係
# ba:打率，ab:ボールを打つ機会（打席数）
batting <- as_tibble(Lahman::Batting)

batters <- batting %>% 
  group_by(playerID) %>% 
  summarise(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )

batters %>%
  filter(ab > 100) %>% 
  ggplot(mapping = aes(x = ab, y = ba)) +
  geom_point() +
  geom_smooth(se=FALSE)

batters %>% 
  arrange(desc(ba))

# 5.6.4 useful summary functions
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay>0])
  )

# なぜいくつかの目的地への距離は他の変数よりも変動があるのか？
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  mutate(r = min_rank(desc(dep_time))) %>% 
  filter(r %in% range(r))


