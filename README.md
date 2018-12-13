# psql-automatyzacja
To jest zestaw materiałów będący integralną częścią video szkolenia.
Zawiera instrukcje oraz skrypty i pliki konfiguracyjne użyte podczas nagrania, umożliwiając tym samym samodzielne wykonanie przykładów z nagrania.

##Przygotowanie środowiska roboczego
###### Instalacja środowiska docker
Ubuntu 18.04
```
add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
apt-get install docker-ce
```
Centos/Fedora/Redhat
```
yum install docker
```
###### Start środowiska
Ubuntu 18.04
```
sudo systemctl start docker
```
Centos/Fedora/Redhat
```
sudo systemctl start docker
```
###### Uruchomienie kontenera
Do katalogu `/tmp/materialy` wgrać zawartość katalogu `materialy` tego repozytorium, lub poprawić ścieżkę dostępu przy wywołaniu komendy 
```
docker run --name lab -e POSTGRES_PASSWORD=postgres -v /tmp/materialy:/var/lib/postgresql/materialy -d postgres
docker ps
docker exec -it lab bash
```
###### Zatrzymanie kontenera
```
docker stop lab
```
###### Ponowny start kontenera
```
docker start lab
```
###### Logowanie do kontenera
```
docker exec -it lab bash
```
###### Przygotowanie kontenera do pracy
po ówczesnym zalogowaniu do kontenera
```
chown -R postgres: /var/lib/postgresql
apt update
apt install vim links -y
```
## Ćwiczenia
###### Utworzenie 2 instancji bazy danych
```
mkdir prod
mkdir test
initdb -D prod
initdb -D test
echo 'export PATH=/usr/lib/postgresql/11/bin/:$PATH' >> .bash_profile
source .bash_profile
```
###### Szybka konfiguracja baz danych
```
modyfikacja parametrów w plikach konfiguracyjnych :
test/postgresql.conf : port=6001
prod/postgresql.conf : port=6002
w obu plikach :
logging_collector=on
log_directory='log'
log_filename='postgresql-%Y-%m-%d.log

modyfikacja linii w plikach konfiguracyjnych:
test/pg_hba.conf : host	all	all	127.0.0.1/32	md5
prod/hba.conf : host	all	all	127.0.0.1/32	md5
```
###### Uruchomienie obu instancji baz
```
pg_ctl -D test/ start
pg_ctl -D prod/ start
```
###### Logowanie do instancji baz
```
psql -p 6001 

SHOW port
SHOW data_directory;
\c
\q
```
```
psql -p 6002

SHOW port
SHOW data_directory;
\c
\q
```
###### Uruchomienie skryptów tworzących bazy danych i użytkowników
```
psql -p 6001 -f scripts/create_test.sql 

psql -p 6002  -h localhost -U user_prod db_prod
\i scripts/create_prod.sql
\q
```
sprawdzenie:
```
psql -p 6001 -h localhost -U user_test db_test
\c
SHOW port;
\q
psql -p 6002 -h localhost -U user_prod db_prod
\c
SHOW port;
\q
```
###### Definicje zmiennych
```
cp materialy/.bash_profile ./
cat .bash_profile
source .bash_profile
```
```
psql
SHOW port;
SHOW data_directory;
\q
```
zmiana wartości zmiennych w pliku .bash_profile
```
export PGPORT=6002
export PGUSER=user_prod
export PGDATABASE=db_prod
```
wczytanie zmian
```
source .bash_profile
psql
SHOW port;
```
ustawienia eliminujące potrzebę wpisywania hasła
```
cp materialy/.pgpass ./
cat .pgpass

``` 

###### Ustawienia narzędzia psql
```
cp materialy/.psqlrc ./
cat .psqlrc
```
###### Jeszcze inny sposób połączenia - services
```
cp materialy/.pg_service.conf ./
psql ”service=db_test”
show port;
\q
psql ”service=db_prod”
show port;
\q
```
###### Plik wdrożeniowy 1
```
cat materialy/scripts/gexec.sh
materialy/scripts/gexec.sh
psql "service=db_test" -c "\dt"
psql "service=db_test" -c "SELECT * FROM tabela4"
psql "service=db_prod" -c "\dt"
psql "service=db_test" 
\! psql "service=db_prod" -c "SELECT * FROM tabela6"
\! psql "service=db_prod" -c "\dt"
\p
SELECT * FROM tabela9;
\p
\e
```
zmiana zapytania, wyjście z vim'a :wq
```
\e
:w zapytanie.sql
```


###### Plik wdrożeniowy 2

###### Raporty 
```
mkdir raporty
psql „service=db_test” -f materialy/scripts/raporty.sql

\pset 
SELECT * FROM tabela1;
\pset border 2
SELECT * FROM tabela1;
zmiana ustawień
\pset title lista
SELECT * FROM tabela1;
\pset format unaligned
SELECT * FROM tabela1;
\pset fieldsep ‘,’
\pset recordsep '|'
\pset tuples_only on
SELECT * FROM tabela1;
SELECT * FROM tabela1 \g raporty/raport.csv
\! cat raport/raport.csv

\pset tuples_only off
\pset format html
\pset tableattr ‘cellpadding=”5”’
SELECT * FROM tabela1;
SELECT * FROM tabela1 \g raporty/raport.html
\! links raporty/raport.html


\o raporty/raport.html
SELECT * FROM tabela1;
SELECT * FROM tabela1;
SELECT * FROM tabela1;
\! links raporty/raport.html
\o
SELECT * FROM tabela1;

\! links raporty/raport.html
```
###### Raporty 2
```
materialy/scripts/raporty1.sh
vi raporty/test1.rap
psql „service=db_test” -f materialy/scripts/raporty1.sql
testowy.rap
vi raporty/testowy.rap
psql „service=db_prod” -f materialy/scripts/raporty1.sql
produkcja.rap
vi raporty/produkcja.rap
```
###### gdesc && watch
```
\timing
SELECT *, pg_sleep(1) FROM tabela1 \g
SELECT *, pg_sleep(1) FROM tabela1 \gdesc

SELECT * FROM tabela1 \watch 1
```
  
