library(tidyverse)

# 小技：Alt + "-"で <- 一発入力
# 小技：複数行選択でctrl＋shift＋Cすると複数行コメントアウト
# 小技：Alt+shift+Kでキーバインドをすべて表示

# ggplotの使い方
# ggplot(data = hoge)で空の座標を作る。"+"で表現したいグラフの種類を追加していく
#テンプレートは、ggplot(data = <DATA>) +<GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))
# ex）自動車データ（mpg）におけるエンジンサイズと燃費の関係を散布図として表現
ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ, y=hwy))

# データの詳細は、データセットの先頭に?を入れることで見られる
# ex
?mpg

# Make a scatterplot of hwy vs cyl
ggplot(data=mpg) +
  geom_point(mapping=aes(x=hwy, y=cyl))

# What happens if you make a scatterplot of class vs drv? Why is the plot not useful?
ggplot(data=mpg) +
  geom_point(mapping=aes(x=class, y=drv))

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
# ex) 「drv」の要素ごとに回帰線を描画する
ggplot(data=mpg) +
  geom_smooth(mapping=aes(x=displ, y=hwy, linetype=drv))

# 1本の回帰線を描画
ggplot(data=mpg) +
  geom_smooth(mapping=aes(x=displ, y=hwy))
# groupの要素ごとに線を描画
ggplot(data=mpg) +
  geom_smooth(mapping=aes(x=displ, y=hwy, group=drv))
# 指定したデータごとに色分け
ggplot(data=mpg) +
  geom_smooth(mapping=aes(x=displ, y=hwy, color=drv),
  show.legend= FALSE
  )
# 2種類のグラフを重ね合わせる
ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ, y=hwy)) +
  geom_smooth(mapping=aes(x=displ, y=hwy))
# ggplotの部分に描くグラフのデータを記述してしまう
ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_point()+
  geom_smooth()
# 指定したカテゴリごとに色分けする
ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_point(mapping=aes(color=class))+
  geom_smooth()
# プロット中の一部のカテゴリにのみ回帰線を描く
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)


ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = TRUE,
  show.legend = TRUE
  )
# se -> 信頼区間を描く：TRUE、描かない：FALSE



# 3.7 Statistical transformations
# geom_bar xを指定すると勝手に縦軸をカウントにする
# dataset->diamonds x軸 
# geom_barが呼ばれると、xに指定された列毎の要素数を集計して新しいテーブルを作り、それに基づく棒グラフを生成する
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x=cut))

# yが既に数値として与えられているときは、yの値を生の値に変更する（stat="identityを指定）。これをしないと、x軸の要素数を出力するので、すべて1になる（列の各要素がひとつずつ値を持つため）
# tribbleは、表形式でデータを与えられる関数。~xxxで列名、その下に各要素を追加していけば良い。小さいデータセットを作るときに使える
demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)
ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat="identity")
ggplot(data=demo) +
  geom_col(mapping = aes(x=cut, y=freq))

# カウントではなく、比率を縦軸に指定する（）
ggplot(data=diamonds) +
  geom_bar(mapping=aes(x=cut, y=stat(prop), group = 1))

# データの取り得る値と中央値をプロットする(stat_summary)
ggplot(data=diamonds) +
  stat_summary(
    mapping = aes(x=cut, y=depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

# after_statは何を出力してる？？
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = after_stat(prop)))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = after_stat(prop)))

# 3.8 Position adjustments
ggplot(data = mpg) +
  geom_point(mapping = aes(x = cty, y = hwy), position="jitter")


# 4.1 Coding basics
this_is_a_really_long_name <- 2.5

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

fliter(mpg, cyl = 8)
filter(diamond, carat > 3)

?mpg


