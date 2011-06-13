<cfsilent>
	<cfif not isDefined("pluginConfig")>
		<cfset pluginID=listLast(listGetat(getDirectoryFromPath(getCurrentTemplatePath()),listLen(getDirectoryFromPath(getCurrentTemplatePath()),application.configBean.getFileDelim())-1,application.configBean.getFileDelim()),"_")>
		<cfset variables.pluginConfig=application.pluginManager.getConfig(pluginID)>
	</cfif>

	<cfif not isDefined("$")>
		<cfset $=application.serviceFactory.getBean("MuraScope")>
		<cfset sInitArgs = StructNew()>
		<cfif  structKeyExists(session,"siteID")>
			<cfset sInitArgs.siteID = session.siteID>
		<cfelse>
			<cfset sInitArgs.siteID = "default">
		</cfif>
		<cfset $.init(sInitArgs)>
	</cfif>
</cfsilent>