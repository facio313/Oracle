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
- �־��� ���ڿ� ��, �쿡 �����ϴ� ��ȿ�� ������ ����
- �ܾ� ������ ������ �������� ����