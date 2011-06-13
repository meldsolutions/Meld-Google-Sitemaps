<!---
This file is part of the The Meld Manager.

Meld Manager is licensed under the GPL 2.0 license
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
<cfcomponent displayname="mmResourceBundle" hint="Creates and manages resource bundles" output="false">
	<cfset variables.instance = StructNew()>

	<cffunction name="init" access="public" output="false" returntype="mmResourceBundle">
		<cfargument name="applicationKey" required="false" default="">
		<cfargument name="pluginFileRoot" required="false" default="">
		<cfargument name="rblocale" required="false" default="en">
		
		<cfset setApplicationKey( arguments.applicationKey ) />
		<cfset setpluginFileRoot( arguments.pluginFileRoot ) />
		<cfset setBaseRBLocale( arguments.rblocale ) />
		
		<cfset variables.rbValid		= false>
		<cfset variables.sRB			= StructNew() />
				
		<cfset doValidateBaseResourceBundle() />

		<cfif not getRBValid()>
			<cfreturn this />
		</cfif>

		<cfset doConnectBaseResourceBundle() />

		<cfreturn this/>
	</cffunction>

	<cffunction name="key" access="public" returntype="string" output="false">
		<cfargument name="value" type="string" required="true" />
		<cfargument name="context" type="string" required="false" default="label" />
		<cfargument name="locale" type="string" required="false" default="#getBaseRBLocale()#" />

		<cfset var fullKey		= getApplicationKey() />
		<cfset var keyValue		= "" />
		
		<cfif not getRBValid()>
			<cfreturn arguments.value & "_z" />
		</cfif>

		<cfif arguments.context eq "mura">
			<cfset fullKey = arguments.value />
		<cfelse>
			<cfset fullKey = fullKey & "." & arguments.context />
			<cfset fullKey = fullKey & "." & arguments.value />
		</cfif>
		
		<cfset keyValue = getRBFactory().getKeyValue(arguments.locale,fullKey) /> 
									
		<cfif keyValue eq "#fullKey#_missing">
			<cfreturn addKey( fullKey,arguments.value,arguments.locale ) />
		</cfif>

		<cfreturn keyValue />
	</cffunction>
		
	<cffunction name="addKey" access="private" returntype="string" output="false">
		<cfargument name="fullKey" type="string" required="true" />
		<cfargument name="value" type="string" required="true" />
		<cfargument name="locale" type="string" required="false" default="#getBaseRBLocale()#" />

		<cfset var contextFile = "" />

		<cftry>
			<cfthrow message="get context">
			<cfcatch>
				<cfset contextFile = cfcatch.TagContext[3].template>
			</cfcatch>
		</cftry> 

		<cffile action="append" file="#getRBFile()#" output="#arguments.fullKey#=#arguments.value#_?" addnewline="true" >
	
		<cfset resetRBFactory( argumentCollection=arguments ) />

		<cfset keyValue = getRBFactory().getKeyValue(arguments.locale,value) /> 

		<cfreturn "#arguments.value#_nf" />
	</cffunction>
	
	<cffunction name="doConnectBaseResourceBundle" access="private" returntype="void" output="false">
		<cfset getRBFactory() />
	</cffunction>
	
	<cffunction name="getRBFactory" access="public" returntype="any" output="false">
		<cfargument name="locale" type="string" required="false" default="#getBaseRBLocale()#" />
		
		<cfset var rbFactory 	= "" />

		<cfif not StructKeyExists( variables.sRB,arguments.locale ) >
			<cfset resetRBFactory( argumentCollection=arguments ) />
		</cfif>

		<cfreturn variables.sRB[ arguments.locale ] />
	</cffunction>
	
	<cffunction name="resetRBFactory" access="public" returntype="void" output="false">
		<cfargument name="locale" type="string" required="false" default="#getBaseRBLocale()#" />
		
		<cfset var rbFactory 	= "" />
		<cfset var parent		= "" />

		<cfif structKeyExists(variables.instance,"ParentFactory")>
			<cfset parent = getParentFactory() />
		<cfelse>
			<cfset parent = application.rbFactory />
		</cfif>

		<cfset rbFactory = createObject("component","mura.resourceBundle.resourceBundleFactory").init(application.rbFactory,getRBPath(),getBaseRBLocale() ) />
		<cfset variables.sRB[ arguments.locale ] = rbFactory />
	</cffunction>

	<cffunction name="doValidateBaseResourceBundle" access="private" returntype="void" output="false">
		<cfset var path		= getpluginFileRoot() & "/resourceBundles" />
		<cfset var file		= path & "/" & getBaseRBLocale() & ".properties" />

		<cfif not len( getpluginFileRoot() ) or not directoryExists( getpluginFileRoot() )>
			<cfset variables.rbValid = false>
			<cfreturn>
		</cfif>

		<cfif not directoryExists( path  )>
			<cfdirectory action="create" directory="#path#">
		</cfif>

		<cfif not fileExists( file )>
			<cffile action="write" file="#file#" output="## Created by mmResourceBundle #lsDateFormat(now(),"short")#">
		</cfif>

		<cfset variables.instance.rbPath	= path />
		<cfset variables.instance.rbFile	= file />

		<cfset variables.rbValid = true>
	</cffunction>

	<cffunction name="getRBFile" access="public" returntype="string" output="false">
		<cfreturn variables.instance.rbFile />
	</cffunction>
	<cffunction name="getRBPath" access="public" returntype="string" output="false">
		<cfreturn variables.instance.rbPath & "/" />
	</cffunction>
	<cffunction name="getRBValid" access="public" returntype="string" output="false">
		<cfreturn variables.rbValid />
	</cffunction>
	
	<!--- 
	mmResourceBundle will instantiate and manage resource bundles.  It may also be useful to have it actually add
	"null" values to the current resourceBundle where they don't exist.  I.E. if a resource "meld.ecomm.label.product"
	was "_missing" then mmResourceBundle would add it to the resourceBundle file as
	"meld.ecomm.label.product=product_MISSING" and reload the file.  This would greatly speed resourceBundle management.
	--->
	<cffunction name="setpluginFileRoot" access="public" returntype="void" output="false">
		<cfargument name="pluginFileRoot" type="string" required="true" />
		<cfset variables.instance.pluginFileRoot = arguments.pluginFileRoot />
	</cffunction>
	<cffunction name="getpluginFileRoot" access="public" returntype="string" output="false">
		<cfreturn variables.instance.pluginFileRoot />
	</cffunction>

	<cffunction name="setApplicationKey" access="public" returntype="void" output="false">
		<cfargument name="ApplicationKey" type="string" required="true" />
		<cfset variables.instance.ApplicationKey = arguments.ApplicationKey />
	</cffunction>
	<cffunction name="getApplicationKey" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ApplicationKey />
	</cffunction>

	<cffunction name="setBaseRBLocale" access="public" returntype="void" output="false">
		<cfargument name="BaseRBLocale" type="string" required="true" />
		<cfset variables.instance.BaseRBLocale = arguments.BaseRBLocale />
	</cffunction>
	<cffunction name="getBaseRBLocale" access="public" returntype="string" output="false">
		<cfif structKeyExists(session,"RB")>
			<cfif session.rb eq "en_US">
				<cfreturn "en">
			<cfelse>
				<cfreturn session.RB />
			</cfif>
		<cfelse>
			<cfreturn variables.instance.BaseRBLocale />
		</cfif>
	</cffunction>

	<cffunction name="setParentFactory" access="public" returntype="void" output="false">
		<cfargument name="ParentFactory" type="any" required="true" />
		<cfset variables.instance.ParentFactory = arguments.ParentFactory />
		<cfset resetRBFactory() />
	</cffunction>
	<cffunction name="getParentFactory" access="public" returntype="any" output="false">
		<cfreturn variables.instance.ParentFactory />
	</cffunction>
</cfcomponent>