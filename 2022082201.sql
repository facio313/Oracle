2022-0822-01)����ȯ �Լ�
- ����Ŭ�� ������ ����ȯ �Լ��� TO_CHAR, TO_DATE, TO_NUMBER, CAST �Լ��� ������
- ���� ��ȯ�� �ش� �Լ��� ���Ȱ��� �Ͻ��� ��ȯ

1) CAST(expr AS TYPE) - *
- expr�� �����Ǵ� ������(����, �Լ� ��)�� 'type' ���·� ��ȯ�Ͽ� ��ȯ��

��뿹)
SELECT  BUYER_ID        AS  �ŷ�ó�ڵ�,
        BUYER_NAME      AS  �ŷ�ó��,
        CAST(BUYER_NAME AS  CHAR(30))   AS  �ŷ�ó��2, --�Լ��� ���� ��������! ���̺� ������ ��ġ�� ����
        BUYER_CHARGER   AS  �����
FROM    BUYER;

SELECT  --CAST(BUY_DATE AS NUMBER) --��¥�� ���ڷ� �� �ٲ�.. CAST�� ���ٰ� �� �Ǵ� ���� �ƴ�!!! ����� �͸� �ٲ�
        CAST(TO_CHAR(BUY_DATE, 'YYYYMMDD') AS NUMBER) -- �ٲٷ��� �̷��� �ؾ� ��.../ ���ְ� ! �ٲٱ� !
FROM    BUYPROD
WHERE   BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131');

2) TO_CHAR(d [,fmt]) - *****
- ��ȯ�Լ� �� ���� �θ� ���
- ����, ��¥, ���� Ÿ���� ����Ÿ������ ��ȯ
- ����Ÿ���� CHAR, CLOB�� VARCHAR2�� ��ȯ�� ���� ��� ����
- 'fmt'�� ���� ���ڿ��� ũ�� ��¥���� ���������� ���е�
------------------------------------------------------------------------------------------------------------------
**������ ���Ĺ���
------------------------------------------------------------------------------------------------------------------
FORMAT ����           �ǹ�                  ��뿹
------------------------------------------------------------------------------------------------------------------
CC                    ����                  SELECT TO_CHAR(SYSDATE, 'CC')||'����'   FROM DUAL;
AD, BC                ��� ��, ��� ��      SELECT TO_CHAR(SYSDATE, 'CC BC')||EXTRACT(YEAR FROM SYSDATE) FROM DUAL;
YYYY, YYY, YY, Y      �⵵ - 2022,022,22,2  SELECT TO_CHAR(SYSDATE, 'YYYY YEAR')    FROM DUAL;
YEAR                  �⵵�� ���ĺ�����     SELECT TO_CHAR(SYSDATE, 'YYYY YEAR')    FROM DUAL;
Q                     �б�(QUARTER)         SELECT TO_CHAR(SYSDATE, 'Q')            FROM DUAL;
MM, RM(�θ���)        ��                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM')      FROM DUAL;
MONTH, MON            ��(�ѱ� ���X �����) SELECT TO_CHAR(SYSDATE, 'YYYY-MONTH')   FROM DUAL;
WW(�� ����),W(�� ����)�� ~52 / ~5           SELECT TO_CHAR(SYSDATE, 'YYYY-MM WW')   FROM DUAL;
DDD(��),DD,D(�� ����) ��                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')   FROM DUAL;
DAY(FULL), DY(AGG)    ����                  SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DY')FROM DUAL;
AM,PM,A.M.,P.M.       ����/����             SELECT TO_CHAR(SYSDATE, 'AM YYYY-MM-DD DY')FROM DUAL;
HH, HH12, HH24        �ð�                  SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH')FROM DUAL;
MI                    ��                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI')FROM DUAL;
SS, SSSSS(���� ���)  ��                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS SSSSS')FROM DUAL;

