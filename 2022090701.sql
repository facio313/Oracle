2022-0907-01)�б⹮�� �ݺ���
1. �б⹮
- ���α׷��� ��� �����Ű�� ���
- IF, CASE WHEN ���� ����
1) IF��
- ���߾���� IF�� ���� ��� �����ϸ� ������� ����

(�������-1)
IF ���ǽ� THEN
    ��ɹ�1;
[ELSE
    ��ɹ�2;]
END IF;

(�������-2)
IF ���ǽ� THEN
    ��ɹ�1;
ELSIF ���ǽ�2 THEN -- ELSIF�� ����!! ELSE IF�� ���� ��
    ��ɹ�2;
ELSE
    ��ɹ�3;
END IF;

(�������-3)
IF ���ǽ� THEN
    IF ���ǽ�2 THEN -- NESTED IF ��øIF��
        ��ɹ�1;
ELSE
    ��ɹ�2;
    END IF;
ELSE
    ��ɹ�3;
END IF;

2)CASE ��
- ���� �б� ��� ����(���� ����)
- JAVA�� SWITCH ~ CASE�� ����

(�������-1)
CASE    WHEN    ���ǽ�1 THEN
                ��ɹ�1;
        WHEN    ���ǽ�2 THEN
                ��ɹ�2;
                :
        ELSE
                ��ɹ�N;
END CASE;

(�������-2)
CASE    ���ǽ�
        WHEN    ��1 THEN
                ��ɹ�1;
        WHEN    ��2 THEN
                ��ɹ�2;
                :
        ELSE
                ��ɹ�N;
END CASE;

��뿹)
������̺��� ������ �μ��� �����Ͽ� ù ��° �˻��� ����� �޿��� ��ȸ�ϰ�
�� �޿���
    1   ~   5000    : '����� ���'
 5001   ~   10000   : '��պ�� ���'
10001   ~   20000   : '���� ���'
          �� �̻�    : '�ʰ��� ���'�� �����, �޿��� �Բ� ����Ͻÿ�

DECLARE
    V_RES   VARCHAR2(100);
    V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE;
    V_SAL   NUMBER := 0;
    V_DID   HR.DEPARTMENTS.DEPARTMENT_ID%TYPE;
BEGIN
    V_DID   := TRUNC(DBMS_RANDOM.VALUE(10,119), -1); --������ ���� �߻� �Լ� / TRUNC 1�� �ڸ� ���� ����!
    SELECT  EMP_NAME, SALARY    INTO    V_ENAME, V_SAL
    FROM    HR.EMPLOYEES
    WHERE   DEPARTMENT_ID = V_DID
    AND     ROWNUM = 1;
    
    CASE    WHEN    V_SAL <= 5000 THEN
                    V_RES := RPAD(V_ENAME, 40)||TO_CHAR(V_SAL, '99,999')||'����� ���'; --�̸��� 40����Ʈ�� �� ���߰ڴ�
            WHEN    V_SAL <= 10000 THEN
                    V_RES := RPAD(V_ENAME, 40)||TO_CHAR(V_SAL, '99,999')||'��պ�� ���';    
            WHEN    V_SAL <= 20000 THEN
                    V_RES := RPAD(V_ENAME, 40)||TO_CHAR(V_SAL, '99,999')||'���� ���';    
            ELSE    
                    V_RES := RPAD(V_ENAME, 40)||TO_CHAR(V_SAL, '99,999')||'�ʰ��� ���';
    END CASE;
    DBMS_OUTPUT.PUT_LINE(V_RES);
END;

2. �ݺ���
- ����Ŭ PL/SQL���� Ư�� ��ɹ�(��)�� �ݺ� �����ϴ� ��� ���
- ���� Ŀ���� �����ϱ� ���� ����
- LOOP, WHILE, FOR ���� ������
1) LOOP
- �ݺ����� �⺻ ���� ����
- ���� �ݺ� ��� ����
(�������)
LOOP
    �ݺ�ó����(��)
    [EXIT WHEN ����];
END LOOP; -- ������ ������ �ݺ��� ���
- 'EXIT WHEN ����' : ������ ���̸� �ݺ��� ���
��뿹)
�������� 5���� ����Ͻÿ�
DECLARE
    V_CNT NUMBER := 0;
BEGIN
    LOOP
    V_CNT := V_CNT + 1;
    EXIT WHEN V_CNT > 9;
    DBMS_OUTPUT.PUT_LINE('5 * '||V_CNT||' = '||5*V_CNT);
    END LOOP;
END;

��뿹)
������̺��� ������ �μ��� �����Ͽ� ù ��° �˻��� ����� �޿��� ��ȸ�ϰ�
�� �޿���
    1   ~   5000    : '����� ���'
 5001   ~   10000   : '��պ�� ���'
10001   ~   20000   : '���� ���'
          �� �̻�    : '�ʰ��� ���'�� �����, �޿��� �Բ� ����Ͻÿ�

