library(dplyr)
# 문제 1. 변수를 추가하자
x <- c(4,6,1,5)
y <- c(3,2,4,1)

df <- data.frame(x, y)
# x2 = x ^ 2, y2 = x ^ 2, z = x2 + y2

# 문제 2. 요약하자
x <- c("P", "Q", "P", "Q")
y <- c(5, 2, 15, 10)
z <- c(4, 1, 7, 8)

df <- data.frame(x, y, z)
# sum_y = 합계, sum_z = 평균 값을 구하자. 

# 문제 3. 그룹핑
city <- c("Boston", "Boston", "NYC", "NYC")
sales <- c(200, 125, 150, 250)

df <- data.frame(city, sales)

# 각 도시의 전체 sales 값을 구하세요.  
