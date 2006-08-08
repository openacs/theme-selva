-- packages/theme-selva/sql/oracle/theme-selva-create.sql

declare
	v_theme_id	portal_element_themes.theme_id%TYPE;
begin
	-- Adding selva as new theme
	v_theme_id := portal_element_theme.new (
		name 			=> 'selva',
		description		=> 'Selva Theme',
		filename		=> '../../theme-selva/www/themes/selva-theme',
		resource_dir	=> '../../theme-selva/www/themes/selva-theme'
	);

	-- Adding Selva to site-templates
	insert into dotlrn_site_templates
		(site_template_id, pretty_name, site_master, portal_theme_id)
	values
		(acs_object_id_seq.nextval, 'Selva Theme', '/packages/theme-selva/www/selva-master', v_theme_id);
	
end;
/
show errors
