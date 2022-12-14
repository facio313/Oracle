2022-0805-02)숫자자료형
    - 정수와 실수 저장
    - NUMBER타입 제공
(사용형식)
    NUMBER[(정밀도|*[,스케일])]
    - 값의 표현 범위 : 10e-130 ~ 9.999.9E125
    - 정밀도 : 전체자리 수(1-38)
    - 스케일 : 소수점 이하의 자리수
    - '*'는 38자리 이내에서 사용자가 입력한 데이터를 저장할 수 있는 최적의 기억공간을 시스템이 설정
    -저장은 소수점 이하 '스케일'+1번째 자리에서 반올림하여 '스케일'잘까지 저장(스케일이 양수인 경우)
    '스케일'이 음수이면 정수부분 '스케일' 자리에서 반올림하여 저장
    스케일이 생략되면 0 쓴 걸로 간주함
    1   2   3   4   5 . 6   7   8   9   1   2
    -5 -4  -3  -2  -1   1   2   3   4   5   6
    오라클 같은 데에서 데이터 절삭 같은 거 안 하는 게 현명하다...값이 달라져서
    - NUMBER만 쓰면 지가 알아서 잡아줌
저장 예)
---------------------------------------------------------------------------------------------------------------------
        선언            입력값          저장형태
---------------------------------------------------------------------------------------------------------------------
        NUMBER         12345.6789     12345.6789
        NUMBER(*,2)    12345.6789     12345.68
        NUMBER(6,2)    12345.6789     ERROR -- 소수점 자리는 반올림이 일어나는데 정수자리가 모자르면 오류남 - 기억장소가 부족해서
        NUMBER(7,2)    12345.6789     12345.68
        NUMBER(8,0)    12345.6789        12346 --공백도 필요해 - 3개
        NUMBER(6)      12345.6789     12346
        NUMBER(6,-2)   12345.6789      12300 -- 정수 자리밖에 없다. 소수점 자리는 없다!!
        
CREATE TABLE TEMP05(
    COL1 NUMBER,
    COL2 NUMBER(*,2),
    COL3 NUMBER(6,2),
    COL4 NUMBER(7,2),
    COL5 NUMBER(8,0),
    COL6 NUMBER(6),
    COL7 NUMBER(6,-2));
    
INSERT INTO TEMP05 VALUES(12345.6789,12345.6789,2345.6789,12345.6789,
                          12345.6789,12345.6789,12345.6789);
                          
SELECT * FROM TEMP05;

** 정밀도<스케일인 경우
    - 정밀도 : 소수점 이하에서 0이 아닌 유효숫자의 개수
    - 스케일 : 소수점 이하의 자리수
    - [스케일 - 정밀도 ]:소수점 이하에서 존재해야 할 0의 개수
    
---------------------------------------------------------------------------------------------------------------------
        입력값            선언          저장된 값
---------------------------------------------------------------------------------------------------------------------
        1234.5678       NUMBER(2,4)    ERROR -- 정수 부분이 들어가려면 일단 저장 안 됨
        0.12            NUMBER(3,5)    ERROR -- 복합적인 문제들로 인해...그런데 그 문제가 뭔지는 모르겠고 ㅋㅋ
        0.003456        NUMBER(2,4)    0.0035
        0.0345678       NUMBER(2,3)    0.035