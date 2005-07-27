<master src="/packages/theme-selva/www/selva-blank-master">
  <if @title@ not nil>
    <property name="title">@title;noquote@</property>
  </if>
  <if @signatory@ not nil>
    <property name="signatory">@signatory;noquote@</property>
  </if>
  <if @focus@ not nil>
    <property name="focus">@focus;noquote@</property>
  </if>
  <property name="header_stuff">
    <link rel="shortcut icon" href="/resources/theme-selva/Selva/default/images/myicon.ico">
    <link rel="stylesheet" type="text/css" href="@css_url@" media="all">
    
    @header_stuff;noquote@
  </property>

  
<div id="wrapper">
  
<!-- header (contains logo) -->
<div id="header">
<img src="/resources/theme-selva/Selva/default/images/logo.gif">
</div>
<!-- Header -->

<div id="site-header">

<div id="breadcrumbs">
<!-- displays "you are here" -->  
<div id="context-bar">
  <if @context_bar@ not nil>
    <div id="breadcrumbs">@context_bar;noquote@</div>
  </if>
  <else>
    <if @context:rowcount@ not nil>
          <multiple name="context">
            <if @context.url@ not nil>
              <a href="@context.url@">@context.label@</a> &#187;
            </if>
            <else>
              @context.label@
            </else>
          </multiple>
    </if>
  </else>
  <div id="navlinks">@subnavbar_link;noquote@</div>
  <div style="clear: both;"></div>
</div>

<div id="status">
<!-- memebers online -->
<div class="action-list users-online">
      <a href="@whos_online_url@">@num_users_online@ <if @num_users_online@ eq 1>member</if><else>members</else> online</a>
  </div>

<!-- small menu -->
  <div class="action-list permanent-navigation">
      <if @admin_url@ not nil>
        <a href="@admin_url@" title="#acs-subsite.Site_wide_administration#">#acs-subsite.Admin#</a>
      </if>
      <if @pvt_home_url@ not nil>
        <a href="@pvt_home_url@" title="#acs-subsite.Change_pass_email_por#">@pvt_home_name@</a>
      </if>
      <if @login_url@ not nil>
        <a href="@login_url@" title="#acs-subsite.Log_in_to_system#">#acs-subsite.Log_In#</a>
      </if>
      <if @logout_url@ not nil>
        <a href="@logout_url@" title="#acs-subsite.Logout_from_system#">#acs-subsite.Logout#</a>
      </if>
  </div>

<!-- user greeting -->
<div class="user-greeting">
    <if @untrusted_user_id@ ne 0>
      #acs-subsite.Welcome_user#
    </if>
    <else>
      #acs-subsite.Not_logged_in#
    </else>
  </div>


</div> <!-- end of status -->
  </div> <!-- end of breadcrumbs -->
  

  

</div>

<if @user_messages:rowcount@ gt 0>
  <div id="user-message">
    <ul>
      <multiple name="user_messages">
        <li>@user_messages.message;noquote@</li>
      </multiple>
    </ul>
  </div>
</if>



<slave>

<div id="footer">
  <div class="action-list">
      <if @num_of_locales@ gt 1>
        <a href="@change_locale_url@">#acs-subsite.Change_locale_label#</a>
      </if>
      <else>
        <if @locale_admin_url@ not nil>
          <a href="@locale_admin_url@">Install locales</a>
        </if>
      </else>
    <a href="/doc/theme-selva/">Documentation on this theme</a>
  </div>
</div>

<if @curriculum_bar_p@ true>
  <p><include src="/packages/curriculum/lib/bar" />
</if>
</div> <!-- end of wrapper -->