--************************************************************************************************************
--************************************************ 삭제 ******************************************************
--************************************************************************************************************




--============================ 시퀀스 삭제 ============================
--===== 리뷰 =====
drop sequence seq_report_cate_no;
drop sequence seq_report_no;
drop sequence seq_review_no;
drop sequence seq_visited_no;

--===== 알림 =====
drop sequence seq_noti_type;
drop sequence seq_noti_no;

--===== 투표 =====
drop sequence seq_vote_member_no;
drop sequence seq_vote_no;
drop sequence seq_random_no;

--===== 메뉴 =====
drop sequence seq_menu_no;
drop sequence seq_menu_2nd_cate_no;
drop sequence seq_menu_1st_cate_no;

--===== 가게 =====
drop sequence seq_store_no;

--===== 그룹 =====
drop sequence seq_black_no;
drop sequence seq_group_member_no;
drop sequence seq_group_no;

--===== 유저 =====
drop sequence seq_faq_no;
drop sequence seq_reply_no;
drop sequence seq_inquiry_no;
drop sequence seq_user_no;






--======================= fk제약조건 제거 ================================
--=============== 리뷰 테이블 ==================================
--===== 신고하기 =====
alter table report 
drop constraint report_user_no;
alter table report 
drop constraint report_review_no;
alter table report 
drop constraint report_cate_no;

--===== 리뷰 =====
alter table review 
drop constraint review_visited_no;
alter table review 
drop constraint review_user_no;

--===== 방문한 곳 =====
alter table visited 
drop constraint visited_menu_no;
alter table visited 
drop constraint visited_store_no;
alter table visited 
drop constraint visited_group_no;
alter table visited 
drop constraint visited_user_no;



--=============== 알림 테이블 ==================================
--===== 알림 =====
alter table notification 
drop constraint notification_noti_type;
alter table notification 
drop constraint notification_user_no;


--=============== 투표 테이블 ==================================
alter table vote_members 
drop constraint vote_members_vote_no;

--===== 투표 =====
alter table vote 
drop constraint vote_group_no;
alter table vote 
drop constraint vote_vote_made_user;

--===== 투표 =====
alter table random 
drop constraint random_user_no;



--=============== 메뉴 테이블 ==================================
--===== 음식메뉴 =====
alter table menu 
drop constraint menu_menu_2nd_cate_no;

--===== 음식 세부분류 =====
alter table food_2nd_category 
drop constraint food_2nd_category_1st_cate_no;


--=============== 가게 테이블 ==================================
--===== 타사별점 =====
alter table rating_others 
drop constraint rating_others_store_no;

--===== 음식점 =====
alter table store 
drop constraint store_menu_2nd_cate_no;


--=============== 그룹 테이블 ==================================
--===== 블랙리스트 =====
alter table blacklist 
drop constraint blacklist_group_no;
alter table blacklist 
drop constraint blacklist_store_no;

--===== 그룹멤버 =====
alter table group_member 
drop constraint group_member_group_no;
alter table group_member 
drop constraint group_member_user_no;


--=============== 유저 테이블 ==================================
--===== FAQ =====
alter table faq 
drop constraint faq_user_no;

--===== 문의_답변하기 =====
alter table reply_inquiry 
drop constraint reply_inquiry_inquiry_no;

--===== 문의하기 =====
alter table inquiry 
drop constraint inquiry_user_no;



--**********************************************************************************************************


--======================= 테이블 삭제 ================================
--===== 유저 =====
DROP TABLE faq;
DROP TABLE reply_inquiry;
DROP TABLE inquiry;
DROP TABLE users;

--===== 그룹 =====
DROP TABLE blacklist;
DROP TABLE group_member;
DROP TABLE groups;

--===== 가게 =====
DROP TABLE rating_others;
DROP TABLE store;

--===== 메뉴 =====
DROP TABLE menu;
DROP TABLE food_2nd_category;
DROP TABLE food_1st_category;

--===== 투표 =====
DROP TABLE vote_members;
DROP TABLE vote;
DROP TABLE random;

--===== 알림 =====
DROP TABLE noti_no;
DROP TABLE notification;

--===== 리뷰 =====
DROP TABLE report_cate;
DROP TABLE report;
DROP TABLE review;
DROP TABLE visited;







