--tarolt eljaras
--számlagenerálás
select * from kolcsonzesek k 
where szamlazva = 'N'

select * from kolcsonzesek k 
join ugyfelek u on u.ugyfelek_id = k.ugyfelek_id 
join autok a on a.auto_id = k.auto_id 
where k.szamlazva = 'N'

---Számlagenerálás

create procedure szamlageneralas() 
--language plpgsql;
begin atomic
	declare k_elado cursor for select * from elado ;
	declare kereso cursor for select u.nev, u.cim, u.adoszam, now(),now()+8,'atutalas',k.kolcsonzes_id, datediff(dd,datum_tol,datum_ig), a.napi_dij, datediff(dd,datum_tol,datum_ig)* a.napi_dij from kolcsonzesek k join ugyfelek u on u.ugyfelek_id = k.ugyfelek_id join autok a on a.auto_id = k.auto_id where k.szamlazva = 'N';
	declare c_vevo_neve varchar (100);
	declare c_vevo_cime varchar (100);
	declare c_vevo_adoszama varchar (50);
	declare c_elado_neve varchar (100);
	declare c_elado_cime varchar (100);
	declare c_elado_adoszama varchar (50);
	declare c_szamla_kelte date;
	declare c_fiz_hatarido date;
	declare c_fiz_modja varchar(10);
	declare c_kolcsonzes_id int;
	declare c_kolcs_napok_szama int;
	declare c_egyseg_ar int;
	declare c_osszeg int;
	declare xid int;

open k_elado;
fetch k_elado into c_elado_neve, c_elado_cime, c_elado_adoszama ; 
close k_elado;
open kereso ;
	loop
		fetch kereso into c_vevo_neve, c_vevo_cime, c_vevo_adoszama, c_szamla_kelte, c_fiz_hatarido, c_fiz_modja, c_kolcs_napok_szama, c_egyseg_ar, c_osszeg;
		insert into szamlafej (vevo_neve, vevo_cime, vevo_adoszama,szamla_kelte, fiz_hatarido, fiz_modja) values (c_vevo_neve, c_vevo_cime, c_vevo_adoszama, c_szamla_kelte, c_fiz_hatarido, c_fiz_modja) returning id into xid;
		insert into szamlatetel (szamlafej_id,kolcsonzes_id, kolcs_napok_szama, egyseg_ar, osszeg) values (xid, c_kolcsonzes_id, c_kolcs_napok_szama, c_egyseg_ar, c_osszeg);
		update kolcsonzesek set szamlazva = 'Y'	where kolcsonzes_id = c_kolcsonzes_id;
	exit when not found;
	end loop;

	
	close kereso;
end;