DECLARE
    V_RES   VARCHAR2(100); --���
    V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE; --�����
    V_SAL   NUMBER := 0; --�޿�
    V_DID   HR.DEPARTMENTS.DEPARTMENT_ID%TYPE; --�μ���ȣ
    CURSOR EMP01_CUR(P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) IS
        SELECT  EMP_NAME, SALARY
        FROM    HR.EMPLOYEES
        WHERE   DEPARTMENT_ID = P_DID;
BEGIN
    V_DID := TRUNC(DBMS_RANDOM.VALUE(10, 119), -1);
    OPEN    EMP01_CUR(V_DID);
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : '||V_DID);
    LOOP
        FETCH   EMP01_CUR INTO V_ENAME, V_SAL; --FETCH���� ������ EXIT WHEN�� �Ǵ��� �� ����
        EXIT    WHEN    EMP01_CUR%NOTFOUND;
        CASE    WHEN    V_SAL <= 5000 THEN
                        V_RES := RPAD(V_ENAME, 40)||TO_CHAR(V_SAL, '99,999')||'����� ���'; --�̸��� 40����Ʈ�� �� ���߰ڴ�
                WHEN    V_SAL <= 10000 THEN
                        V_RES := RPAD(V_ENAME, 40)||TO_CHAR(V_SAL, '99,999')||'��պ�� ���';    
                WHEN    V_SAL <= 20000 THEN
                        V_RES := RPAD(V_ENAME, 40)||TO_CHAR(V_SAL, '99,999')||'���� ���';    
                ELSE    
                        V_RES := RPAD(V_ENAME, 40)||TO_CHAR(V_SAL, '99,999')||'�ʰ��� ���';
        END CASE;
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE(V_RES);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('����� : '||EMP01_CUR%ROWCOUNT||'��');
    CLOSE EMP01_CUR;
END;

2) WHILE��
- �ݺ� ���� �� ������ ���Ͽ� ������ ���̸� �ݺ��� �����ϰ�, ������ �� ����� �����̸� �ݺ� ������ ������
- ���߾���� WHILE���� ���� ��� ����
(�������)
WHILE   ����  LOOP
    �ݺ� ���� ���;
    END LOOP;
    
��뿹)
�������� 5���� ����Ͻÿ�
DECLARE
    V_CNT   NUMBER := 1;
BEGIN
    WHILE   V_CNT <= 9 LOOP
        DBMS_OUTPUT.PUT_LINE('5 * ' || V_CNT || ' = ' || 5*V_CNT);
        V_CNT := V_CNT + 1;
    END LOOP;
END;


��뿹)
������̺��� ������ �μ��� �����Ͽ� ù ��° �˻��� ����� �޿��� ��ȸ�ϰ�
�� �޿���
    1   ~   5000    : '����� ���'
 5001   ~   10000   : '��պ�� ���'
10001   ~   20000   : '���� ���'
          �� �̻�    : '�ʰ��� ���'�� �����, �޿��� �Բ� ����Ͻÿ�
DECLARE
    V_RES   VARCHAR2(100); --���
    V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE; --�����
    V_SAL   NUMBER := 0; --�޿�
    V_DID   HR.DEPARTMENTS.DEPARTMENT_ID%TYPE; --�μ���ȣ
    CURSOR EMP01_CUR(P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) IS
        SELECT  EMP_NAME, SALARY
        FROM    HR.EMPLOYEES
        WHERE   DEPARTMENT_ID = P_DID;
BEGIN
    V_DID := TRUNC(DBMS_RANDOM.VALUE(10, 119), -1);
    OPEN    EMP01_CUR(V_DID);
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : '||V_DID);
    FETCH   EMP01_CUR INTO V_ENAME, V_SAL;
    WHILE EMP01_CUR%FOUND LOOP

        EXIT    WHEN    EMP01_CUR%NOTFOUND;
        CASE    WHEN    V_SAL <= 5000 THEN
                        V_RES := RPAD(V_ENAME, 40)||TO_CHAR(V_SAL, '99,999')||'����� ���'; --�̸��� 40����Ʈ�� �� ���߰ڴ�
                WHEN    V_SAL <= 10000 THEN
                        V_RES := RPAD(V_ENAME, 40)||TO_CHAR(V_SAL, '99,999')||'��պ�� ���';    
                WHEN    V_SAL <= 20000 THEN
                        V_RES := RPAD(V_ENAME, 40)||TO_CHAR(V_SAL, '99,999')||'���� ���';    
                ELSE    
                        V_RES := RPAD(V_ENAME, 40)||TO_CHAR(V_SAL, '99,999')||'�ʰ��� ���';
        END CASE;
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE(V_RES);
        FETCH   EMP01_CUR INTO V_ENAME, V_SAL;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('����� : '||EMP01_CUR%ROWCOUNT||'��');
    CLOSE EMP01_CUR;
END; --WHILE�� ���� �� �� �� --> ���� ������ ���� �� ����

