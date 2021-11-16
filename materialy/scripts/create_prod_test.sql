\timing
SELECT EXISTS(SELECT 1 FROM pg_tables WHERE tablename='version') AS table_exists \gset

\if :table_exists
  \echo Tabela już istnieje, pomijam tworzenie
\else
  \echo Tworzenie tabeli version
  CREATE TABLE version(id serial primary key, version_no serial, comments text) \g
\endif

\echo pobieranie wartości sekwencji
SELECT nextval('version_id_seq') as version_id, nextval('version_version_no_seq') as version_no \gset SEQ

\echo sprawdzanie serwera
SELECT current_setting('port') = '6002' AS is_prod \gset
\if :is_prod
  \set comments 'Produkcja: wersja: ':SEQversion_no
  \echo server: PRODUKCJA
\else
  \set comments 'Test: wersja: ':SEQversion_no
  \echo server: TEST
\endif

\echo insert
INSERT INTO version(id,version_no,comments)VALUES(:SEQversion_id, :SEQversion_no, :'comments') \g
SELECT * FROM version WHERE id=:SEQversion_id \gset
\echo tabela: *version* utworzony rekord:
\echo id: :SEQversion_id
\echo version_no: :SEQversion_no
\echo comments: :comments

