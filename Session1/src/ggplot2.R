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
  geom_point(stat = "identity", aes(col = mpg_type), size = 6) + 
  scale_color_manual(name = "Mileage", 
                    labels = c("Above Average", "Below Average"), 
                    values = c("above" = "#00ba38", "below" = "#f8766d")) + 
  geom_text(color = "white", size = 2) + 
  labs(subtitle = "Normalised Mileage from 'mtcars'", 
       title = "Diverging Bars") + 
  coord_flip()

# Let's begin
data(mpg)
help(mpg)
str(mpg)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# 1. 기본 템플릿
# ggplot(data = <DATA>) + 
  # <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

# 2. Aesthetic Mappings
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
?geom_point

# SUV에는 표시가 되지 않는다. 어떻게 표현할 것인가? shape 모양은 무엇인가? 
# 
df_shapes <- data.frame(shape = 0:24)
ggplot(df_shapes, aes(x = 0, y = 0, shape = shape)) +
  geom_point(aes(shape = shape), size = 5, fill = 'red') +
  scale_shape_identity() +
  facet_wrap(~shape) +
  theme_void()

# stackoverflow를 활용하자
# https://stackoverflow.com/questions/16813278/cycling-through-point-shapes-when-more-than-6-factor-levels

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class)) + 
  scale_shape_manual(values = seq(0, 7))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = displ < 3))

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

     