3) FOR��
- �ݺ�Ƚ���� �˰ų� �ݺ�Ƚ���� �߿��� ��� ���
- ���߾���� FOR���� ���� ��� ����
- Ŀ���� FOR���� ���� �� ����! Ŀ�� ������ FOR ���ٰ� ���� ��!

(�Ϲ� FOR�� �������)
FOR �ε�����    [REVERSE]   IN  �ʱⰪ..������ LOOP
    �ݺ�ó����(��);
END LOOP;
-'�ε�����' : '�ʱⰪ'���� '������'�� 1�� ��ȭ���� ������ ������ �ý��ۿ��� �ڵ����� Ȯ��(���� ���ʿ� - ���� �� ���� �Ұ�)
-'REVERSE' : �������� ó���� �� ���('�ʱⰪ...������'�� �������� ����)

(Ŀ�� ��� FOR�� �������)
FOR ���ڵ��    IN  Ŀ����|Ŀ�� ���� in-line subquery LOOP
    �ݺ�ó����(��);
END LOOP;
- '���ڵ��' : Ŀ�� ���� �� ����� ������ ������ �ý��ۿ��� �ڵ����� Ȯ��(���� ���ʿ�)
- 'Ŀ�� ���� in-line subquery' : Ŀ������ SELECT��
- Ŀ���� �÷������� '���ڵ��.Ŀ���÷���'���� ����
- Ŀ�� �� ���� ����ŭ �ݺ�����
- Ŀ���� OPEN, FETCH, CLOSE�� ���ʿ� -- �ٸ� OPEN���� �� ���ϱ� �Ű�����X ROWCOUNT�� ����X

��뿹)
�������� 5���� FOR���� �̿��Ͽ� ����Ͻÿ�
DECLARE
BEGIN
    FOR I   IN  1..9    LOOP
        DBMS_OUTPUT.PUT_LINE('5 * ' || I || ' = ' || 5*I
    END LOOP;
END;

��뿹)
������̺��� ������ �μ��� �����Ͽ� ù ��° �˻��� ����� �޿��� ��ȸ�ϰ�
�� �޿���
    1   ~   5000    : '����� ���'
 5001   ~   10000   : '��պ�� ���'
10001   ~   20000   : '���� ���'
          �� �̻�    : '�ʰ��� ���'�� �����, �޿��� �Բ� ����Ͻÿ�
DECLARE
    V_CNT   NUMBER := 0;
    V_RES   VARCHAR2(100); --���
    CURSOR EMP01_CUR    IS
        SELECT  EMP_NAME, SALARY
        FROM    HR.EMPLOYEES
        WHERE   DEPARTMENT_ID = 80;
BEGIN
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : 80');
    FOR REC IN  EMP01_CUR   LOOP
        V_CNT := V_CNT + 1;
        CASE    WHEN    REC.SALARY <= 5000 THEN
                        V_RES := RPAD(REC.EMP_NAME, 40)||TO_CHAR(REC.SALARY, '99,999')||' ����� ���'; --�̸��� 40����Ʈ�� �� ���߰ڴ�
                WHEN    REC.SALARY <= 10000 THEN
                        V_RES := RPAD(REC.EMP_NAME, 40)||TO_CHAR(REC.SALARY, '99,999')||' ��պ�� ���';    
                WHEN    REC.SALARY <= 20000 THEN
                        V_RES := RPAD(REC.EMP_NAME, 40)||TO_CHAR(REC.SALARY, '99,999')||' ���� ���';    
                ELSE    
                        V_RES := RPAD(REC.EMP_NAME, 40)||TO_CHAR(REC.SALARY, '99,999')||' �ʰ��� ���';
        END CASE;
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE(V_RES);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('����� : '|| V_CNT ||'��');
END;

(IN-LINE SUBQUERY ���)
DECLARE
    V_CNT   NUMBER := 0;
    V_RES   VARCHAR2(100); --���    
BEGIN
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : 80');
    FOR REC IN (SELECT  EMP_NAME, SALARY
                FROM    HR.EMPLOYEES
                WHERE   DEPARTMENT_ID = 80)   LOOP
        V_CNT := V_CNT + 1;
        CASE    WHEN    REC.SALARY <= 5000 THEN
                        V_RES := RPAD(REC.EMP_NAME, 40)||TO_CHAR(REC.SALARY, '99,999')||' ����� ���'; --�̸��� 40����Ʈ�� �� ���߰ڴ�
                WHEN    REC.SALARY <= 10000 THEN
                        V_RES := RPAD(REC.EMP_NAME, 40)||TO_CHAR(REC.SALARY, '99,999')||' ��պ�� ���';    
                WHEN    REC.SALARY <= 20000 THEN
                        V_RES := RPAD(REC.EMP_NAME, 40)||TO_CHAR(REC.SALARY, '99,999')||' ���� ���';    
                ELSE    
                        V_RES := RPAD(REC.EMP_NAME, 40)||TO_CHAR(REC.SALARY, '99,999')||' �ʰ��� ���';
        END CASE;
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE(V_RES);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('����� : '|| V_CNT ||'��');
END;