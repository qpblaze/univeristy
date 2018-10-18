inner join <=> join
alter join
left (outer) join
right join
full join
cross join

1) varianta b)
la tabelul note se adauga id_prof

select s.nume, s.prenume, trim(p.nume)
    as nume_prof, valoare, titlu_curs
    from profesori p 
    join (select id_prof, min(d.id_prof) as id_prof from didactic d group by d.id_prof) d
    on p.id_prof = d.id_prof
    join note n on n.id_curs = d.id_curs
    join studenti s on s.nr_matricol=n.nr_matricol;

2) 
select nume from studenti s join note n on s.nr_matricol = n.nr_matricol
    join cursuri c on c.id_curs = n.id_curs
    where titlu_curs='BD' and valoare=10;

3)
select trim(p.nume) as nume_prof, titlu_curs
    from profesori p join didactic d on p.id_prof=d.id_prof join cursuri c on c.id_curs = d.id_curs;

4)
select trim(p.nume) as nume_prof, NVL(titlu_curs, 'NU ARE') as cursuri
    from profesori p left join didactic d on ... left join cursuri c on ...;

5) 
a) select titlu_curs from cursuri c left join didactic d on c.id_curs=d.id_curs
    where d.id_prof is null;
c) select titlu_curs from cursuri c where NOT EXISTS(select * from didactic d where d.id_curs = c.id_curs);

6)
b) 
select nume || ' - este prof' as Rezultat from profesori p where not EXISTS 
    (select * from didactic d where p.id_prof = d.id_prof)
    union select titlu_curs || ' - este curs' as Rezultat from cursuri c where not EXISTS
    (select * from didactic d where d.id_curs=c.id_curs);

7)
select s1.nume || ' ' || s1.prenume ||'-'|| s2.nume ||' '|| s2.prenume || ' - ' || to_char(s1.data_nastere,'day') as perechi from studenti s1 JOIN studenti s2 on  s1.nr_matricol<s2.nr_matricol
    where to_char(s1.data_nastere,'day') = to_char(s2.data_nastere,'day')
    order by s1.data_nastere,s1.nume;

8)
select s1.nume || ' ' || s1.prenume || ' a luat nota mai mare ca ' || s2.nume || ' ' || s2.prenume || ' la materia' || titlu_curs
    from cursuri c join note n1 on c.id_curs = n1.id_curs
    join note n2 on c.id_curs = n2.id_curs
    join studenti s1 on s1.nr_matricol = n1.nr_matricol
    join studenti s2 on s2.nr_matricol = n2.nr_matricol
    where n1.valoare > n2.valoare;

BONUS:
