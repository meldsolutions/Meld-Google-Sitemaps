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
<cfcomponent name="MuraEventHandler" output="false" extends="mura.plugin.pluginGenericEventHandler">
	<cfset variables.subsystem = "" />
	<cfset variables.framework=getFrameworkConfig() />

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
		<cfset var k="" />
		
		<cfloop list="#preserveKeyList#" index="k">
				<cfset structDelete(arguments.state,k)>
		</cfloop>
		
		<cfset structAppend(state,restore,true)>
		<cfset structDelete( state, "serviceExecutionComplete" )>
	</cffunction>

	<cffunction name="getFrameworkConfig" output="false">
		<cfset var framework = StructNew() />

		<cfinclude template="../../../frameworkConfig.cfm" />
		<cfreturn framework />		
	</cffunction>

</cfcomponent>
