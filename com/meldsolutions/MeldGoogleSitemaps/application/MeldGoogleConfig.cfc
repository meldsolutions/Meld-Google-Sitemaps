<cfcomponent displayname="MeldGoogleSitemapsManager" output="false" hint="Main Manager">

	<cfset variables.instance = StructNew()>

	<cffunction name="init" returntype="MeldGoogleConfig" access="public" output="false">

			<cfreturn this>
	</cffunction>

	<cffunction name="setDSN" returntype="xml" access="public" output="false">
		<cfargument name="dsn" type="string" required="true">
		<cfargument name="dsnusername" type="string" required="true">
		<cfargument name="dsnpassword" type="string" required="true">
		<cfargument name="dsntype" type="string" required="true">

		<cfset variables.instance.dsn = arguments.dsn>
		<cfset variables.instance.dsnusername = arguments.dsnusername>
		<cfset variables.instance.dsnpassword = arguments.dsnpassword>
		<cfset variables.instance.dsntype = arguments.dsntype>
	</cffunction>

	<cffunction name="onMissingMethod" access="public" output="false" returntype="any">
		<cfargument name="MissingMethodName" type="string" required="true" />
		<cfargument name="MissingMethodArguments" type="struct" required="true" />

		<cfset var methodName = "" />

		<cfif len(arguments.MissingMethodName)>
			<cfset prefix = left(arguments.MissingMethodName,3) />

			<cfif compareNoCase("get",prefix) eq 0>
				<cfset methodName = right(arguments.MissingMethodName,len(arguments.MissingMethodName)-3) >
				<cfif valueExists(methodName)>
					<cfreturn getValue(methodName) />
				<cfelse>
					<!--- TODO: DEAL WITH PROP MISSING --->
					<cfreturn getValue(methodName) />
				</cfif>
			<cfelseif prefix eq "set" and not structIsEmpty(MissingMethodArguments)>
				<cfset prop = right(arguments.MissingMethodName,len(arguments.MissingMethodName)-3) />
				<cfset setValue(prop,MissingMethodArguments[1]) />
			<cfelseif valueExists(MissingMethodName)>
				<cfreturn getValue(MissingMethodName) />
			<cfelse>
				<cfthrow message="#MissingMethodName# does not exist." />
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction name="valueExists" access="public" output="false" returntype="boolean">
		<cfargument name="key" type="string" required="true">

		<cfreturn structkeyexists( variables.instance,arguments.key) />
	</cffunction>

	<cffunction name="setValue" access="public" output="false" returntype="any">
		<cfargument name="key" type="string" required="true">
		<cfargument name="value" type="any" required="true">
		
		<cfset variables.instance[lcase(arguments.key)] = arguments.value />
	</cffunction>


	<cffunction name="removeValue" access="public" output="false" returntype="any">
		<cfargument name="key" type="string" required="true">
		<cfargument name="value" type="any" required="true">
		
		<cfset structDelete(variables.instance,arguments.key) />
	</cffunction>

	<cffunction name="getValue" access="public" output="false" returntype="any">
		<cfargument name="key" type="string" required="true">
		
		<cfif structkeyexists( variables.instance,arguments.key)>
			<cfreturn variables.instance[arguments.key] />
		</cfif>
				
		<cfreturn "" />
	</cffunction>

	<cffunction name="setValues" access="public" output="false" returntype="any">
		<cfargument name="valueStruct" type="struct" required="true">
		
		<cfset structAppend(variables.instance,structCopy(arguments.valueStruct),true) />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getAllValues" access="public" output="false" returntype="struct">
		<cfreturn variables.instance />
	</cffunction>

</cfcomponent>