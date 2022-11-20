library(tidyverse)

# プロットの色を変える
ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ, y=hwy), color="blue")

# ex2) Which variables in mpg are categorical? Which variables are continuous? (Hint: type ?mpg to read the documentation for the dataset). How can you see this information when you run mpg?
?mpg
mpg

# ex3) Map a continuous variable to color, size, and shape. How do these aesthetics behave differently for categorical vs. continuous variables?
# categorical
ggplot(data=mpg)+
  geom_point(mapping=aes(x=hwy, y=displ), color="blue")
ggplot(data=mpg)+
  geom_point(mapping=aes(x=hwy, y=displ, size=class))
# ex4)
ggplot(data=mpg)+
  geom_point(mapping=aes(x=class, y=class))

# ex5)
ggplot(data=mpg)+
  geom_point(mapping=aes(x=hwy, y=displ), colour=displ < 5)

# 3.5 facets
# カテゴリカル変数の要素ごとに、散布図を書きたいとき:
# facet_wrap(~カテゴリカル変数名, nrow=行数)
# ex) 燃費とエンジンの大きさの関係を、classごとに見る
ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ, y=hwy)) +
  facet_wrap(~class, nrow=2)

#2つ以上のカテゴリカル変数の要素ごとに、散布図を書きたいとき：
# facet_grid(変数~変数)
# ex) エンジン気筒（4, 5, 6, 8）と駆動（前輪f、後輪r、四駆4）ごとに見る
ggplot(data=mpg) +
  geom_point(mapping=aes(x=hwy, y=displ)) +
  facet_grid(drv~cyl)

# Exercises
ggplot(data=mpg) +
  geom_point(mapping=aes(x=hwy, y=displ)) +
  facet_wrap(~cty, nrow=2)

ggplot(data=mpg) +
  geom_point(aes(x=drv, y=cyl))

ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ, y=hwy)) +
  facet_grid(drv ~ .)

ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ, y=hwy)) +
  facet_grid(. ~ cyl)

# ex6) more unique levels in the columns...??
# 列の要素が多すぎるとスペースが圧迫されて見にくくなるから？
# -> 正しいらしい（https://jrnold.github.io/r4ds-exercise-solutions/data-visualisation.html）

# 3.6 Geometric objects
# geom: グラフの形を規定する（ex:散布図geom_point, 回帰geom_smooth）
# 変数の要素ごとに回帰線を描画：  linetype
# ex
ggplot(data=mpg) +
  geom_smooth(mapping=aes(x=displ, y=hwy, linetype=drv))
















