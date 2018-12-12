\set format unaligned \g
\pset title 'Testowy raport z psql - ':format
\pset format :format
\set filename 'raporty/':format'.rap'
SELECT * FROM pg_stat_database \g :filename

\set format aligned \g
\pset title 'Testowy raport z psql - ':format
\pset format :format
\set filename 'raporty/':format'.rap'
SELECT * FROM pg_stat_database \g :filename

\set format wrapped \g
\pset title 'Testowy raport z psql - ':format
\pset format :format
\set filename 'raporty/':format'.rap'
SELECT * FROM pg_stat_database \g :filename

\set format html \g
\pset title 'Testowy raport z psql - ':format
\pset format :format
\set filename 'raporty/':format'.rap'
SELECT * FROM pg_stat_database \g :filename

\set format asciidoc \g
\pset title 'Testowy raport z psql - ':format
\pset format :format
\set filename 'raporty/':format'.rap'
SELECT * FROM pg_stat_database \g :filename

\set format latex \g
\pset title 'Testowy raport z psql - ':format
\pset format :format
\set filename 'raporty/':format'.rap'
SELECT * FROM pg_stat_database \g :filename

\set format latex-longtable \g
\pset title 'Testowy raport z psql - ':format
\pset format :format
\set filename 'raporty/':format'.rap'
SELECT * FROM pg_stat_database \g :filename

\set format troff-ms \g
\pset title 'Testowy raport z psql - ':format
\pset format :format
\set filename 'raporty/':format'.rap'
SELECT * FROM pg_stat_database \g :filename



