CREATE ROLE grafana LOGIN PASSWORD 'grafana';
GRANT CONNECT ON database fsa_parser TO grafana;
GRANT USAGE ON SCHEMA public TO grafana;
-- SELECT 'GRANT SELECT ON '||schemaname||'."'||tablename||'" TO grafana;' FROM pg_tables WHERE schemaname IN ('public') and tablename like 'fsa_%' ORDER BY schemaname, tablename;

 GRANT SELECT ON public."fsa_parser_certificate" TO grafana;
 GRANT SELECT ON public."fsa_parser_certificate_list" TO grafana;
 GRANT SELECT ON public."fsa_parser_declaration" TO grafana;
 GRANT SELECT ON public."fsa_parser_declaration_list" TO grafana;
 GRANT SELECT ON public."fsa_parser_ral" TO grafana;
 GRANT SELECT ON public."fsa_parser_ral_list" TO grafana;
 GRANT SELECT ON public."fsa_parser_wizard_main" TO grafana;
 GRANT SELECT ON public."fsa_parser_wizard_main_sql" TO grafana;
 GRANT SELECT ON public."fsa_parser_wizard_main_subline" TO grafana;
 