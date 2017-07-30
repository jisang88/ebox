use ebox;

SELECT * FROM tbl_theater 
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.6/Uploads/tbl_theater.txt' 
CHARACTER SET utf8 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '`' 
LINES TERMINATED BY '\n';
	
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.6/Uploads/tbl_theater.txt' 
INTO TABLE tbl_theater 
FIELDS TERMINATED BY ","
ENCLOSED BY '`';

SELECT * FROM tbl_audi 
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.6/Uploads/tbl_audi.txt' 
CHARACTER SET utf8 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '`' 
LINES TERMINATED BY '\n';
	
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 5.6/Uploads/tbl_audi.txt' 
INTO TABLE tbl_audi 
FIELDS TERMINATED BY ","
ENCLOSED BY '`';
	
select * from tbl_theater;
delete from tbl_theater;
ALTER TABLE tbl_theater AUTO_INCREMENT=1; 

select * from tbl_audi;
delete from tbl_audi;
ALTER TABLE tbl_audi AUTO_INCREMENT=1; 


-- 복사 쿼리
INSERT INTO tbl_theater ( tName, tAddrNum, tAddrSt, tManager, tTel)
select  tName, tAddrNum, tAddrSt, tManager, tTel FROM tbl_theater;


-- 영화관
DROP TABLE IF EXISTS tbl_theater RESTRICT;

-- 영화관
CREATE TABLE tbl_theater (
	tNo      INT          NOT NULL, -- 영화관번호
	tName    VARCHAR(30)  NOT NULL, -- 지점
	tAddrNum VARCHAR(200) NOT NULL, -- 지번
	tAddrSt  VARCHAR(200) NULL,     -- 도로명
	tManager VARCHAR(50)  NULL,     -- 담당자
	tTel     VARCHAR(30)  NULL      -- 전화번호
)
DEFAULT CHARACTER SET = 'utf8'
ENGINE = InnoDB;

-- 영화관
ALTER TABLE tbl_theater
	ADD CONSTRAINT PK_tbl_theater -- 영화관 기본키
		PRIMARY KEY (
			tNo -- 영화관번호
		);

ALTER TABLE tbl_theater
	MODIFY COLUMN tNo INT NOT NULL AUTO_INCREMENT;

EXPLAIN SELECT * FROM tbl_theater WHERE tNo = 244;
EXPLAIN SELECT * FROM tbl_theater WHERE tName = '공단';

select * from tbl_theater;
delete from tbl_theater;
ALTER TABLE tbl_theater AUTO_INCREMENT=1; 


select * from tbl_theater where tName ='공단';

select * from tbl_audi;
select count(*) from tbl_audi;
select * from tbl_audi where aName like '%1%';
select * from tbl_audi where floor like '%12%';

delete from tbl_audi;
ALTER TABLE tbl_audi AUTO_INCREMENT=1; 

-- 복사 쿼리
INSERT INTO tbl_audi ( aName, aVType, aSType, aTheme, aThemeSubInfo, floor, refTno)
SELECT aName, aVType, aSType, aTheme, aThemeSubInfo, floor, refTno FROM tbl_audi;

use ebox;


-- 상영관
DROP TABLE IF EXISTS tbl_audi RESTRICT;

-- 상영관
CREATE TABLE tbl_audi (
	aNo           INT         NOT NULL, -- 상영관번호
	aName         VARCHAR(50) NOT NULL, -- 상영관이름
	aVType        VARCHAR(20) NULL,     -- 시각 타입
	aSType        VARCHAR(30) NULL,     -- 사운드 타입
	aTheme        VARCHAR(30) NULL,     -- 테마
	aThemeSubInfo VARCHAR(20) NULL,     -- 테마부가정보
	floor         VARCHAR(20) NULL,     -- 장소
	refTno        INT         NOT NULL  -- 영화관번호
);

-- 상영관
ALTER TABLE tbl_audi
	ADD CONSTRAINT PK_tbl_audi -- 상영관 기본키
		PRIMARY KEY (
			aNo -- 상영관번호
		);

ALTER TABLE tbl_audi
	MODIFY COLUMN aNo INT NOT NULL AUTO_INCREMENT;

	
	
use ebox;
select * from tbl_movie;
delete from tbl_movie;
ALTER TABLE tbl_movie AUTO_INCREMENT=1; 

-- 복사 쿼리
INSERT INTO tbl_movie ( mNm, mNmEn, mShowTm, mActors, mDirector, mOpenDt, mWatchGradeNm, mNationNm, mGenreNm, mStory)
SELECT mNm, mNmEn, mShowTm, mActors, mDirector, mOpenDt, mWatchGradeNm, mNationNm, mGenreNm, mStory FROM tbl_movie;

-- 영화
DROP TABLE IF EXISTS tbl_movie RESTRICT;

-- 영화
CREATE TABLE tbl_movie (
	mNo           INT          NOT NULL, -- 영화번호
	mNm           VARCHAR(50)  NOT NULL, -- 제목(한국어)
	mNmEn         VARCHAR(50)  NULL,     -- 제목(영어)
	mShowTm       VARCHAR(15)  NULL, 	 -- 상영시간
	mActors       VARCHAR(150) NULL,     -- 출연배우
	mDirector     VARCHAR(30)  NULL, 	 -- 감독
	mOpenDt       DATETIME     NULL,     -- 개봉연도
	mWatchGradeNm VARCHAR(30)  NULL, 	 -- 관람등급
	mNationNm     VARCHAR(50)  NULL,     -- 나라
	mGenreNm      VARCHAR(50)  NULL, 	 -- 장르
	mStory        TEXT         NULL      -- 줄거리
);

