INSERT INTO memo (
    no,
    title,
    content,
    writer
) VALUES (
    seq_memo.NEXTVAL,
    'ù ��° �޸�',
    '�ȳ��ϼ���.',
    'sem'
);--seq_~.nextval �˾Ƽ� 1�� �����ؼ� �ö�

update memo
set title = '�� ��° �޸�', content = '�� ��° �� �����', writer = 'chopper'
where no = 3;