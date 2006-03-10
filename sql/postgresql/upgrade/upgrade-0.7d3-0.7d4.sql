-- Adding site templates 

create function inline_0()
returns integer as '
declare 
	v_site_template_id	dotlrn_site_templates.site_template_id%TYPE;
	v_theme_id		portal_element_themes.theme_id%TYPE;
begin
	select theme_id into v_theme_id 
        from portal_element_themes 
	where name = ''selva''; 
	
	select acs_object_id_seq.nextval 
        into v_site_template_id 
        from dual;

	insert into dotlrn_site_templates
	(site_template_id, pretty_name, site_master, portal_theme_id ) 
	values 
	(v_site_template_id, ''Selva Theme'',''/packages/theme-selva/www/selva-master'', v_theme_id);

	return v_site_template_id;

end;' language 'plpgsql';

select inline_0();

drop function inline_0();
