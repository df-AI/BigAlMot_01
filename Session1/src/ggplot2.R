# ref. https://r4ds.had.co.nz/data-visualisation.html
# 최종적인 목표 그래프 
install.packages("ggplot2")
library(ggplot2)

# step 1. 데이터 불러오기
data('mtcars')
help(mtcars) # 로컬 데이터 셋 이해하기

# step 2. 데이터 전처리하기 (r-base 함수 이용)
mtcars$'car name' <- rownames(mtcars) # 자동차 이름을 만드는 칼럼
mtcars$mpg_z <- round((mtcars$mpg - mean(mtcars$mpg))/sd(mtcars$mpg), 2) # mpg 정규화 
mtcars$mpg_type <- ifelse(mtcars$mpg_z < 0, "below", "above") # above vs below
mtcars <- mtcars[order(mtcars$mpg_z), ] # 데이터 정렬
mtcars$`car name` <- factor(mtcars$`car name`, levels = mtcars$`car name`) # 데이터 정렬 후 차량이름으로 범주화 함

# step 3.1 막대 그래프 그리기
ggplot(mtcars, aes(x = `car name`, y = mpg_z, label = mpg_z)) + 
  geom_bar(stat = "identity", aes(fill = mpg_type), width = .5) + 
  scale_fill_manual(name = "Mileage", 
                    labels = c("Above Average", "Below Average"), 
                    values = c("above" = "#00ba38", "below" = "#f8766d")) + 
  labs(subtitle = "Normalised Mileage from 'mtcars'", 
       title = "Diverging Bars") + 
  coord_flip()

# step 3.2 Z-score 표시하기
ggplot(mtcars, aes(x = `car name`, y = mpg_z, label = mpg_z)) + 
  geom_point(stat = "identity", aes(col = mpg_type), size = 10) + 
  scale_color_manual(name = "Mileage", 
                    labels = c("Above Average", "Below Average"), 
                    values = c("above" = "#00ba38", "below" = "#f8766d")) + 
  geom_text(color = "white", size = 5) + 
  labs(subtitle = "Normalised Mileage from 'mtcars'", 
       title = "Diverging Bars") + 
  coord_flip()

# Let's begin
data(mpg)
## help(mpg)
str(mpg)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# 1. 기본 템플릿
# ggplot(data = <DATA>) + 
  # <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

# 2. Aesthetic Mappings
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class), size = 5)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
# Warning message:
# Using size for a discrete variable is not advised. 

# 위 두 그래프의 차이는 무엇일까? 그래프의 기본, 독자가 쉽게 이해해야 한다. 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

ggplot(data=mpg, aes(x=displ, y=hwy, shape=class))+
  geom_point() +
  scale_shape_manual(values=seq(0,15))

?geom_point
# SUV에는 표시가 되지 않는다. 어떻게 표현할 것인가? shape 모양은 무엇인가? 
# stackoverflow를 활용하자
# https://stackoverflow.com/questions/16813278/cycling-through-point-shapes-when-more-than-6-factor-levels

df_shapes <- data.frame(shape = 0:24)
ggplot(df_shapes, aes(x = 0, y = 0, shape = shape)) +
  geom_point(aes(shape = shape), size = 5, fill = 'red') +
  scale_shape_identity() +
  facet_wrap(~shape) +
  theme_void()

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class)) + 
  scale_shape_manual(values = seq(0, 7))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, 
                           y = hwy, 
                           colour = displ > 4))

# 3. 에러와 친숙해지기
ggplot(data = mpg)
+ geom_point(mapping = aes(x = displ, y = hwy))
# Error: Cannot use `+.gg()` with a single argument. Did you accidentally put + on a new line?

# Option. 현재 사용중인 메모리 체크 함수
myMemory <- function(x) {
  format(object.size(get(x)), units = "auto")
}
sort(sapply(ls(), myMemory))

# 4. Facets <- 범주형 변수별로 그래프를 그릴 때 사용
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, ncol = 2) # nrow = 2

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

# 5. geom = Geometrical Object
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

# ggplot2 30개 이상의 geom 지원하고 있음
# 구체적인 설명서는 https://ggplot2.tidyverse.org/reference/

# 6. 변수의 종류에 따른 시각화 기법
# (1) 수량형 변수 1개일 때
install.packages("gapminder")
library(gapminder)
data("gapminder")
help("gapminder")

# 데이터 셋 구조 파악
str(gapminder)
ggplot(gapminder, aes(x = gdpPercap)) + 
  geom_histogram(bins = 30) + 
  scale_x_log10()

ggplot(gapminder, aes(x = gdpPercap)) + 
  geom_freqpoly(bins = 30) # + 
# scale_x_log10()

ggplot(gapminder, aes(x = gdpPercap)) + 
  geom_density(bins = 30) # + 
# scale_x_log10()

ggplot(gapminder, aes(x = gdpPercap)) + 
  geom_histogram(aes(y = ..density..), fill = "white", colour = "black", bins = 30) + 
  geom_density(bins = 30, fill = "red", alpha = .2) + 
  scale_x_log10()

# (2) 범주형 변수 1개일 때
data("diamonds")
help("diamonds")
str(diamonds)
ggplot(diamonds, aes(x = cut)) + 
  geom_bar()

# 각각의 개수를 알고 싶을 때
table(diamonds$cut)

# 각각의 비율을 알고 싶을 때
round(prop.table(table(diamonds$cut)), 2)

# (3) 수량형 변수가 2개일 때 + 산점도 (여러개의 중복된 관측치가 있을 때)
ggplot(diamonds, aes(x = carat, y = price)) + 
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_jitter()

# (4) 수량형 변수와 범주형 변수
ggplot(mpg, aes(x = class, y = hwy)) + 
  geom_boxplot()

library(dplyr)
ggplot(mpg %>% mutate(class = reorder(class, hwy, median)), aes(x = class, y = hwy)) + 
  geom_boxplot()

ggplot(mpg %>% 
         mutate(class = reorder(class, -hwy, median)), aes(x = class, y = hwy)) + 
  geom_boxplot()

# (5) 두 범주형 변수 -- 거의 없음
# Mosaic Plot Example
library(vcd)
help("HairEyeColor")
str(HairEyeColor)
mosaic(Titanic, shade=TRUE, legend=TRUE)

# 자료 더 보기
# http://www.cookbook-r.com/

# 공통 시각화 할 때 유의점
# (1) 독자가 이해하기 쉽게 만들자 (R + PowerPoint)
# (2) R을 쓰는 목적은 복잡한 데이터를 빠른 시간에 쉽게 이해하기 위한 것
# (3) R 시각화 시, 그래프를 더 꾸미기 위해서면 Theme 사용법을 익혀야 한다. 
# (4) ggplot2외 다른 동적인 그래프 plotly를 찾고 활용하자. 
# 예시 (https://plot.ly/r/line-charts/)
install.packages("plotly")
library(plotly)

trace_0 <- rnorm(1000, mean = 5)
trace_1 <- rnorm(1000, mean = 0)
trace_2 <- rnorm(1000, mean = -5)
x <- c(1:1000)

data <- data.frame(x, trace_0, trace_1, trace_2)

plot_ly(data, x = ~x, y = ~trace_0, name = 'trace 0', type = 'scatter', mode = 'lines') %>%
  add_trace(y = ~trace_1, name = 'trace 1', mode = 'lines+markers') %>%
  add_trace(y = ~trace_2, name = 'trace 2', mode = 'markers')

