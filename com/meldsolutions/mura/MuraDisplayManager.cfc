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
<cfcomponent name="displayManager" output="false" extends="mura.plugin.pluginGenericEventHandler">
	<cfset variables.subsystem = "" />
	<cfset variables.framework=getFrameworkConfig() />

	<cffunction name="renderApp" output="false" returntype="String" >
		<cfargument name="$">

		<cfif not StructKeyExists(variables,"subsystem") or not len(variables.subsystem)>
			<cfset variables.subsystem = getSubSystem() />
		</cfif>

		<cfreturn doEvent(arguments.$)>
	</cffunction>
	
	<cffunction name="doEvent">
		<cfargument name="$">
		<cfargument name="action" type="string" required="false" default="" hint="Optional: If not passed it looks into the event for a defined action, else it uses the default"/>
		
		<cfset var result = "" />
		<cfset var savedEvent = "" />
		<cfset var savedAction = "" />
		<cfset var fw1 = createObject("component","#pluginConfig.getPackage()#.Application") />
		<cfset var local=structNew()>
		<cfset var state=structNew()>
		<cfset var params = structNew() />

		<cfif not isStruct(params)>
			<cfset params = StructNew() />
		</cfif>
			
		<cfset url.$ = $ />

		<cfset state=fw1.preseveInternalState(request)>
		<cfset structDelete(request,"context") />

		<cfset params = deserializeJSON( $.event().getValue("params") ) />

		<cfif StructKeyExists(params,"system")>
			<cfset arguments.action = params.system />
		<cfelseif StructKeyExists(params,"item")>
			<cfset arguments.action = variables.subsystem & ":main.#params.item#" />
		<cfelseif StructKeyExists(params,"action")>
			<cfset arguments.action = variables.subsystem & ":#params.action#" />
		<cfelseif not len( arguments.action )>
			<cfif len(arguments.$.event(variables.framework.action))>
				<cfset arguments.action = variables.subsystem & ":" & arguments.$.event(variables.framework.action)>
			<cfelse>
				<cfset arguments.action = variables.subsystem & ":" & variables.framework.home>
			</cfif>
		</cfif>

		<!--- put the action passed into the url scope, saving any pre-existing value --->
		<cfif StructKeyExists(request, variables.framework.action)>
			<cfset savedEvent = request[variables.framework.action] />
		</cfif>
		<cfif StructKeyExists(url,variables.framework.action)>
			<cfset savedAction = url[variables.framework.action] />
		</cfif>
		
		<cfset url[variables.framework.action] = arguments.action />
	
		<!--- call the frameworks onRequestStart --->
		<cfset fw1.onRequestStart(CGI.SCRIPT_NAME) />

		<cfset request.context.params = params />
		
		<!--- call the frameworks onRequest --->
		<!--- we save the results via cfsavecontent so we can display it in mura --->
		<cfsavecontent variable="result">
			<cfset fw1.onRequest(CGI.SCRIPT_NAME) />
		</cfsavecontent>
				
		<!--- restore the url scope --->
		<cfif structKeyExists(url,variables.framework.action)>
			<cfset structDelete(url,variables.framework.action) />
		</cfif>
		<!--- if there was a passed in action via the url then restore it --->
		<cfif Len(savedAction)>
			<cfset url[variables.framework.action] = savedAction />
		</cfif>
		<!--- if there was a passed in request event then restore it --->
		<cfif Len(savedEvent)>
			<cfset request[variables.framework.action] = savedEvent />
		</cfif>

		<cfset fw1.restoreInternalState(request,state)>

		<!--- return the result --->
		<cfreturn result>
	</cffunction>

	<cffunction name="getFrameworkConfig" output="false">
		<cfset var framework = StructNew() />

		<cfinclude template="../../../frameworkConfig.cfm" />
		<cfreturn framework />		
	</cffunction>

	<cffunction name="getSubSystem" output="false" returntype="string">
		<cfargument name="$">

		<cfset var subsystemName	= getMetaData(this).name />
		<cfset var subsystem		= rereplaceNoCase(subsystemName,"^.*\.(.*)\.display.displayManager","\1") />
		<cfreturn subsystem />
	</cffunction>
</cfcomponent>