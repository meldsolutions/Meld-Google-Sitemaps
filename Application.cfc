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
<cfcomponent extends="framework" output="false">
	<cfinclude template="../../config/applicationSettings.cfm">
	<cfinclude template="../../config/mappings.cfm">
	<cfinclude template="../mappings.cfm">

	<cfset variables.framework=getFrameworkVariables()>

	<cffunction name="isAdminRequest" output="false">
		<cfif left(request.context.action,5) eq 'admin'>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>
	
	<cffunction name="secureRequest" output="false">
		<cfargument name="$">
		<cfif isAdminRequest() and not ($.currentUser().isSuperUser() or $.currentUser().isInGroup('admin') eq true)>
			<cfif not isDefined("variables.pluginConfig") or variables.pluginConfig.getPackage() neq variables.framework.applicationKey>
				<cfset variables.pluginConfig=application.pluginManager.getConfig(variables.framework.applicationKey)>
			</cfif>
			<cfif not isDefined("session") or not structKeyExists(session,"siteID") or not application.permUtility.getModulePerm(variables.pluginConfig.getValue('moduleID'),session.siteid)>
				<cflocation url="#$.globalConfig().getContext()#/admin/" addtoken="false">
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction name="setupRequest" output="false">
		<cfset var muraScope = "" />

		<cfif not structKeyExists(request.context,"$")>
			<cfset request.context.$ = getMuraScope() />
		</cfif>

		<cfset secureRequest(request.context.$)>
	</cffunction>

	<cffunction name="setupApplication" output="false">
		<cfset var beanFactory				= "" />
		<cfset var coldspringXml			= "" />
		<cfset var coldspringXmlPath		= "" />
		<cfset var defaultProperties		= StructNew()>

		<!--- ensure that we have PluginConfig in the variables scope and $ --->
		<cfif not isDefined("variables.pluginConfig") or variables.pluginConfig.getPackage() neq variables.framework.applicationKey>
			<!--- initialize Mura if required --->
			<cfif not structKeyExists(application,"pluginManager")>
				<cfinclude template="/muraWRM/config/appcfc/onApplicationStart_include.cfm" />
			</cfif>
				
			<cfset variables.pluginConfig=application.pluginManager.getConfig(variables.framework.applicationKey)>
		</cfif>

		<cfif not isDefined("$")>
			<cfset $ = getMuraScope() />
		</cfif>

		<cfset coldspringXmlPath	= "#expandPath('/plugins')#/#variables.pluginConfig.getDirectory()#/coldspring/coldspring.xml.cfm" />

		<!--- read in coldspringXml --->
		<cffile action="read" file="#coldspringXmlPath#" variable="coldspringXml" />

		<!--- parse the coldspringXml and replace all [plugin] with the plugin mapping path, and |plugin| with the physical path --->
		<cfset coldspringXml = replaceNoCase( coldspringXml, "[plugin]", "plugins.#variables.pluginConfig.getDirectory()#.", "ALL") />
		<cfset coldspringXml = replaceNoCase( coldspringXml, "|plugin|", "plugins/#variables.pluginConfig.getDirectory()#/", "ALL") />

		<!--- set the default values --->
		<cfset defaultProperties.dsn				= $.globalConfig().getValue( "datasource" )>
		<cfset defaultProperties.dsnusername		= $.globalConfig().getValue( "dbusername" )>
		<cfset defaultProperties.dsnpassword		= $.globalConfig().getValue( "dbpassword" )>
		<cfset defaultProperties.dsntype			= $.globalConfig().getValue( "dbtype" )>

		<cfset defaultProperties.pluginFileRoot		= expandpath("/#variables.pluginConfig.getPackage()#")>
		<cfset defaultProperties.pluginDirectory	= variables.pluginConfig.getDirectory()>
		<cfset defaultProperties.fileDirectory		= $.globalConfig().getFileDir()>
		<cfset defaultProperties.muraWebRoot		= application.configBean.getContext()>
		<cfset defaultProperties.pluginConfig		= variables.pluginConfig>

		<cfset defaultProperties.applicationKey		= lcase(variables.pluginConfig.getPackage())>
		
		<cfif isDefined("session") and StructKeyExists( session,'locale')>
			<cfset defaultProperties.rblocale			= session.locale />
		<cfelse>
			<cfset defaultProperties.rblocale			= "en" />
		</cfif>
		
		<cfset variables.pluginConfig.setValue("DefaultProperties",defaultProperties) />

		<cfset beanFactory=createObject("component","#variables.pluginConfig.getPackage()#.com.org.corfield.ioc").init( "/plugins/#variables.pluginConfig.getDirectory()#/com/meldsolutions",{
					recurse=true,
					strict=true,
					transientPattern = "(Bean)$"
					} ) />
					
		<cfset beanFactory.getBean("MeldGoogleConfig").setValues(defaultProperties) />

		<cfset variables.pluginConfig.getApplication().setValue( "beanFactory", beanFactory ) />

		<!--- set the FW/1 bean factory as our new ColdSpring bean factory --->
		<cfset setBeanFactory( beanFactory ) />

		<cfif variables.framework.reloadApplicationOnEveryRequest or StructKeyExists(url,variables.framework.reload)>
			<cfset application[ variables.framework.applicationKey & "BeanFactory" ] = beanFactory>
		</cfif>
	</cffunction>

	<cffunction name="onRequestEnd" output="false">
		<cfset var iiX = 0>
		<cfif not structkeyexists( request.context,"headLoader" )>
			<cfreturn>
		</cfif>

		<cfloop from="1" to="#arrayLen(request.context.headLoader)#" index="iiX">
			<cfhtmlhead text="#request.context.headLoader[iiX]#">
		</cfloop>
	</cffunction>

	<cffunction name="getFrameworkVariables" output="false">
		<cfset var framework = StructNew() />
	
		<cfinclude template="frameworkConfig.cfm" />
	
		<cfreturn framework />		
	</cffunction>

	<cffunction name="onMissingView" output="false">
		<cfparam name="url.action" default="" />

		<!--- deal with issue of Mura taking our framework settings --->
		<cfif left(url.action,1) eq "c">
			<cflocation url="./?ma=#url.action#" addtoken="false" />
		<cfelse>
			<cfset super.onMissingView(argumentCollection=arguments) />
		</cfif>
	</cffunction>

	<cffunction name="preseveInternalState" output="false">
		<cfargument name="state">
		<cfset var preserveKeyList="context,base,cfcbase,subsystem,subsystembase,section,item,services,action,controllerExecutionStarted">
		<cfset var preserveKeys=structNew()>
		<cfset var k="">
		
		<cfloop list="#preserveKeyList#" index="k">
			<cfif isDefined("arguments.state.#k#")>
				<cfset preserveKeys[k]=arguments.state[k]>
				<cfset structDelete(arguments.state,k)>
			</cfif>
		</cfloop>
		
		<cfif StructKeyExists(request,'controllers')>
			<cfset structDelete(request,'controllers') />
		</cfif>
		
		<cfset structDelete( arguments.state, "serviceExecutionComplete" )>
		
		<cfreturn preserveKeys>
	</cffunction>
		
	<cffunction name="restoreInternalState" output="false">
		<cfargument name="state">
		<cfargument name="restore">
		<cfset var preserveKeyList="context,base,cfcbase,subsystem,subsystembase,section,item,services,action,controllerExecutionStarted">
		
		<cfloop list="#preserveKeyList#" index="k">
				<cfset structDelete(arguments.state,k)>
		</cfloop>
		
		<cfset structAppend(state,restore,true)>
		<cfset structDelete( state, "serviceExecutionComplete" )>
	</cffunction>
	
	<cffunction name="getMuraScope" output="false">
		<cfset var $ = application.serviceFactory.getBean("MuraScope")>
		<cfset var sInitArgs = StructNew()>

		<cfif isDefined("session") and structKeyExists(session,"siteID")>
			<cfset sInitArgs.siteID = session.siteID>
		<cfelse>
			<cfset sInitArgs.siteID = "default">
		</cfif>
		<cfset $.init(sInitArgs)>
		
		<cfreturn $ />
	</cffunction>
</cfcomponent>