--************************************************************************************************************
--************************************************ 생성 ******************************************************
--************************************************************************************************************








--======================= 테이블 생성 ================================
--======================= 유저 테이블=======================
--===== 회원 =====
CREATE TABLE users (
 user_no number(20) NOT NULL, 
 user_email varchar2(200) unique NULL, 
 user_password varchar2(200) NULL, 
 user_name varchar2(200) NOT NULL, 
 user_birth_year number(20) NOT NULL, 
 user_sex varchar2(20) NOT NULL, 
 user_joindate DATE NULL, 
 user_grade varchar2(50) DEFAULT 1 NOT null, 
 session_id varchar2(100) default 'none' not null, 
 limit_date timestamp null, 
 sns_login VARCHAR2(200) null,
 user_state number(20) DEFAULT 0 NOT null
);

--===== 문의하기 =====
CREATE TABLE inquiry (
 inquiry_no number(20) NOT NULL, 
 user_no number(20) NOT NULL, 
 inquiry_title varchar2(200) NOT NULL, 
 inquiry_content  varchar2(4000) NOT NULL, 
 inquiry_file_path varchar2(500) NULL, 
 inquiry_date date NOT NULL, 
 inquiry_status varchar2(20) DEFAULT '접수' NOT null
);

--===== 문의_답변하기 =====
CREATE TABLE reply_inquiry (
 reply_no number(20) NOT NULL, 
 inquiry_no number(20) NOT NULL, 
 reply_content varchar2(4000) NOT null 
);

--===== FAQ =====
CREATE TABLE faq (
 faq_no number(20) NOT NULL, 
 user_no number(20) NOT NULL, 
 faq_title varchar2(200) NOT NULL, 
 faq_content varchar2(4000) not NULL, 
 faq_status varchar2(20) NOT NULL 
);


--======================= 그룹 테이블=======================
--===== 그룹 =====
CREATE TABLE groups (
 group_no number(20) NOT NULL, 
 group_leader number(20) NOT NULL, 
 group_name varchar2(200) NOT null
);

--===== 그룹멤버 =====
CREATE TABLE group_member (
 group_member_no number(20) not null, 
 user_no number(20) NULL, 
 group_no number(20) NOT NULL, 
 boss_check number(10) DEFAULT 0 not null,
 group_order number(20) not null
);

--===== 블랙리스트 =====
CREATE TABLE blacklist (
 black_no number(20) NOT NULL, 
 store_no number(20) NOT NULL, 
 group_no number(20) NOT null,
 reg_date date not null
);

--======================= 가게 테이블=======================
--===== 음식점 =====
CREATE TABLE store (
 store_no number(20) NOT NULL, 
 menu_2nd_cate_no number(20) NOT NULL, 
 store_name varchar2(100) NOT NULL, 
 store_x number(13,10) NOT NULL, 
 store_y number(13,10) NOT NULL, 
 store_road_address varchar2(200) NULL, 
 store_old_address varchar2(200)  NULL, 
 store_opening_hours varchar2(500)  NULL, 
 store_breaktime varchar2(500)  NULL
);


--===== 타사별점 =====
CREATE TABLE rating_others (
 store_no number(20) NOT NULL, 
 rating_naver number(20,3) null, 
 rating_kakao number(20,3) null, 
 rating_google number(20,3) null 
);


--======================= 메뉴 테이블=======================
--===== 음식 대분류 =====
CREATE TABLE food_1st_category (
 menu_1st_cate_no number(20) NOT NULL,  
 menu_1st_cate_name varchar2(200) NOT null
);

--===== 음식 세부분류 =====
CREATE TABLE food_2nd_category (
 menu_2nd_cate_no number(20) NOT NULL,
 menu_1st_cate_no number(20) NOT NULL,
 menu_2nd_cate_name varchar2(200) NOT null
);

--===== 음식메뉴 =====
CREATE TABLE menu (
 menu_no number(20) NOT NULL, 
 menu_2nd_cate_no number(20) NOT NULL, 
 menu_name varchar2(200) NOT null
);

