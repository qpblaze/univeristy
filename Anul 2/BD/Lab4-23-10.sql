2) 
select s.nume ||' '||s.prenume||' este prieten cu '||trim(p.nume)||' '||p.prenume as result
from studenti s join profesori p on length(s.nume)=length(trim(p.nume));

3)
a)
select titlu_curs from cursuri c join note n on n.id_curs=c.id_curs
    MINUS select titlu_curs from ... where valoare > 8; 

b) 
select distinct titlu_curs from cursuri c where c.id_curs not 
    in (select id_curs from note where valoare > 8);

4)
a) 
select nume, s.m_mat from studenti s join note n on s.m_mat n.m_mat
    minus select nume, s.m_mat from .. where valoare < 7;
b)
select distinct nume, s.m_mat from ... where s.m_mat NOT 
    IN (select m_mat from note where valoare < 7);

5)

