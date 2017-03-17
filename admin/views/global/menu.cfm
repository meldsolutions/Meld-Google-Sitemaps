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
<cfoutput>
  <div class="nav-module-specific btn-group">
  	<a class="btn" href="?"><i class="mi-plus-circle"></i> #rc.mmRBF.key('dashboard')#</a>
  	<a class="btn" href="?action=admin:settings">#rc.mmRBF.key('settings')#</a>
  	<a class="btn" href="?action=process:&site=#rc.siteID#" target="_new">#rc.mmRBF.key('manual')#</a>
  	<a class="btn dropdown-toggle" data-toggle="dropdown" href="##">#rc.mmRBF.key('about')#</a>
	<ul class="dropdown-menu dropdown-menu-right mura-user-tools">
		<li class="first"><a href="?action=admin:about">#rc.mmRBF.key('about')#</a></li>
		<li><a href="?action=admin:about.support">#rc.mmRBF.key('support')#</a></li>
		<li class="last"><a href="?action=admin:about.license">#rc.mmRBF.key('license')#</a></li>
	</ul>
  </div>
</cfoutput>