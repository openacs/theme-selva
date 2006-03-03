-- packages/theme-selva/sql/oracle/theme-selva-create.sql

-- Setting default template to Selva
UPDATE apm_parameter_values 
	SET attr_value = '/packages/theme-selva/www/selva-master' 
	WHERE parameter_id IN (SELECT parameter_id FROM apm_parameters WHERE parameter_name='DefaultMaster');

-- Adding selva as new theme
declare
	v_theme_id	portal_element_themes.theme_id%TYPE;
begin
	v_theme_id := portal_element_theme.new (
		name 			=> 'selva',
		description		=> 'Selva Theme',
		filename		=> '../../theme-selva/www/themes/selva-theme',
		resource_dir	=> '../../theme-selva/www/themes/selva-theme'
	);
end;
/
show errors

-- Setting portals theme to Selva
UPDATE portals 
	SET theme_id = (SELECT theme_id FROM portal_element_themes WHERE name='selva');