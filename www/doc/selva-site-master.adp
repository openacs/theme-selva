<master src="/www/Selva/selva-blank-master">

 <!-- Start selva-site-master -->
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
    @header_stuff;noquote@
  </property>


<!-- Header -->

  <div class="status">
  <!-- <div class="action-list permanent-navigation"> -->
      <if @admin_url@ not nil>
       <a href="@admin_url@" title="#acs-subsite.Site_wide_administration#">#acs-subsite.Admin#</a></span>
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

  <div class="status">
    <ul>
      <li><a href="@whos_online_url@">@num_users_online@ <if @num_users_online@ eq 1>member</if><else>members</else> online</a></li>
    </ul>
  </div>

  <div class="user-greeting">
    <if @untrusted_user_id@ ne 0>
      @user_name@
    </if>
    <else>
      #acs-subsite.Not_logged_in#
    </else>
  </div>

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

<div id="context-bar">
  <if @context_bar@ not nil>
    <div id="breadcrumbs">@context_bar;noquote@</div>
  </if>
  <else>
    <if @context:rowcount@ not nil>
      <div id="breadcrumbs"> 
        <ul>
          <multiple name="context">
            <if @context.url@ not nil>
              <li><a href="@context.url@">@context.label@</a> &#187;</li>
            </if>
            <else>
              <li>@context.label@</li>
            </else>
          </multiple>
        </ul>
      </div>
    </if>
  </else>

  <div id="navlinks">@subnavbar_link;noquote@</div>
  <div style="clear: both;"></div>
</div>

<hr>

<slave>


<div id="site-footer">
  <div class="action-list">
    <ul>
      <if @num_of_locales@ gt 1>
        <li><a href="@change_locale_url@">#acs-subsite.Change_locale_label#</a></li>
      </if>
      <else>
        <if @locale_admin_url@ not nil>
          <li><a href="@locale_admin_url@">Install locales</a></li>
        </if>
      </else>
    </ul>
  </div>
</div>

<if @curriculum_bar_p@ true>
  <p><include src="/packages/curriculum/lib/bar" />
</if>
