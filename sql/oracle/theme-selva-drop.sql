-- packages/theme-selva/sql/oracle/theme-selva-drop.sql

declare 

	selva_site_template_id  dotlrn_site_templates.site_template_id%TYPE;
	sloan_site_template_id  dotlrn_site_templates.site_template_id%TYPE;
	selva_theme_id  portal_element_themes.theme_id%TYPE;
	sloan_theme_id  portal_element_themes.theme_id%TYPE;

begin

	-- reverting selva site-templates to sloan

	select site_template_id into selva_site_template_id
		from dotlrn_site_templates
		where pretty_name = 'Selva Theme';

	select site_template_id into sloan_site_template_id
		from dotlrn_site_templates
		where pretty_name = '#new-portal.sloan_theme_name#';

	update apm_parameter_values 
        set attr_value = sloan_site_template_id
		where parameter_id in ( select parameter_id 
				from apm_parameters 
				where (parameter_name = 'CommDefaultSiteTemplate_p' or parameter_name = 'UserDefaultSiteTemplate_p') and attr_value = selva_site_template_id);

	-- reverting to sloan for user/comm 

	update dotlrn_communities_all
		set site_template_id = sloan_site_template_id
		where site_template_id = selva_site_template_id;

	update dotlrn_user_profile_rels
		set site_template_id = sloan_site_template_id
		where site_template_id = selva_site_template_id;

	-- removing selva site-template

	delete from dotlrn_site_templates where site_template_id = selva_site_template_id;

	-- removing the Selva theme

	select theme_id into selva_theme_id 
        from portal_element_themes 
		where name = 'selva'; 

	select theme_id into sloan_theme_id 
        from portal_element_themes 
		where name = '#new-portal.sloan_theme_name#'; 

	update portals set theme_id = sloan_theme_id where theme_id = selva_theme_id;
	delete from portal_element_themes WHERE theme_id = selva_theme_id;
    acs_object.del(selva_theme_id);

end;
/
show errors;
