<if @dotlrn_installed_p@ eq 1>
	<master src="/packages/theme-selva/www/selva-lrn-master">
</if>
<else>
	<master src="/packages/theme-selva/www/selva-site-master">
</else>
  <property name="title">@title;noquote@</property>
  <property name="context">@context;noquote@</property>
  <property name="displayed_object_id">@displayed_object_id@</property>
  <property name="header_stuff">@header_stuff;noquote@</property>
  <if @focus@ not nil><property name="focus">@focus;noquote@</property></if>

<slave>