--======================= 투표 테이블=======================
--===== 랜덤 =====
create table random (
    random_no number(20) not null, 
    user_no number(20) not null, 
    store_info varchar2(3000) not null, 
    stop_at_value number(20) not null, 
    group_name varchar2(200) not null, 
    result_time DATE not null
);


--===== 투표 =====
CREATE TABLE vote (
 vote_no number(20) NOT NULL,
 vote_made_user number(20) NOT NULL,
 group_no number(20) NOT NULL,
 vote_end_time DATE NOT NULL,
 vote_items varchar2(3000) not null,
 vote_results varchar2(1000) not NULL,
 vote_state number(20) DEFAULT 1 NOT NULL, 
 curr_x number(13,10) NOT NULL, 
 curr_y number(13,10) NOT NULL
);

--===== 투표하는 그룹 =====
CREATE TABLE vote_members (
 vote_member_no number(20) NOT NULL,
 vote_no number(20) NOT NULL,
 user_no number(20) NULL,
 user_name varchar2(200) NOT NULL,
 vote_voted number(20) DEFAULT 0 NOT NULL, 
 vote_ip varchar2(500) null
);


--======================= 알림 테이블=======================
--===== 알림 =====
CREATE TABLE notification (
 noti_no number(20) NOT NULL,
 user_no number(20) NOT NULL,
 noti_type number(20) NOT null,
 group_no number(20) DEFAULT 0 null, 
 send_user number(20) DEFAULT 0 null, 
 report_no number(20) DEFAULT 0 null, 
 reply_no number(20) DEFAULT 0 null, 
 alert_comment varchar2(400) null, 
 noti_state number(20) DEFAULT 0 NOT NULL
);

--===== 알림_일련번호 =====
CREATE TABLE noti_no (
 noti_type  number(20) NOT NULL,
 noti_name varchar2(200) NOT NULL
);



--======================= 리뷰 테이블=======================
--===== 방문한 곳 =====
CREATE TABLE visited (
 visited_no number(20) NOT NULL, 
 user_no number(20) NULL, 
 group_no number(20) NULL, 
 store_no number(20) NULL, 
 menu_no number(20) NULL, 
 visited_date DATE NOT NULL
);

--===== 리뷰 =====
CREATE TABLE review (
 review_no number(20) NOT NULL,
 user_no number(20) NOT NULL,
 visited_no number(20) NOT NULL,
 review_content varchar2(4000) NULL,
 user_score number(20) DEFAULT 0 NOT NULL,
 review_file_name varchar2(500) NULL,
 review_reported number(10) DEFAULT 0 NOT null
);

--===== 신고하기 =====
CREATE TABLE report (
 report_no number(20) NOT NULL,
 report_cate_no number(20) NOT NULL,
 review_no number(20) NOT NULL,
 user_no number(20) NOT NULL,
 report_stat number(10) DEFAULT 0 NOT null
);

--===== 신고 카테고리 =====
CREATE TABLE report_cate (
 report_cate_no number(20) NOT NULL,
 report_cate_name varchar2(200) NOT null 
);








--======================= PK 제약조건 부여 ================================
--===== 유저 =====
ALTER TABLE users ADD CONSTRAINT user_no_pk PRIMARY KEY (user_no);
ALTER TABLE inquiry ADD CONSTRAINT inquiry_no_pk PRIMARY KEY (inquiry_no);
ALTER TABLE reply_inquiry ADD CONSTRAINT reply_no_pk PRIMARY KEY (reply_no);
ALTER TABLE faq ADD CONSTRAINT faq_no_pk PRIMARY KEY (faq_no);

--===== 그룹 =====
ALTER TABLE groups ADD CONSTRAINT group_no_pk PRIMARY KEY (group_no);
ALTER TABLE group_member ADD CONSTRAINT group_member_no_pk PRIMARY KEY (group_member_no);
ALTER TABLE blacklist ADD CONSTRAINT black_no_pk PRIMARY KEY (black_no);

--===== 가게 =====
ALTER TABLE store ADD CONSTRAINT store_no_pk PRIMARY KEY (store_no);

--===== 메뉴 =====
ALTER TABLE food_1st_category ADD CONSTRAINT menu_1st_cate_no_pk PRIMARY KEY (menu_1st_cate_no);
ALTER TABLE food_2nd_category ADD CONSTRAINT menu_2nd_cate_no_pk PRIMARY KEY (menu_2nd_cate_no);
ALTER TABLE menu ADD CONSTRAINT menu_no_pk PRIMARY KEY (menu_no);

