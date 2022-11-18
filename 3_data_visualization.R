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









