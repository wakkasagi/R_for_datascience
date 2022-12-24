library(nycflights13)
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

# 5.2 Filter rows with filter()
# flightsから1月1日のデータだけを抜き出す
jan1 <- filter(flights, month == 1, day == 1)
