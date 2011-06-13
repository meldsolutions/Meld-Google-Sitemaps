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
<cfsavecontent variable="local.str">
<cfoutput>
<link rel="stylesheet" href="#rc.$.globalConfig().getContext()#/plugins/#rc.pluginConfig.getDirectory()#/admin/assets/css/custom-theme/jquery-ui-1.8.custom.css" type="text/css" media="all">
<link rel="stylesheet" href="#rc.$.globalConfig().getContext()#/plugins/#rc.pluginConfig.getDirectory()#/admin/assets/css/custom-theme/jquery-ui-custom.css" type="text/css" media="all">
</cfoutput>
</cfsavecontent>
<cfset arrayPrepend( rc.headLoader,local.str )>
</cfsilent>