-- 영화
ALTER TABLE tbl_movie
	ADD CONSTRAINT PK_tbl_movie -- 영화 기본키
		PRIMARY KEY (
			mNo -- 영화번호
		);

ALTER TABLE tbl_movie
	MODIFY COLUMN mNo INT NOT NULL AUTO_INCREMENT;
	
	
	
	
use ebox;
select * from tbl_movie_pm;
delete from tbl_movie_pm;
ALTER TABLE tbl_movie_pm AUTO_INCREMENT=1; 
	

-- 영화홍보
DROP TABLE IF EXISTS tbl_movie_pm RESTRICT;

-- 영화홍보
CREATE TABLE tbl_movie_pm (
	iNo      INT         NOT NULL, -- 홍보물 번호
	iName    TEXT        NULL,     -- 이름
	iPath    TEXT        NULL,     -- 경로
	iSize    BIGINT      NULL,     -- 사이즈
	iRegdate DATETIME    NULL,     -- 등록날짜
	iType    VARCHAR(20) NULL,     -- 홍보물 형태
	refMno   INT         NULL      -- 영화번호
);

-- 영화홍보
ALTER TABLE tbl_movie_pm
	ADD CONSTRAINT PK_tbl_movie_pm -- 영화홍보 기본키
		PRIMARY KEY (
			iNo -- 홍보물 번호
		);

ALTER TABLE tbl_movie_pm
	MODIFY COLUMN iNo INT NOT NULL AUTO_INCREMENT;


use ebox;
select * from tbl_screen;
delete from tbl_screen;
ALTER TABLE tbl_screen AUTO_INCREMENT=1;

-- 스크린
DROP TABLE IF EXISTS tbl_screen RESTRICT;

-- 스크린
CREATE TABLE tbl_screen (
	scrNo    INT         NOT NULL, -- 스크린번호
	scrType  VARCHAR(30) NOT NULL, -- 스크린모드
	scrBuyDt DATETIME    NOT NULL, -- 구입 날짜
	scrPrice BIGINT      NOT NULL, -- 금액
	scrSdate DATETIME    NULL,     -- 상영 시작 날짜
	scrEdate DATETIME    NULL,     -- 상영 중단 날짜
	refMno   INT         NOT NULL  -- 영화번호
);

-- 스크린
ALTER TABLE tbl_screen
	ADD CONSTRAINT PK_tbl_screen -- 스크린 기본키
		PRIMARY KEY (
			scrNo -- 스크린번호
		);

ALTER TABLE tbl_screen
	MODIFY COLUMN scrNo INT NOT NULL AUTO_INCREMENT;

	
use ebox;
select * from tbl_schedule;
delete from tbl_schedule;
ALTER TABLE tbl_schedule AUTO_INCREMENT=1;


-- 상영스케줄
DROP TABLE IF EXISTS tbl_schedule RESTRICT;

-- 상영스케줄
CREATE TABLE tbl_schedule (
	schNo    INT         NOT NULL, -- 스케줄번호
	schStart VARCHAR(10) NULL,     -- 시작
	schEnd   VARCHAR(10) NULL,     -- 종료
	schDate  DATE        NULL,     -- 상영 날짜
	schType  VARCHAR(10) NULL,     -- 시간대
	refAno   INT         NOT NULL, -- 상영관번호
	refScrno INT         NOT NULL  -- 스크린번호
);

-- 상영스케줄
ALTER TABLE tbl_schedule
	ADD CONSTRAINT PK_tbl_schedule -- 상영스케줄 기본키
		PRIMARY KEY (
			schNo -- 스케줄번호
		);

ALTER TABLE tbl_schedule
	MODIFY COLUMN schNo INT NOT NULL AUTO_INCREMENT;
	
	
 	 
 	 
SELECT 
	S.*, R.* 
FROM 
	(SELECT 
		SCH.*, SCR.*, M.*    
	 FROM 
		tbl_schedule AS SCH, tbl_screen AS SCR, tbl_movie AS M 
	 WHERE 
		 SCR.scrNo = SCH.refScrno  
	 		AND 
		 M.mno = SCR.refMno 
			AND 
		 SCH.schDate >= '2017-07-01' 
			AND 
		 SCH.schDate < '2017-08-01'   
	) AS S
LEFT JOIN 
	(SELECT 
		A.*, T.* 
	 FROM 
		tbl_audi AS A, tbl_theater AS T 
	 WHERE 
		T.tNo = A.refTno	
	) AS R 
ON 
	S.refAno = R.aNo 
WHERE 
	S.refAno=6 ;


	
SELECT 
	SCH.*, SCR.*, M.*    
FROM 
	tbl_schedule AS SCH, tbl_screen AS SCR, tbl_movie AS M 
WHERE 
	SCR.scrNo = SCH.refScrno  
	AND 
	M.mno = SCR.refMno 
	AND 
	SCH.schDate >= '2017-07-01' 
	AND 
	SCH.schDate < '2017-08-01';   


select * 
from tbl_schedule as sch
	left join tbl_screen as scr 
	on sch.refscrno=scr.scrno;
	