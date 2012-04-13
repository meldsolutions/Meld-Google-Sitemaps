<cfcomponent output="false">

	<cfset variables.config=""/>
	<cfset variables.instance.extensionManager = application.classExtensionManager />
	
	<cffunction name="init" returntype="any" access="public" output="false">
		<cfargument name="config"  type="any" default="">
		<cfset variables.config = arguments.config>
	</cffunction>
	
	<cffunction name="install" returntype="void" access="public" output="false">
	</cffunction>

	<cffunction name="keepSingleQuotes" returntype="string" output="false">
		<cfargument name="str">
		<cfreturn preserveSingleQuotes(arguments.str)>
	</cffunction>
	
	<cffunction name="update" returntype="void" access="public" output="false">
		<cfset application.appInitialized=false />
	</cffunction>
	
	<cffunction name="delete" returntype="void" access="public" output="false">

	</cffunction>
</cfcomponent>