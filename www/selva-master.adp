<if @dotlrn_installed_p@ eq 1>
	<master src="/packages/theme-selva/www/selva-lrn-master">
</if>
<else>
	<master src="/packages/theme-selva/www/selva-site-master">
</else>
  <property name="title">@title;noquote@</property>
  <property name="context">@context;noquote@</property>
  <if @displayed_object_id@ not nil><property name="displayed_object_id">@displa
yed_object_id;noquote@</property></if>
  <if @header_stuff@ not nil><property name="header_stuff">@header_stuff;noquote@</property></if>
  </property>

<slave>
