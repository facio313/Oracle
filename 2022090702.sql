2022-0907-02) Stored Procedure(Procedur)
- Ư�� ������ ó���Ͽ� ��� ���� ��ȯ���� �ʴ� ���� ���α׷�
- �̸� �����ϵǾ� ����(������ ȿ������ ����, ��Ʈ��ũ�� ���� ���޵Ǵ� �ڷ��� ���� �۴�)
(�������)
CREATE [OR REPLACE] PROCEDURE ���ν�����[(
    ������ [IN|OUT|INOUT]  ������Ÿ��[:=����Ʈ��], --ũ�������ϴ� �� �ƴ�!!!!�ƴ϶�!
            :
    ������ [IN|OUT|INOUT]  ������Ÿ��[:=����Ʈ��],
IS|AS --DECLARE�� ���� �κ�
    ���𿵿�
BEGIN
    ���࿵�� -- SQL,�ݺ�,�б�
END;
- '������' : �Ű�������
- 'IN|OUT|INOUT' : �Ű������� ���� ����(IN : �Է¿�, OUT : ��¿�, INOUT : ����� ����)
- '������Ÿ��' : ũ�⸦ ����ϸ� ����
- '����Ʈ��' : ����ڰ� �Ű������� ����ϰ� ���� �������� �ʾ��� �� �ڵ����� �Ҵ�� ��
--�Լ��� ���� ���� ���� ���� ��
--��ȯ��. SELECT���� �� �� �ִ��� ������
--OUT�� ���� ���� ���� ��ȯ���� �ƴ϶� ��°���
--��ȯ���� ���ν����� �Լ��� ���� ���� ����
--IN,OUT�� �ʹ� ������ Ŀ�� �� ���� �� ����
--DEFAULT���� ���� ����! ��Ȯ�ϰ� ������ ��!
--IN,OUT,INOUT�� �����ϸ� IN���� ��޵�

(���๮) ���������� ������ ��
EXECUTE|EXEC    ���ν�����[(�Ű�����list)];
�Ǵ� ���ν����� �ٸ� ��Ͽ��� ������ ���
���ν�����[(�Ű�����list)];

��뿹)
�μ���ȣ�� �Է¹޾� �ش�μ� �μ����� �̸�, ��å, �μ���, �޿��� ����ϴ� ���ν����� �ۼ��Ͻÿ�
CREATE OR REPLACE PROCEDURE PROC_EMP01(
    P_DID   IN   HR.DEPARTMENTS.DEPARTMENT_ID%TYPE)
IS
    V_NAME  VARCHAR2(100);
    V_JOBID HR.JOBS.JOB_ID%TYPE;
    V_DNAME VARCHAR2(100);
    V_SAL   NUMBER := 0;
BEGIN
    SELECT  B.EMP_NAME, B.JOB_ID, A.DEPARTMENT_NAME, B.SALARY
    INTO    V_NAME, V_JOBID, V_DNAME, V_SAL
    FROM    HR.DEPARTMENTS A, HR.EMPLOYEES B
    WHERE   A.DEPARTMENT_ID =   P_DID
    AND     A.MANAGER_ID    =   B.EMPLOYEE_ID;
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : '||P_DID);
    DBMS_OUTPUT.PUT_LINE('�μ��� : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('�����ڵ� : '||V_JOBID);
    DBMS_OUTPUT.PUT_LINE('�μ��� : '|| V_DNAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||V_SAL);
    DBMS_OUTPUT.PUT_LINE('----------------------------------');
END;

(����)
EXECUTE PROC_EMP01(60);