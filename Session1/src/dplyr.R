install.packages("nycflights13")
library(nycflights13)
data("flights")
help("flights")
flights
# 데이터 전처리
# 행 선택 함수 (filter()).
# 정렬 함수 (arrange()).
# 열 선택 함수 (select()).
# 변수 변환 함수 (mutate()).
# 요약 함수 (summarise()).

# 1. 행 선택 함수
filter(flights, month == 1, day == 1)
jan1 <- filter(flights, month == 1, day == 1)
jan1

(dec25 <- filter(flights, month == 12, day == 25))

# 1.1 logical operators
filter(flights, month == 11 | month == 12) # <- 의미는?
filter(flights, month %in% c(11, 12)) # <- 의미는?

# 2. 정렬함수
arrange(flights, year, month, day)
arrange(flights, desc(dep_delay))

# Missing Values
df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))
?tibble; ?data.frame

# 3. 선택함수
select(flights, year, month, day)
select(flights, year:day)
select(flights, -(year:day))
# starts_with("abc")
# ends_with("xyz")
# contains("ijk")

select(flights, starts_with("arr_"))
select(flights, -year)
select(flights, year)

# 4. 변환함수
flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time)
# 기존 변수 + 새로 생성된 변수 함께
mutate(flights_sml, 
       gain = dep_delay - arr_delay, 
       speed = distance / air_time * 60, 
       hours = air_time / 60, 
       gain_per_hour = gain / hours)

# 새로 생성된 변수만
transmute(flights,
          gain = dep_delay - arr_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)

# 5. 요약 함수 summarise()
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

# 6. pipe (%>%)
by_dest <- group_by(flights, dest)
delay <- summarise(by_dest, 
                   count = n(), 
                   dist = mean(distance, na.rm = TRUE), 
                   delay = mean(arr_delay, na.rm = TRUE))
delay <- filter(delay, count > 20, dest != "HNL")
ggplot(data = delay, mapping = aes(x = dist, y = delay)) + 
  geom_point(aes(size = count), alpha = 1/3) + 
  geom_smooth(se = FALSE)

flights %>% 
  group_by(dest) %>% 
  summarise(count = n(), 
            dist = mean(distance, na.rm = TRUE), 
            delay = mean(arr_delay, na.rm = TRUE)) %>% 
  filter(count > 20, dest != "HNL") %>% 
  ggplot(data = delay2, mapping = aes(x = dist, y = delay)) + 
    geom_point(aes(size = count), alpha = 1/3) + 
    geom_smooth(se = FALSE)
