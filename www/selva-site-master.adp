<master src="/www/blank-master">
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
  
<if @error_messages@ not nil> 
<!-- 
@error_messages;noquote@
-->
</if>

<!-- Header -->
<div id="site-header">
<if @is_logo_url@ not nil> 
  <img src="@is_logo_url;noquote@" alt="Logo">
</if>

<div id="breadcrumbs">
  <if @context_bar@ not nil>
    @context_bar;noquote@
  </if>

<div id="status">
<!-- memebers online -->
<div class="action-list users-online">
     <a href="@whos_online_url@">@num_users_online@ <if @num_users_online@ eq 1>member</if><else>members</else> #theme-selva.online#</a>
     <if @untrusted_user_id@ ne 0>
      | <a href="@logout_url@" title="#acs-subsite.Logout_from_system#">#acs-subsite.Logout#</a>
    </if>
    <else>
      | <a href="/register/">#acs-subsite.Log_In#</a>
    </else>
  </div>

<!-- user greeting -->
<div class="user-greeting">
    <if @untrusted_user_id@ ne 0>
      #acs-subsite.Welcome_user#  |
    </if>
  </div>


</div> <!-- end of status -->

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



<slave>

<div class="footer">
 <a href="http://validator.w3.org/check/referer">XHTML</a>,
 <a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a>,
 <a href="http://feedvalidator.org/check?url=@url@">RSS</a>,
 <a href="http://www.contentquality.com/mynewtester/cynthia.exe?Url1=@url@" title="#theme-selva.accessibility_note#">508</a>
</div>

<if @curriculum_bar_p@ true>
  <p><include src="/packages/curriculum/lib/bar" />
</if>
</div> <!-- end of wrapper -->