------------------------------------------------------------------------------------------------------------------
**������ ���Ĺ���
------------------------------------------------------------------------------------------------------------------
FORMAT ����           �ǹ�                  ��뿹
------------------------------------------------------------------------------------------------------------------
9,0                   �����ڷ� ���         SELECT  TO_CHAR(12345.56, '9,999,999.9'), -- 9: ��ȿ���ڿ� ���� �� ���� ���/��ȿ�� '0'�� ���� �� (���� ��� ,�� ����)
- 9��� ���� ������ ���ĵŵ� �װŽ� ����!             TO_CHAR(12345.56, '0,000,000.0')  FROM    DUAL; -- 0: ��ȿ���ڿ� ���� �� ���� ���/��ȿ�� '0'�� ���� �� 0 ���
,(COMMA)              3�ڸ����� �ڸ���(,)
.(DOT)                �Ҽ���
$,L                   ȭ���ȣ              SELECT  TO_CHAR(PROD_PRICE, 'L9,999,999')   FROM    PROD; -- L : LOCATOR
                                            SELECT  TO_CHAR(SALARY, '$999,999') AS  �޿�1, --������ ���ĵŵ� ���ڰ� �ƴ϶� ���ڿ��� ��Ģ����XX
                                                    TO_CHAR(SALARY)             AS  �޿�2      FROM    HR.EMPLOYEES;
PR                    '<�����ڷ�>'          SELECT  TO_CHAR(-2500,'99,999PR')           FROM    DUAL;
MI                    '-'�����ڷ�           SELECT  TO_CHAR(-2500,'99,999MI')           FROM    DUAL;

" " ����ڰ� ���� �����ϴ� ���ڿ�           SELECT  TO_CHAR(SYSDATE, 'YYYY"�� "MM"��" DD"��"') FROM DUAL;
--�÷� ��Ī ��� �ÿ��� ""�� / �ٸ� ���� ���̺��� ������ �� ��Ű���� ����� �� �� ��Ű���� ��� ����ϱ� ���� ���

3) TO_DATE(c [, fmt]) - ***
- �־��� ���ڿ� �ڷ� c�� ��¥ Ÿ���� �ڷ�� ����ȯ��Ŵ
- c�� ���Ե� ���ڿ� �� ��¥�ڷ�� ��ȯ�� �� ���� ���ڿ��� ���Ե� ��� 'fmt' �� ����Ͽ� �⺻�������� ��ȯ�� �� ����
- 'fmt'�� TO_CHAR�Լ��� '��¥�� ���Ĺ���'�� ����

��뿹) �������� ���ڿ� --> ���� �����Ͱ� �⺻ Ÿ������ �ٲ� �� ���� ��(�߰��� ���� �������� ��) ����ϱ� ����
SELECT  TO_DATE('20200504'), -- ���� �ڷ�� ����� ��¥�� ���� �Ұ���
        TO_DATE('20200504', 'YYYY-MM-DD'), -- /���� -�� �� ����!(�켱����)
        TO_DATE('2020�� 08�� 22��', 'YYYY"��" MM"��" DD"��"') -- ����� �⺻ ��¥ Ÿ���� ��
FROM    DUAL;

4) TO_NUMBER(c, [,fmt]) - **
- �־��� ���ڿ� �ڷ� c�� ����Ÿ���� �ڷ�� ����ȯ��Ŵ
- c�� ���Ե� ���ڿ� �� �����ڷ�� ��ȯ�� �� ���� ���ڿ��� ���Ե� ��� 'fmt'�� ����Ͽ� �⺻ ���� �������� ��ȯ�� �� ����
- 'fmt'�� TO_CHAR�Լ��� '������ ���Ĺ���'�� ����

��뿹)
SELECT  TO_NUMBER('2345') / 7, -- <-- ���� ���� ���� ����
        TO_NUMBER('2345.56'), -- �Ҽ����� ���� ���� �� �ص� ��!
        TO_NUMBER('2,345','9,999'), -- �׳� '2,345'�ų� '2345', '99,999'�� �� ��
        TO_NUMBER('$2345', '$9999'), -- '$2345' ����
        TO_NUMBER('002,345', '000,000'), -- '002,345' ����
        TO_NUMBER('<2,345>', '9,999PR') -- '<2,345>' ����
FROM    DUAL;        