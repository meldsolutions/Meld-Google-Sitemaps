<!---
This file is part of the The Mura Google News Sitemaps Plugin.

The Mura Google News Sitemaps Plugin is licensed under the GPL 2.0 license
Copyright (C) 2016 Nolan Erck (http://www.southofshasta.com/) and Meld Solutions Inc. http://www.meldsolutions.com/

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
<cfcomponent extends="controller">

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset doGetSettings( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="edit" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var success = false />

		<cfif isDefined("rc.btaction")>
			<!--- cancel? --->
			<cfif arguments.rc.btaction eq rc.mmRBF.key('cancel')>
				<cflocation url="?action=admin:settings" addtoken="false">
			<!--- update? --->
			<cfelseif rc.btaction eq rc.mmRBF.key('update')>
				<cfset success = doUpdateSettings( argumentCollection=arguments )>
				<cfif success eq true>
					<cflocation url="?action=admin:settings" addtoken="false">
				</cfif>
			</cfif>
		</cfif>

		<cfset doGetSettings( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="doUpdateSettings" access="private" returntype="boolean" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var sitemapsObject		= createObject("component","mura.extend.extendObject").init(Type="Custom",SubType="MeldGoogleNewsSitemaps",SiteID=rc.siteID)>
		<cfset var processURL			= "http://#rc.$.siteConfig('domain')##rc.$.globalConfig('context')#/plugins/#rc.pluginConfig.getDirectory()#/?action=process:&site=#rc.siteID#" />
		<cfset var timeOfDay			= createDateTime(2011,1,1,#rc.timeofday_hour#,#rc.timeofday_minute#,0) />

		<cfset sitemapsObject.setType("Custom")>
		<cfset sitemapsObject.setSubType("MeldGoogleNewsSitemaps")>
		<cfset sitemapsObject.setSiteID(rc.siteID)>	
		<cfset sitemapsObject.setID( rc.siteID ) />
		<cfset sitemapsObject.getAllValues() />

		<cfparam name="rc.enabled" default="0">		

		<cfset sitemapsObject.setValue('Location',rc.location ) />
		<cfset sitemapsObject.setValue('Enabled',rc.enabled ) />
		<cfset sitemapsObject.setValue('Frequency',rc.frequency ) />
		<cfset sitemapsObject.setValue('Email',rc.email ) />
		<cfset sitemapsObject.setValue('TimeOfDay',timeOfDay ) />
		<cfset sitemapsObject.save() />

		<cfif rc.enabled>
			<cfschedule
				action="update"
				task="Mura Google News Sitemaps #rc.$.siteConfig('domain')# - #rc.siteID#"
				interval="#rc.frequency#"
				url="#processURL#"
				operation="HTTPRequest"
				startdate="#dateFormat(now(),"mm/dd/yy")#"
				starttime="#timeFormat( timeOfDay,"hh:mm TT" )#"
				resolveurl="true"
				requesttimeout="1000"
				>		
		<cfelse>
			<cfschedule
				action="delete"
				task="Mura Google News Sitemaps #rc.$.siteConfig('domain')# - #rc.siteID#">
		</cfif>

		<cfreturn true />
	</cffunction>

	<cffunction name="doGetSettings" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var sitemapsObject	= createObject("component","mura.extend.extendObject").init(Type="Custom",SubType="MeldGoogleNewsSitemaps",SiteID=rc.siteID)>
		<cfset var iiX = "" />

		<cfset sitemapsObject.setType("Custom")>
		<cfset sitemapsObject.setSubType("MeldGoogleNewsSitemaps")>
		<cfset sitemapsObject.setSiteID(rc.siteID)>

		<cfset sitemapsObject.setID( rc.siteID ) />
		<cfset sitemapsObject.setModuleID( rc.pluginConfig.getModuleID() ) />

		<cfset sitemapsObject.getAllValues() />

		<cfif not len( sitemapsObject.getValue('Enabled') ) or not isDate(sitemapsObject.getValue('TimeOfDay'))>
			<cfset sitemapsObject.setValue('Location','site' ) />
			<cfset sitemapsObject.setValue('Frequency','Weekly') />
			<cfset sitemapsObject.setValue('Enabled',sitemapsObject.getValue('Enabled') eq 1) />
			<cfset sitemapsObject.setValue('Email',rc.$.siteConfig('contactEmail')) />
			<cfset sitemapsObject.setValue('DateLastCreate',createODBCDateTime(dateAdd('yyyy',-10,now()))) />
			<cfset sitemapsObject.setValue('TimeOfDay',createDateTime(2011,1,1,2,0,0) ) />
			<cfset sitemapsObject.save() />
		</cfif>

		<cfset rc.sitemapsObject = sitemapsObject />
		<cfset rc.sData			= sitemapsObject.getAllValues() />
		
		<cfloop collection="#rc.sData#" item="iiX">
			<cfparam name="form[iiX]" default="#rc.sData[iiX]#">		
		</cfloop>

	</cffunction>
</cfcomponent>
