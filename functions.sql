--functions
drop function lefoglalva();
create function lefoglalva()
returns trigger as $lefoglalas$
begin 
	update autok set jarmu_foglaltsag = 'Y' where autok.auto_id = NEW.auto_id;
return NEW;
end;
$lefoglalas$
 language plpgsql;

---------

drop function visszavetel();
create function visszavetel()
returns trigger as $vissza$
begin 
	update autok set jarmu_foglaltsag = 'N' where autok.auto_id = NEW.auto_id;
return NEW;
end;
$vissza$
 language plpgsql;


---Trigger 
create trigger lefoglalas
after insert on kolcsonzesek 
for each row 
execute function lefoglalva();

---
create trigger vissza
after update on kolcsonzesek 
for each row 
execute function visszavetel();


--trigger teszt

select * from autok a 

select * from kolcsonzesek k 

insert into kolcsonzesek (ugyfelek_id,auto_id,datum_tol, datum_ig)
values (1,1,'2023-04-10','2023-04-15')

update kolcsonzesek set vissza_nap = '2023-04-15'
where kolcsonzes_id = 6
