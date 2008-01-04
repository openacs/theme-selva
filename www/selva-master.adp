<if @dotlrn_installed_p@ eq 1>
	<master src="/packages/theme-selva/www/selva-lrn-master">
</if>
<else>
	<master src="/packages/theme-selva/www/selva-site-master">
</else>
  <if @doc@ defined><property name="&doc">doc</property></if>
  <property name="context">@context;noquote@</property>
  <property name="displayed_object_id">@displayed_object_id@</property>
  <if @focus@ not nil><property name="focus">@focus;noquote@</property></if>

<slave>
