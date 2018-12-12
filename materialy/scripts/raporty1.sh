#!/bin/bash
rFile='raporty/test1.rap'

echo *** serwer testowy***"" >> $rFile

echo "Lista baz:" >> $rFile
psql "service=db_test" -c '\l' >> $rFile
echo "" >> $rFile
psql "service=db_test" -c '\dt' >> $rFil

echo "***serwer prod***" >> $rFile

echo "Lista baz: >> $rFile
psql "service=db_prod" -c '\l' >> $rFile
echo "lista tabel :" >> $rFile
psql "service=db_prod" -c '\dt' >> $rFile




