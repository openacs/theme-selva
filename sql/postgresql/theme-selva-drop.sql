UPDATE apm_parameter_values SET attr_value = '/packages/dotlrn/www/dotlrn-master' WHERE parameter_id IN (SELECT parameter_id FROM apm_parameters WHERE parameter_name='DefaultMaster');
UPDATE portals SET theme_id = (SELECT theme_id FROM portal_element_themes WHERE name LIKE '%sloan%');
DELETE FROM portal_element_themes WHERE name = 'selva';

create function inline_0 ()
returns integer as '
declare
    theme                       portal_element_themes.theme_id%TYPE;
begin
    SELECT theme_id INTO theme FROM portal_element_themes WHERE name=''selva'';
    perform acs_object__delete(theme);

return 0;

end;' language 'plpgsql';

select inline_0();

drop function inline_0();


