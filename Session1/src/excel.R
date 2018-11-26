install.packages("xlsx")
library(xlsx)

# step 1. 내 환경 Check sessionInfo()
sessionInfo()

# step 2. Java JDK 검색 on 구글 (클릭 - Java SE Development Kit 8)

# step 3. Java JDK 다운로드 (windows 64)
# License 동의 후 본인 컴퓨터 사양에 맞는 윈도우 버전 클릭

# step 4. 경로 확인 (경로 별도 지정 하지 않을 시)
## 32비트에 설치를 하면 보통 (C:/Program Files (x86/Java/) 설치가 될 것이다.
## 64비트에 설치를 하면 보통 (C:/Program Files/Java/) 설치가 될 것이다.
## 설치 시, 보통 4-5분 (사양에 따라 상이함) 소요됩니다.

# step 5. rJava 패키지 설치
install.packages("rJava")
# step 6. 자바 환경 설치
# # Sys.setenv(JAVA_HOME="C:/Program Files/Java/사용자 버전/")
# ex) Sys.setenv(JAVA_HOME="C:/Program Files/Java/jdk-10.0.1/")
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jdk1.8.0_191")
library(rJava)

# step 6. xlsx 패키지 재 설치 및 불러오기
install.packages("xlsx")
library(xlsx)

# step 7. excel 불러오기
getwd() # 현재 경로 불러오기
setwd("C:/Users/dataflow3/Desktop") # 엑셀파일 경로 지정하기
my_data <- read.xlsx("my_excel.xlsx", sheetIndex = 1, encoding = "UTF-8")
my_data

# step 8. excel 내보내기 / 현재 DeskTop 경로에 저장이 됩니다.
write.xlsx(my_data, "RtoExcel.xlsx", sheetName = "Sheet1")