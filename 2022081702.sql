2022-0817-02)

4) LTRIM(c1 [,c2]), RTRIM(c1 [,c2])
- 주어진 문자열 c1의 왼쪽부터(LTRIM) 또는 오른쪽부터(RTRIM) c2 문자열을 찾아 찾은 문자열을 삭제함
- 반드시 첫 글자부터 일치해야 함
- c2가 생략되면 공백을 찾아 삭제
- c1 문자열 내부의 공백은 제거할 수 없음 --안쪽 공백은 못 지운다는 말 --> REPLACE로 제거해야 함

사용예)
SELECT  LTRIM('APPLEAP PRESIMMON BANANA', 'PPLE'), --시작글자 불일치
        LTRIM(' APPLEAP PRESIMMON BANANA'), --찾고자 하는 문자열 생략 --> 공백만 지움
        LTRIM('APPLEAP PRESIMMON BANANA', 'AP'),
        --AP가 일치해서 지웠는데 P가 하나 들어있음.
        --연속하는 P는 삭제! A가 와도 마찬가지!
        --첫 번째는 무조건 A 두 번째는 무조건 P인데,
        --그 후로 나오는 AP는 상관 없음
        --다른 거 나온 후 A나 P나 AP나 PA가 와도 못 지움. 
        --첫 글자가 P가 오면 P만 지우고 끝
        LTRIM('APAPLEAP PRESIMMON BANANA', 'AP') 
        LTRIM('PAAP PRESIMMON BANANA', 'AP') 
        --PERSIMMON의 P는 안 없어짐 --> 공백 때문에
FROM    DUAL   

SELECT  * 
FROM    MEMBER
WHERE   MEM_NAME=RTRIM('이쁜이 ');

5) TRIM(c1) - ***
- 주어진 문자열(c1) 좌, 우에 존재하는 무효의 공백을 제거
- 단어 내부의 공백은 제거하지 못함
- LTRIM과 RTRIM보다 많이 씀

사용예) 직무테이블(JOBS)에서 직무명(JOB_TITLE) 'Accounting Manager'인 직무를 조회하시오.
SELECT  JOB_ID      AS  직무코드,
        LENGTHB(JOB_TITLE)  AS  "직무명의 길이",
        MIN_SALARY  AS  최저급여,
        MAX_SALARY  AS  최고급여
FROM    HR.JOBS
WHERE   JOB_TITLE='Accounting Manager';
-- TRIM이 생략돼있다고 보면 됨( "=" 앞쪽에!!), 그렇게 된 결과로 나옴

사용예) JOBS테이블의 직무명의 데이터 타입을 VARCHAR2(40)으로 변경하시오.
--원래 VARCHAR2였는데 이것을 CHAR로 바꿨음. 이때 공백이 자리를 갖게 됨. CHAR가 고정길이라.
--이것을 다시 VARCHAR2로 바꿔도 공백은 남아있게 되는 것임! --> 유효의 공백!
--이때 UPDATE문이 필수
UPDATE HR.JOBS
SET JOB_TITLE=TRIM(JOB_TITLE); --> 왜 안 먹힘?

COMMIT;

6) SUBSTR(c1, m[,n] - *****
- 주어진 문자열 c1에서 m번째에서 n개의 문자를 추출
- m은 시작위치를 나타내며 1부터 counting함
- n은 추출할 문자의 수로 생략하면 m번째 이후 모든 문자를 추출
- m이 음수이면 오른쪽부터 counting함

사용예)
SELECT  SUBSTR('ABCDEFGHIJK',3,5),
        SUBSTR('ABCDEFGHIJK',3),
        SUBSTR('ABCDEFGHIJK',-3,5),
        SUBSTR('ABCDEFGHIJK',3,15) -- 자료보다 더 많은 길이가 쓰이면 나머지 다 추출!!
FROM    DUAL;

사용예)   회원 테이블의 주민번호 필드(MEM_PERGNO1, MEN_REGNO2)를 이용하여
          회원들DML 나이를 구하고, 회원번호, 회원명, 주민번호, 나이를 출력하시오.
          --나이를 구하려면 주민번호 두 개가 사용됨
SELECT  MEM_ID      AS  회원번호,
        MEM_NAME    AS  회원명,
        MEM_REGNO1||'-'||MEM_REGNO2 AS  주민번호,
        CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) IN('1', '2') THEN --CASE WHEN 조건 THEN
            2022- (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900)
        ELSE -- ELSE
            2022- (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000)
        END AS 나이 -- END AS
FROM    MEMBER;
    
사용예) 오늘이 2020년 4월 1일이라고 가정하여
        'C001'회원이 상품을 구매할 때 필요한 장바구니 번호를 생성하시오.     
        MAX(), TO_CHAR() 함수 사용
SELECT  '20200401'||TRIM(TO_CHAR(MAX(TO_NUMBER(SUBSTR(CART_NO,9)))+1,'00000'))
FROM    CART
WHERE   SUBSTR(CART_NO,1,8) = '20200401';
    --LIKE 쓰는 것보다 오늘 배운 거 쓰는 게 더 효율적임
    --오른쪽 정렬로 나오는 거 보니 이거슨 숫자이다!!
    --띄어쓰기 나오는 것은 오라클 오류임!
    
SELECT  MAX(CART_NO)+1
FROM    CART
WHERE   SUBSTR(CART_NO,1,8) = '20200401';
    --CART_NO이 순수하게 숫자로 이루어진 문자열이라서 될 수 있음
    --MAX는 숫자여야 함 --> 자동 형변환됨
    --원칙적으로는 위와 같이 해야 정답임
    --순수 숫자로 이루어진 문자열은 숫자화할 수 있어서 이런 편법을 쓸 수 있음
    
사용예) 이번 달 생일인 회원들을 조회하시오.
        Alias는 회원번호, 회원명, 생년월일, 생일(일자)
        -단 생일은 주민등록번호를 이용할 것 

SELECT  MEM_ID      AS  회원번호,
        MEM_NAME    AS  회원명,
        MEM_BIR     AS  생년월일,
        SUBSTR(MEM_REGNO1,3) AS 생일
FROM    MEMBER
WHERE   SUBSTR(MEM_REGNO1,3,2) = '09'; -- SUBSTR((SYSDATE),6,2); --SUBSTR(TO_CHAR(SYSDATE),6,2);

7) REPLACE(c1, c2 [,c3]) - **
- 주어진 문자열 c1에서 c2문자열을 찾아 c3문자열로 치환
- c3가 생략되면 c2를 삭제함
- 단어 내부의 공백제거 가능

사용예)
SELECT  REPLACE('APPLE PERSIMMON BANANA', 'A', '에이'),
        REPLACE('APPLE PERSIMMON BANANA', 'A'),
        REPLACE('APPLE PERSIMMON BANANA', ' ', '-'),
        REPLACE(' APPLE PERSIMMON BANANA ', ' ') --제일 많이 사용됨 (공백제거)
FROM    DUAL;
