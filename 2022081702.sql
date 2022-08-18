2022-0817-02)

4) LTRIM(c1 [,c2]), RTRIM(c1 [,c2])
- �־��� ���ڿ� c1�� ���ʺ���(LTRIM) �Ǵ� �����ʺ���(RTRIM) c2 ���ڿ��� ã�� ã�� ���ڿ��� ������
- �ݵ�� ù ���ں��� ��ġ�ؾ� ��
- c2�� �����Ǹ� ������ ã�� ����
- c1 ���ڿ� ������ ������ ������ �� ���� --���� ������ �� ����ٴ� �� --> REPLACE�� �����ؾ� ��

��뿹)
SELECT  LTRIM('APPLEAP PRESIMMON BANANA', 'PPLE'), --���۱��� ����ġ
        LTRIM(' APPLEAP PRESIMMON BANANA'), --ã���� �ϴ� ���ڿ� ���� --> ���鸸 ����
        LTRIM('APPLEAP PRESIMMON BANANA', 'AP'),
        --AP�� ��ġ�ؼ� �����µ� P�� �ϳ� �������.
        --�����ϴ� P�� ����! A�� �͵� ��������!
        --ù ��°�� ������ A �� ��°�� ������ P�ε�,
        --�� �ķ� ������ AP�� ��� ����
        --�ٸ� �� ���� �� A�� P�� AP�� PA�� �͵� �� ����. 
        --ù ���ڰ� P�� ���� P�� ����� ��
        LTRIM('APAPLEAP PRESIMMON BANANA', 'AP') 
        LTRIM('PAAP PRESIMMON BANANA', 'AP') 
        --PERSIMMON�� P�� �� ������ --> ���� ������
FROM    DUAL   

SELECT  * 
FROM    MEMBER
WHERE   MEM_NAME=RTRIM('�̻��� ');

5) TRIM(c1) - ***
- �־��� ���ڿ�(c1) ��, �쿡 �����ϴ� ��ȿ�� ������ ����
- �ܾ� ������ ������ �������� ����
- LTRIM�� RTRIM���� ���� ��

��뿹) �������̺�(JOBS)���� ������(JOB_TITLE) 'Accounting Manager'�� ������ ��ȸ�Ͻÿ�.
SELECT  JOB_ID      AS  �����ڵ�,
        LENGTHB(JOB_TITLE)  AS  "�������� ����",
        MIN_SALARY  AS  �����޿�,
        MAX_SALARY  AS  �ְ�޿�
FROM    HR.JOBS
WHERE   JOB_TITLE='Accounting Manager';
-- TRIM�� �������ִٰ� ���� ��( "=" ���ʿ�!!), �׷��� �� ����� ����

��뿹) JOBS���̺��� �������� ������ Ÿ���� VARCHAR2(40)���� �����Ͻÿ�.
--���� VARCHAR2���µ� �̰��� CHAR�� �ٲ���. �̶� ������ �ڸ��� ���� ��. CHAR�� �������̶�.
--�̰��� �ٽ� VARCHAR2�� �ٲ㵵 ������ �����ְ� �Ǵ� ����! --> ��ȿ�� ����!
--�̶� UPDATE���� �ʼ�
UPDATE HR.JOBS
SET JOB_TITLE=TRIM(JOB_TITLE); --> �� �� ����?

COMMIT;

6) SUBSTR(c1, m[,n] - *****
- �־��� ���ڿ� c1���� m��°���� n���� ���ڸ� ����
- m�� ������ġ�� ��Ÿ���� 1���� counting��
- n�� ������ ������ ���� �����ϸ� m��° ���� ��� ���ڸ� ����
- m�� �����̸� �����ʺ��� counting��

��뿹)
SELECT  SUBSTR('ABCDEFGHIJK',3,5),
        SUBSTR('ABCDEFGHIJK',3),
        SUBSTR('ABCDEFGHIJK',-3,5),
        SUBSTR('ABCDEFGHIJK',3,15) -- �ڷẸ�� �� ���� ���̰� ���̸� ������ �� ����!!
FROM    DUAL;

��뿹)   ȸ�� ���̺��� �ֹι�ȣ �ʵ�(MEM_PERGNO1, MEN_REGNO2)�� �̿��Ͽ�
          ȸ����DML ���̸� ���ϰ�, ȸ����ȣ, ȸ����, �ֹι�ȣ, ���̸� ����Ͻÿ�.
          --���̸� ���Ϸ��� �ֹι�ȣ �� ���� ����
SELECT  MEM_ID      AS  ȸ����ȣ,
        MEM_NAME    AS  ȸ����,
        MEM_REGNO1||'-'||MEM_REGNO2 AS  �ֹι�ȣ,
        CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) IN('1', '2') THEN --CASE WHEN ���� THEN
            2022- (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900)
        ELSE -- ELSE
            2022- (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000)
        END AS ���� -- END AS
FROM    MEMBER;
    
��뿹) ������ 2020�� 4�� 1���̶�� �����Ͽ�
        'C001'ȸ���� ��ǰ�� ������ �� �ʿ��� ��ٱ��� ��ȣ�� �����Ͻÿ�.     
        MAX(), TO_CHAR() �Լ� ���
SELECT  '20200401'||TRIM(TO_CHAR(MAX(TO_NUMBER(SUBSTR(CART_NO,9)))+1,'00000'))
FROM    CART
WHERE   SUBSTR(CART_NO,1,8) = '20200401';
    --LIKE ���� �ͺ��� ���� ��� �� ���� �� �� ȿ������
    --������ ���ķ� ������ �� ���� �̰Ž� �����̴�!!
    --���� ������ ���� ����Ŭ ������!
    
SELECT  MAX(CART_NO)+1
FROM    CART
WHERE   SUBSTR(CART_NO,1,8) = '20200401';
    --CART_NO�� �����ϰ� ���ڷ� �̷���� ���ڿ��̶� �� �� ����
    --MAX�� ���ڿ��� �� --> �ڵ� ����ȯ��
    --��Ģ�����δ� ���� ���� �ؾ� ������
    --���� ���ڷ� �̷���� ���ڿ��� ����ȭ�� �� �־ �̷� ����� �� �� ����
    
��뿹) �̹� �� ������ ȸ������ ��ȸ�Ͻÿ�.
        Alias�� ȸ����ȣ, ȸ����, �������, ����(����)
        -�� ������ �ֹε�Ϲ�ȣ�� �̿��� �� 

SELECT  MEM_ID      AS  ȸ����ȣ,
        MEM_NAME    AS  ȸ����,
        MEM_BIR     AS  �������,
        SUBSTR(MEM_REGNO1,3) AS ����
FROM    MEMBER
WHERE   SUBSTR(MEM_REGNO1,3,2) = '09'; -- SUBSTR((SYSDATE),6,2); --SUBSTR(TO_CHAR(SYSDATE),6,2);

7) REPLACE(c1, c2 [,c3]) - **
- �־��� ���ڿ� c1���� c2���ڿ��� ã�� c3���ڿ��� ġȯ
- c3�� �����Ǹ� c2�� ������
- �ܾ� ������ �������� ����

��뿹)
SELECT  REPLACE('APPLE PERSIMMON BANANA', 'A', '����'),
        REPLACE('APPLE PERSIMMON BANANA', 'A'),
        REPLACE('APPLE PERSIMMON BANANA', ' ', '-'),
        REPLACE(' APPLE PERSIMMON BANANA ', ' ') --���� ���� ���� (��������)
FROM    DUAL;
