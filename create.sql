--- Autok tábla létrehozó
CREATE TABLE autok  (
  auto_id              SERIAL PRIMARY key not null,
  gyartmany           VARCHAR(100) ,
  tipus               VARCHAR(100) ,
  kivitel             VARCHAR(100) ,
  alvazszam			  VARCHAR(100) ,
  motorszam			  VARCHAR(100) ,
  uzemanyag			  VARCHAR(10) ,
  szin				  VARCHAR(20) ,
  rendszam			  VARCHAR(10) ,
  évjárat			  INT		  ,
  jarmu_foglaltsag    VARCHAR(1) default 'N', -- létrehozéskor alapesetben még nem foglalt
  napi_dij            INT

  
);

--- ügyfelek tábla létrehozó
CREATE TABLE ugyfelek  (
  ugyfelek_id              SERIAL PRIMARY key not null,
  nev           VARCHAR(100) ,
  cim               VARCHAR(100) ,
  adoszam             VARCHAR(100) ,
  email			  VARCHAR(100) ,
  telefonszam			  VARCHAR(100) 
  
);

--- kolcsonzesek tábla létrehozó
CREATE TABLE kolcsonzesek  (
  kolcsonzes_id              SERIAL PRIMARY key not null,
  ugyfelek_id           int ,
  auto_id               int ,
  datum_tol             date ,
  datum_ig			    date ,
  vissza_nap			date,
  szamlazva				varchar(1) default 'N', -- alapesetben létrehozáskor nincs még kiszámlázva
  constraint fk_ugyfelek
  foreign key(ugyfelek_id)
  references ugyfelek(ugyfelek_id),
  constraint fk_autok
  foreign key(auto_id)
  references autok(auto_id)
  
  
);

-- eladó adatait tartalmazó paraméter tábla létrehozó (egyetlen rekord összesen)
CREATE TABLE elado  (
 
  elado_neve              varchar(100) ,
  elado_cime			varchar(100),
  elado_adoszam			 varchar(50)
  );
  
--- számlafej tábla létrehozó
CREATE TABLE szamlafej  (
  szamlafej_id    SERIAL PRIMARY key not null,  -- ez a számlaszám is!! 
  ugyfelek_id            int,
  vevo_neve              varchar(100) ,
  vevo_cime				 varchar(100),
  vevo_adoszam			 varchar(50),
  elado_neve              varchar(100) ,
  elado_cime			varchar(100),
  elado_adoszam			 varchar(50),
  számla_kelte			date,
  fiz_határido			date,
  fizetve				date,
  fiz_modja				varchar(10),
  constraint fk_ugyfelek
  foreign key(ugyfelek_id)
  references ugyfelek(ugyfelek_id)
  
  
  
);

--- számlatetel tábla létrehozó
CREATE TABLE szamlatetel  (
  szamlatetel_id    SERIAL PRIMARY key not null,  
  szamlafej_id      int,
  kolcsonzes_id     int,
  kolcs_napok_szama	int,
  egyseg_ar         int,
  osszeg			int,
  
  constraint fk_szamlafej
  foreign key(szamlafej_id)
  references szamlafej(szamlafej_id),
  constraint fk_kolcsonzes
  foreign key(kolcsonzes_id)
  references kolcsonzesek(kolcsonzes_id)
  
  
  
);
