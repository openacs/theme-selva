UPDATE apm_parameter_values SET attr_value = '/packages/theme-selva/www/selva-master' WHERE parameter_id IN (SELECT parameter_id FROM apm_parameters WHERE parameter_name='DefaultMaster')
				
								
