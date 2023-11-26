select * from autok 

select * from ugyfelek 

select * from kolcsonzesek k  

select * from elado 

----
--Ki melyik autót mettől meddig kölcsönözte?
select u.nev,a.rendszam, datum_tol, datum_ig  from kolcsonzesek k 
join ugyfelek u 
on u.ugyfelek_id = k.ugyfelek_id 
join autok a 
on a.auto_id = k.auto_id 

-----
-- Melyik auto nincs kiadva? 
select rendszam from autok 
where jarmu_foglaltsag = 'N'

----
--Melyik ügyfél hányszor bérelt autót? 
select u.nev, (select count(*) from kolcsonzesek k where k.ugyfelek_id = u.ugyfelek_id) from ugyfelek u