--===== 투표 =====
ALTER TABLE random ADD CONSTRAINT random_no_pk PRIMARY KEY (random_no);
ALTER TABLE vote ADD CONSTRAINT vote_no_pk PRIMARY KEY (vote_no);
ALTER TABLE vote_members ADD CONSTRAINT vote_member_no_pk PRIMARY KEY (vote_member_no);

--===== 알림 =====
ALTER TABLE notification ADD CONSTRAINT noti_no_pk PRIMARY KEY (noti_no);
ALTER TABLE noti_no ADD CONSTRAINT noti_type_pk PRIMARY KEY (noti_type);

--===== 리뷰 =====
ALTER TABLE visited ADD CONSTRAINT visited_no_pk PRIMARY KEY (visited_no);
ALTER TABLE review ADD CONSTRAINT review_no_pk PRIMARY KEY (review_no);
ALTER TABLE report ADD CONSTRAINT report_no_pk PRIMARY KEY (report_no);
ALTER TABLE report_cate ADD CONSTRAINT report_cate_no_pk PRIMARY KEY (report_cate_no);








--=============== FK 제약조건 부여 ========================================
--=============== 유저 테이블 ========================================
--===== 문의하기 =====
ALTER table inquiry 
add constraint inquiry_user_no FOREIGN KEY (user_no) REFERENCES users(user_no) ON DELETE CASCADE;

--===== 문의_답변하기 =====
ALTER table reply_inquiry 
add constraint reply_inquiry_inquiry_no FOREIGN KEY (inquiry_no) REFERENCES inquiry(inquiry_no) ON DELETE CASCADE;

--===== FAQ =====
ALTER table faq
add constraint faq_user_no FOREIGN KEY (user_no) REFERENCES users(user_no) ON DELETE CASCADE;


--=============== 그룹 테이블 ========================================
--===== 그룹멤버 =====
ALTER TABLE group_member 
add constraint group_member_user_no FOREIGN KEY (user_no) REFERENCES users(user_no) ON DELETE CASCADE;
ALTER TABLE group_member 
add constraint group_member_group_no FOREIGN KEY (group_no) REFERENCES groups(group_no) ON DELETE CASCADE;

--===== 블랙리스트 =====
ALTER TABLE blacklist 
add constraint blacklist_store_no FOREIGN KEY (store_no) REFERENCES store(store_no) ON DELETE CASCADE;
ALTER TABLE blacklist 
add constraint blacklist_group_no FOREIGN KEY (group_no) REFERENCES groups(group_no) ON DELETE CASCADE;



--=============== 가게 테이블 ========================================
--===== 음식점 =====
ALTER table store 
add constraint store_menu_2nd_cate_no FOREIGN KEY (menu_2nd_cate_no) REFERENCES food_2nd_category(menu_2nd_cate_no) ON DELETE CASCADE;

--===== 타사별점 =====
ALTER TABLE rating_others 
add constraint rating_others_store_no FOREIGN KEY (store_no) REFERENCES store(store_no) ON DELETE CASCADE;





--=============== 메뉴 테이블 ========================================
--===== 음식 세부분류 =====
ALTER TABLE food_2nd_category 
add constraint food_2nd_category_1st_cate_no FOREIGN KEY (menu_1st_cate_no) REFERENCES food_1st_category(menu_1st_cate_no) ON DELETE CASCADE;

--===== 음식메뉴 =====
ALTER TABLE menu 
add constraint menu_menu_2nd_cate_no FOREIGN KEY (menu_2nd_cate_no) REFERENCES food_2nd_category(menu_2nd_cate_no) ON DELETE CASCADE;



--=============== 투표 테이블 ========================================
--===== 랜덤 =====
ALTER TABLE random 
add constraint random_user_no FOREIGN KEY (user_no) REFERENCES users(user_no) ON DELETE CASCADE;

