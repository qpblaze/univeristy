select initcap(nume), substr(prenume, 2), 
    case bursa
        when 450 then 'premiul 1'
        when 350 then 'premiul 2'
        when 250 then 'premiul 3'
    else '?' end as "Premii"
from studenti;


select nume, prenume, trim(to_char(data_nastere, 'day')) from studenti where trim(to_char(data_nastere, 'day')) = 'Friday' or trim(to_char(data_nastere, 'day')) = 'Saturday' order by nume;


select nume from studenti where grupa like 'B%' and trim(to_char(data_nastere, 'day')) ='tuesday'

select nume, prenume, length(nume) + length(prenume) as LUNGIME from studenti where grupa like 'B%' and bursa is null order by 3;

select nume, rpad(bursa, 6, '*') from studenti where bursa <> 0;

select nume || ' ' || prenume || ':)' as "Viata de student",
CASE WHEN bursa <> 0 THEN 'Student fericit! :D'
   ELSE 'Student trist! :(' END as "Bani de zacusca" from studenti;

select regexp_replace(nume, '[aeiouAEIOU]','') || '->' || regexp_replace(prenume, '[b, c, d, f, h, j, k, l, m, n, p, q, r, s, sttvwxzy]','') as "N??e" from studenti;