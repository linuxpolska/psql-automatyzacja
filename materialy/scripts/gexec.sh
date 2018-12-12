#!/bin/bash
seq 1 9 | sed 's/.*/CREATE TABLE tabela& (id serial primary key, nazwa text); INSERT INTO tabela& (nazwa) VALUES ($$Volvo$$);/' | psql "service=db_test"

seq 1 9 | sed 's/.*/CREATE TABLE tabela& (id serial primary key, nazwa text); INSERT INTO tabela& (nazwa) VALUES ($$Volvo$$);/' | psql "service=db_prod"

