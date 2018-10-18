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