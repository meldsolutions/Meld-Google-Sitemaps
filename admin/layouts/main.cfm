<!---

This file is part of the The Meld Google Sitemaps Plugin.

The Meld Google Sitemaps Plugin is licensed under the GPL 2.0 license
Copyright (C) 2010 Meld Solutions Inc. http://www.meldsolutions.com/

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation, version 2 of that license..

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.


--->
<cfsilent>
	<!--- headers --->
</cfsilent>
<cfoutput>
<div class="mura-header">
	<h1>#rc.pluginConfig.getName()#</h1>
	#view("/global/menu")#
</div>
<div id="meld-logo" class="clearfix">
	<a href="http://www.meldsolutions.com" target="_new"></a>
</div>
<cfif ArrayLen( rc.errors )>
	#view("/global/errors")#
</cfif>
<div class="block block-constrain">
  <div class="block block-bordered">
   <div class="block-content">
   #body#
   </div>
  </div>
</div>
</cfoutput>