--===== 투표 =====
ALTER TABLE vote 
add constraint vote_vote_made_user FOREIGN KEY (vote_made_user) REFERENCES users(user_no) ON DELETE CASCADE;
ALTER TABLE vote 
add constraint vote_group_no FOREIGN KEY (group_no) REFERENCES groups(group_no) ON DELETE CASCADE;

--===== 투표하는 그룹 =====
ALTER TABLE vote_members 
add constraint vote_members_vote_no FOREIGN KEY (vote_no) REFERENCES vote(vote_no) ON DELETE CASCADE;


--=============== 알림 테이블 ========================================
--===== 알림 =====
ALTER TABLE notification 
add constraint notification_user_no FOREIGN KEY (user_no) REFERENCES users(user_no) ON DELETE CASCADE;
ALTER TABLE notification 
add constraint notification_noti_type FOREIGN KEY (noti_type) REFERENCES noti_no(noti_type) ON DELETE CASCADE;


--=============== 리뷰 테이블 ========================================
--===== 방문한 곳 =====
ALTER TABLE visited 
add constraint visited_user_no FOREIGN KEY (user_no) references users(user_no) ON DELETE CASCADE;
ALTER TABLE visited 
add constraint visited_group_no FOREIGN KEY (group_no) references groups(group_no) ON DELETE CASCADE;
ALTER TABLE visited 
add constraint visited_store_no FOREIGN KEY (store_no) REFERENCES store(store_no) ON DELETE CASCADE;
ALTER TABLE visited 
add constraint visited_menu_no FOREIGN KEY (menu_no) REFERENCES menu(menu_no) ON DELETE CASCADE;

--===== 리뷰 =====
ALTER TABLE review 
add constraint review_user_no FOREIGN KEY (user_no) REFERENCES users(user_no) ON DELETE CASCADE;
ALTER TABLE review 
add constraint review_visited_no FOREIGN KEY (visited_no) REFERENCES visited(visited_no) ON DELETE CASCADE;

--===== 신고하기 =====
ALTER TABLE report 
ADD constraint report_cate_no FOREIGN KEY (report_cate_no) REFERENCES report_cate(report_cate_no) ON DELETE CASCADE;
ALTER TABLE report 
add constraint report_review_no FOREIGN KEY (review_no) REFERENCES review(review_no) ON DELETE CASCADE;
ALTER TABLE report 
add constraint report_user_no FOREIGN KEY (user_no) REFERENCES users(user_no) ON DELETE CASCADE;






--============================ 시퀀스 생성 ============================
--===== 유저 =====
create sequence seq_user_no 
increment by 1 
start with 1 
nocache;

create sequence seq_inquiry_no 
increment by 1 
start with 1 
nocache;

create sequence seq_reply_no 
increment by 1 
start with 1 
nocache;

create sequence seq_faq_no 
increment by 1 
start with 1 
nocache;


--===== 그룹 =====
create sequence seq_group_no 
increment by 1 
start with 1 
nocache;

create sequence seq_group_member_no 
increment by 1 
start with 1 
nocache;

create sequence seq_black_no 
increment by 1 
start with 1 
nocache;


--===== 가게 =====
create sequence seq_store_no 
increment by 1 
start with 4023 
nocache;


--===== 메뉴 =====
create sequence seq_menu_1st_cate_no 
increment by 1 
start with 11 
nocache;

create sequence seq_menu_2nd_cate_no 
increment by 1 
start with 46 
nocache;

create sequence seq_menu_no 
increment by 1 
start with 1 
nocache;

--===== 랜덤 =====
create sequence seq_random_no 
increment by 1 
start with 1 
nocache;

--===== 투표 =====
create sequence seq_vote_no 
increment by 1 
start with 1 
nocache;

create sequence seq_vote_member_no 
increment by 1 
start with 1 
nocache;


--===== 알림 =====
create sequence seq_noti_no 
increment by 1 
start with 1 
nocache;

create sequence seq_noti_type 
increment by 1 
start with 1 
nocache;


--===== 리뷰 =====
create sequence seq_visited_no 
increment by 1 
start with 1 
nocache;

create sequence seq_review_no 
increment by 1 
start with 1 
nocache;

create sequence seq_report_no 
increment by 1 
start with 1 
nocache;

create sequence seq_report_cate_no 
increment by 1 
start with 1 
nocache;


commit;

