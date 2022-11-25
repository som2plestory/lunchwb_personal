-- 처음부터 해보려면(추천 안해요^^) -- 

1. lunchwb DB에 store, menu, food_2nd_category, food_1st_category, raiting_bujang, raiting_others 테이블 생성

2. lunchwb DB에 seq_menu_2nd_cate_no, seq_1st_cate_no, seq_store_no 시퀀스 생성
(시퀀스 각각 46, 11, 4023부터 시작해야)
CREATE SEQUENCE seq_menu_2nd_cate_no
START WITH 1
INCREMENT BY 1
NOCACHE;

3. 파이참 프로젝트 생성

4. 설정 > 프로젝트 > python 인터프리터 > + 버튼 클릭해서
requests, selenium, chromedriver-autoinstaller, cx_Oracle 모듈 설치하기

5-1 save_cate.py RUN  >  food_2nd_category, food_1st_category 채워짐
5-2 lunchwb_main_crawling.py RUN > store, raiting_others(카카오만) 채워짐, raiting_bujang row 생성
5-3 naver_raitings.py RUN > rating_others raiting_naver 채워짐
5-4 google_raitings.py RUN > rating_others raiting_google 채워짐

6. lunchwb DB에서 데이터 들어갔나 확인 

