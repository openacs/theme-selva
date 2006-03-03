-- packages/theme-selva/sql/oracle/theme-selva-drop.sql

-- reverting parameters to default
UPDATE apm_parameter_values 
	SET attr_value = '/packages/dotlrn/www/dotlrn-master' 
	WHERE parameter_id IN (SELECT parameter_id FROM apm_parameters WHERE parameter_name='DefaultMaster');

-- setting sloan theme for all portals
UPDATE portals 
	SET theme_id = (SELECT theme_id FROM portal_element_themes WHERE name LIKE '%sloan%');

-- removing selva theme
declare
    v_theme_id	portal_element_themes.theme_id%TYPE;
begin
    SELECT theme_id INTO v_theme_id FROM portal_element_themes WHERE name='selva';
	DELETE FROM portal_element_themes WHERE theme_id = v_theme_id;
    acs_object.del(v_theme_id);

end;
/
show errors
