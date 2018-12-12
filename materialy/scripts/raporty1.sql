SELECT current_setting('port') = '6002' AS is_prod \gset
\if :is_prod
  \set dbTXT '**serwer testowy***'
\else
  \set dbTXT '***server prod***'
\endif
\o raporty/test.rap

\qecho :dbTXT
\gecho "lista baz danych: "
\l
\qecho "lista tabel: 
\dt

