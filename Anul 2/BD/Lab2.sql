1.
select sysdate as "Astazi" from dual;

2.
select nume, data_nastere, ROUND(MONTHS_BETWEEN(sysdate, data_nastere)) from studenti;

3.
select nume, NVL(to_char(data_nastere, 'day'), 'data nespecificata') as "zi" from studenti;

4.
select 'Studentul ' || nvl(prenume, 'fara prenume') || 'este in grupa' || grupa as "studenti/grupe" from studenti;

5.
select nvl(rpad(bursa, 10, '$'), 'fara bursa') from studenti;

6.
select lower(substr(prenume, 1, 1)) || upper(substr(prenume, 2)) as "prenume", length(TRIM(nume)) as "lungime" from profesori where nume like 'B%';

7.
select nume, prenume, to_char(data_nastere, 'month') as luna from studenti where bursa is null or bursa=0 order by extract('month' from data_nastere);

9.