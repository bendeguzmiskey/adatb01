ALTER TABLE Foglalas ADD 
   email NVARCHAR(120) DEFAULT 'pistike@gmail.com' NOT NULL;
CREATE TABLE Foglalas_maszkolt
(PK_Foglalas INT IDENTITY PRIMARY KEY,
foglalas_pk INT MASKED WITH (Function = 'default()'),
ugyfel_fk nvarchar(40) MASKED WITH (Function = 'partial(1,"XXX",1)'),
szoba_fk INT,
mettol date MASKED WITH (Function = 'default()'),
meddig date MASKED WITH (Function = 'default()'),
felnott_szam INT MASKED WITH (FUNCTION = 'random(1,5)'),
gyermek_szam INT MASKED WITH (FUNCTION = 'random(1,5)'),
email NVARCHAR(240) MASKED WITH (function = 'email()')
)

INSERT INTO  Foglalas_maszkolt(foglalas_pk, ugyfel_fk, szoba_fk, mettol, meddig,felnott_szam,gyermek_szam,email)
SELECT
    foglalas_pk,
    ugyfel_fk,
    szoba_fk,
    mettol,
    meddig,
    felnott_szam,
    gyermek_szam,
    email
FROM Foglalas;

CREATE USER MaskUser WITHOUT Login;
GRANT SELECT ON Foglalas_maszkolt TO MaskUser

EXECUTE AS User= 'MaskUser';
SELECT * FROM Foglalas_maszkolt
REVERT
