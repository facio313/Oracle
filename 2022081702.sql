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
- 주어진 문자열 좌, 우에 존재하는 무효의 공백을 제거
- 단어 내부의 공백은 제거하지 못함