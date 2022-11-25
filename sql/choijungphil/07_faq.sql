-- 숫자1은 userNo



insert into faq 
values(seq_faq_no.nextval, 1,'그룹장이 퇴사를 할 때 권한을 위임하지 않았습니다. 데이터를 가져올 수 있나요?', '데이터는 이메일과 그룹명을 보내주시면 복구해드립니다.',  'quest');
insert into faq 
values(seq_faq_no.nextval, 1,'제가 먹은 가게가 검색해도 나오지 않아요.', '해당 가게는 신설된 가게라 정기 업데이트 때 추가될 예정입니다.', 'quest');
insert into faq 
values(seq_faq_no.nextval, 1,'고객센터가 전화를 받지 않아요', '고객센터는 09:00 ~ 16:00 시까지 운영하기 때문에 이외의 시간에 연락하시면 고객센터가 전화를
														받지 못할 수 있습니다.' , 'quest');

insert into faq 
values(seq_faq_no.nextval, 1,'권한 관련','그룹장이 부재 중일 경우를 대비해 부그룹장을 설정할 수 있습니다.' , 'help');
insert into faq 
values(seq_faq_no.nextval, 1,'계정 관련','사이트탈퇴 기능은 없습니다.' , 'help');
insert into faq 

values(seq_faq_no.nextval, 1,'그룹 관리','그룹장이 모든 권한을 가집니다.' , 'help');
insert into faq 
values(seq_faq_no.nextval, 1,'전체 통계','개인통계기능은 지원하지 않습니다.' , 'help');


commit;
