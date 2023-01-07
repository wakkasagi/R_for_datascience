library(tidyverse)

# EDAにおいて役に立つ質問
# (1)変数内で発生する変動の種類は何か？
# (2)変数間で発生する共変の種類は何か？

#7.3 variation(変動):誤差など
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

ggplot(data = smaller, mapping = aes(x = carat, colour = cut)) +
  geom_freqpoly(binwidth = 0.1)

# 7.3.2 typical values
# 最も一般的な値はどれか，そしてそれはなぜか
# どの値がまれなのか，そしてそれはなぜか，その結果は期待と整合しているのか
# 普通ではない傾向はみられるか，それはどう説明されるか
# 下に示すヒストグラムは興味深い疑問を投げかける，すなわち
# 沢山存在するカラット数と少数しかないカラット数が存在するのはなぜか
# 各カラットのピークが左右対称でないのはなぜか
# なぜ3カラット以上のダイアモンドは存在しないのか
ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.01)

# データ中のクラスタ→データにサブグループが存在することを示唆する
# イエローストーン国立公園の山の噴火の長さ
ggplot(data = faithful, mapping = aes(x = eruptions)) +
  geom_histogram(binwidth = 0.25)

# 外れ値
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = y), binwidth = 0.5)
# 外れ値を見るため，縦軸を絞り込む
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))

# 7.3 演習
?diamonds
# 1)
#x->length, y->width, z->depth
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = x), binwidth = 1)
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = y), binwidth = 1) +
  coord_cartesian(xlim = c(0,10))
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = z), binwidth = 1) +
  coord_cartesian(xlim = c(0, 7))
ggplot(diamonds) +
  geom_point(mapping = aes(x = x, y = y))

# 2)
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = price), binwidth = 1000)

# 3) 0.99 -> 23, 1 ->  1558 誤差？
diamonds %>%
  count(carat==1)

# 4)
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = y)) +
  coord_cartesian(ylim = c(0, 5000))
                  