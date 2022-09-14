INSERT INTO memo (
    no,
    title,
    content,
    writer
) VALUES (
    seq_memo.NEXTVAL,
    '첫 번째 메모',
    '안녕하세요.',
    'sem'
);--seq_~.nextval 알아서 1씩 증가해서 올라감

update memo
set title = '세 번째 메모', content = '세 번째 글 등록함', writer = 'chopper'
where no = 3;