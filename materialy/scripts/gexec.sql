SELECT
    format('UPDATE %I SET nazwa = upper(nazwa)', relname) AS UPDATE,
    format('INSERT INTO %I (nazwa) values (%L)', relname, 'Mercedes') AS INSERT
    format('INSERT INTO %I (nazwa) values (%L)', relname, 'Jaguar') AS INSERT
    format('INSERT INTO %I (nazwa) values (%L)', relname, 'Fiat') AS INSERT
FROM pg_class WHERE relkind = 'r' AND relname ~ '^tabela[0-9]$';
