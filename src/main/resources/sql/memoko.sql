--회원가입 테이블
create table Member
(
    Member_id varchar2(200) primary key,                --회원아이디(이메일)
    Member_pw varchar2(50) Not null,                     --회원PW 
    Member_nickname varchar2(50) Not null,            --회원닉네임
    Member_email varchar2(200) Not null,                --회원이메일
    Member_favorite varchar2(200)                           --회원선호음식
);

--조회
select * from Member;

--등록
insert into Member
(
    Member_id,
    Member_pw,
    Member_nickname,
    Member_email,
    Member_favorite
)
VALUES
(   'miko1234@naver.com',
    'abcd1234',
    '미코',
    'miko1234@naver.com',
    '슈크림'
);

--수정
update
    Member
set
    Member_pw = '1234abcd',
    Member_nickname = '미콩',
    Member_email = '1234miko@naver.com',
    Member_favorite = '브리오슈'
where 
    Member_id = 'miko1234@naver.com';


--삭제
delete
from Member
where Member_id = 'miko1234@naver.com';

------------------------------------------------------------------------------------------------









--레시피 테이블
create table Recipe
(
    Recipe_num number primary key,                      --레시피번호
    Member_id varchar2(200) not null,                     --작성자ID
    Recipe_title varchar2(200) not null,                     --레시피제목
    Recipe_indate date default sysdate,                    --레시피등록날짜
    Recipe_hits number default 0,                            --레시피조회수
    Recipe_likes number default 0,                           --레시피좋아요수
     CONSTRAINTS Recipe_fk FOREIGN KEY (Member_id)
    REFERENCES Member(Member_id) on delete cascade
);
--레시피테이블의 번호 시퀀스
create sequence Recipe_SEQ;

--조회


--등록
insert into Recipe
(

)











--레시피 내용 테이블(사진, 내용)
create table Recipe_content
(
    content_num number not null,                          --레시피내용번호
    Member_id varchar2(200) not null,                     --작성자ID
    Recipe_num number not null,                            --레시피번호
    Recipe_content varchar2(4000) Not null,              --레시피내용
    Recipe_image varchar2(500),                               --레시피이미지
     CONSTRAINTS Recipe_content_fk1 FOREIGN KEY (Recipe_num)
    REFERENCES Recipe(Recipe_num) on delete cascade
);
--레시피 내용 테이블의 번호 시퀀스
create sequence Recipe_content_SEQ;















--레시피 재료 테이블(재료, 양)
create table Recipe_ingrd
(
    Recipe_num number not null,                     --레시피번호
    Member_id varchar2(200) not null,               --작성자ID
    ingrd_num number not null,                            --재료번호
    ingrd_name varchar2(50) not null,                --재료이름
    ingrd_amount varchar2(50) not null,             --재료양
    CONSTRAINTS Recipe_ingrd_fk1 FOREIGN KEY (Recipe_num)
    REFERENCES Recipe(Recipe_num) on delete cascade
);
--레시피 재료  테이블 번호 시퀀스
create sequence Recipe_ingrd_SEQ;

--레시피를 좋아요 한 회원목록
create table Recipe_likes
(
    Recipe_num number not null,
    Member_id varchar2(200) not null,
    CONSTRAINTS Recipe_likes_fk1 FOREIGN KEY (Recipe_num)
    REFERENCES Recipe(Recipe_num) on delete cascade
);
















--리뷰 테이블
create table Review
(
    Review_num number primary key,                      --리뷰번호
    Member_id varchar2(200) not null,                      --작성자ID
    Review_title varchar2(200) not null,                     --리뷰제목
    Review_content varchar2(2000) not null,              --리뷰내용
    Review_image varchar2(500),                               --리뷰이미지(1장)
    Review_indate date default sysdate,                    --리뷰등록날짜
    Review_likes number default 0,                           --리뷰좋아요수
    CONSTRAINTS Review_fk FOREIGN KEY (Member_id)
    REFERENCES Member(Member_id) on delete cascade
);
--리뷰 테이블 번호 시퀀스
create sequence Review_SEQ;

--리뷰를 좋아요 한 회원목록
create table Review_likes
(
    Review_num number not null,                                     --리뷰 번호
    Member_id varchar2(200) not null,                               --작성자 아이디
    CONSTRAINTS Review_likes_fk1 FOREIGN KEY (Review_num)
    REFERENCES Review(Review_num) on delete cascade
);

--리뷰의 리플
create table Review_reply
(
    Reply_num number primary key,                   --리플 번호
    Review_num number not null,                      --리뷰 번호
    Member_id varchar2(200) not null,                --작성자 아이디
    Reply_content varchar2(500) not null,            --리플내용
    Reply_indate date default sysdate,                --리플등록시간
     CONSTRAINTS Review_reply_fk1 FOREIGN KEY (Review_num)
    REFERENCES Review(Review_num) on delete cascade
);
--리뷰 테이블 번호 시퀀스
create sequence Review_reply_SEQ;




