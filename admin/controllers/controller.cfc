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
<!--- this central controller must be extended by all section controllers --->
<cfcomponent displayname="controller" output="false" extends="mura.cfobject">

	<!--- do not remove the init ... it is crucial --->
	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="fw" type="struct" required="false" default="#StructNew()#">
		<cfset variables.fw = fw />
		
		<cfreturn this />
	</cffunction>

	<!--- runs before every controller request --->
	<cffunction name="before" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<!--- headloader for head includes --->
		<cfset rc.headLoader = ArrayNew(1) />
		<!--- pluginConfig --->
		<cfset rc.pluginConfig = fw.getPluginConfig() />

		<cfif not structKeyExists(session,"siteid")>
			<cflocation url="/#rc.$.globalConfig().getContext()#/admin/index.cfm?fuseaction=cLogin.logout" addtoken="false">
		<cfelse>
			<cfset rc.siteID = session.siteid />
		</cfif>
		
		<cfif isUserInRole("s2") or isUserInRole("Admin;#application.settingsManager.getSite(rc.siteID).getPublicUserPoolID()#;0")>
			<cfset rc.isAdmin = true>
		<cfelse>
			<cfset rc.isAdmin = false>
		</cfif>

		<cfset rc.mmRBF			= fw.getBeanFactory().getBean("mmResourceBundle")>
		<cfset rc.errors		= ArrayNew(1) />
		<cfset rc.adminID		= rc.$.currentUser('userID')>
		<cfset rc.isAdmin		= rc.$.currentUser().isInGroup('admin') or rc.$.currentUser().isSuperUser()>
		<cfset rc.directory		= rc.pluginConfig.getDirectory()>
	</cffunction>

	<!--- runs after every controller request --->
	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn variables.fw.getBeanFactory()>
	</cffunction>
</cfcomponent>