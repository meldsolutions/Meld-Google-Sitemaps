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
<cfcomponent extends="MeldGoogleSitemaps.com.meldsolutions.mura.MuraEventHandler">
	<cfset variables.framework=getFrameworkVariables()>

	<cffunction name="onApplicationLoad">
		<cfargument name="$">

		<cfset var state=preseveInternalState(request)>
		<cfset var appreloadKey = $.GlobalConfig().getValue('appreloadKey') />

		<cfif len( appreloadKey ) and structKeyExists(url,appreloadKey)> 
			<cfset url[variables.framework.reload] = true />
		</cfif>

		<!--- invoke onApplicationStart in the application.cfc so the framework can do its thing --->
		<cfinvoke component="#pluginConfig.getPackage()#.Application" method="onApplicationStart" />
		<cfset restoreInternalState(request,state)>

		<cfset variables.pluginConfig.addEventHandler(this)>
	</cffunction>

	<cffunction name="onGlobalSessionStart" output="false">
		<cfargument name="$" required="true" hint="mura scope" />
		<cfset var state=preseveInternalState(request)>
		<cfinvoke component="#pluginConfig.getPackage()#.Application" method="onSessionStart" />
		<cfset restoreInternalState(request,state)>
	</cffunction>

	<cffunction name="getFrameworkVariables" output="false" access="private">
		<cfset var framework = StructNew() />

		<cfinclude template="../frameworkConfig.cfm" />

		<cfreturn framework />		
	</cffunction>
</cfcomponent>