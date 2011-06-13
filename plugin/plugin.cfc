<cfcomponent output="false">

	<cfset variables.config=""/>
	<cfset variables.instance.extensionManager = application.classExtensionManager />
	
	<cffunction name="init" returntype="any" access="public" output="false">
		<cfargument name="config"  type="any" default="">
		<cfset variables.config = arguments.config>
	</cffunction>
	
	<cffunction name="install" returntype="void" access="public" output="false">
		<cfset setExtensions() />
	</cffunction>

	<cffunction name="keepSingleQuotes" returntype="string" output="false">
		<cfargument name="str">
		<cfreturn preserveSingleQuotes(arguments.str)>
	</cffunction>
	
	<cffunction name="update" returntype="void" access="public" output="false">
		<cfset application.appInitialized=false />
		<cfset setExtensions() />
	</cffunction>
	
	<cffunction name="delete" returntype="void" access="public" output="false">

	</cffunction>

	<cffunction name="setExtensions" returntype="void" access="private" output="false">

		<cfset var extension	= "" />
		<cfset var extendSet	= "" />
		<cfset var extendSetID	= "" />
		<cfset var sArgs		= StructNew() />
		<cfset var qSites		= variables.config.getAssignedSites() />
		<cfset var sValues		= StructNew() />
		<cfset var qSets		= "" />

		<cfset extension		= addExtension( 'default','Page','Default' ) />


		<cfif not isSimpleValue( extension )>
			<cfset qSets			= extension.GetExtendSetByName('Google Sitemaps').GetAttributesQuery() />
						
			<cfif not qSets.recordCount>
				<cfset extendSet		= addExtendSet( 'default','Google Sitemaps',extension.getSubTypeID(),'Default'  ) />
				<cfset extendSetID		= extendSet.getExtendSetID() />
	
				<cfset addAttribute( 'default',extendSetID,1,'exclude','Exclude From Sitemap',true,'inherit','Exclude this page from the sitemap','','','','SelectBox','inherit^no^yes','Inherit^No^Yes' ) />
				<cfset addAttribute( 'default',extendSetID,2,'changefrequency','Change Frequency',true,'monthly','The change frequency for the page','','','','SelectBox','daily^weekly^monthly^yearly','Daily^Weekly^Monthly^Yearly' ) />
				<cfset addAttribute( 'default',extendSetID,3,'priority','Priority',true,'0.5','The relative importance of the page to the site','','','','SelectBox','0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0','0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0' ) />
			</cfif>
		</cfif>

		<cfset extension		= addExtension( 'default','Portal','Default' ) />

		<cfif not isSimpleValue( extension )>
			<cfset qSets			= extension.GetExtendSetByName('Google Sitemaps').GetAttributesQuery() />
						
			<cfif not qSets.recordCount>
				<cfset extendSet		= addExtendSet( 'default','Google Sitemaps',extension.getSubTypeID(),'Default'  ) />
				<cfset extendSetID		= extendSet.getExtendSetID() />
	
				<cfset addAttribute( 'default',extendSetID,1,'exclude','Exclude From Sitemap',true,'inherit','Exclude this page from the sitemap','','','','SelectBox','inherit^no^yes','Inherit^No^Yes' ) />
				<cfset addAttribute( 'default',extendSetID,2,'changefrequency','Change Frequency',true,'monthly','The change frequency for the page','','','','SelectBox','daily^weekly^monthly^yearly','Daily^Weekly^Monthly^Yearly' ) />
				<cfset addAttribute( 'default',extendSetID,3,'priority','Priority',true,'0.5','The relative importance of the page to the site','','','','SelectBox','0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0','0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0' ) />
			</cfif>
		</cfif>

		<cfset extension		= addExtension( 'default','Custom','MeldGoogleSitemaps' ) />

		<cfif not isSimpleValue( extension )>
			<cfset qSets			= extension.GetExtendSetByName('MeldGoogleSitemaps').GetAttributesQuery() />
						
			<cfif not qSets.recordCount>
				<cfset extendSet		= addExtendSet( 'default','MeldGoogleSitemaps',extension.getSubTypeID()  ) />
				<cfset extendSetID		= extendSet.getExtendSetID() />
	
				<cfset addAttribute( 'default',extendSetID,1,'Location','Sitemap Location',true,'site' ) />
				<cfset addAttribute( 'default',extendSetID,2,'Frequency','Frequency',true,'weekly' ) />
				<cfset addAttribute( 'default',extendSetID,3,'Enabled','Enabled',true,'0','','Numeric' ) />
				<cfset addAttribute( 'default',extendSetID,4,'Email','Email',false,'' ) />
				<cfset addAttribute( 'default',extendSetID,5,'DateLastCreate','DateLastCreate',false,'','','Date' ) />
				<cfset addAttribute( 'default',extendSetID,6,'TimeOfDay','TimeOfDay',false,'','','Date' ) />
			</cfif>
		</cfif>
	
		<cfloop query="qSites">
			<cfif siteID neq "default">
				<cfset variables.instance.extensionManager.syncDefinitions( 'default',siteID,'Page','default' ) />
				<cfset variables.instance.extensionManager.syncDefinitions( 'default',siteID,'Portal','default' ) />
				<cfset variables.instance.extensionManager.syncDefinitions( 'default',siteID,'Custom','MeldGoogleSitemaps' ) />
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="addAttribute" returntype="any" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="extendSetID" type="string" required="true">
		<cfargument name="orderNo" type="numeric" required="true">
		<cfargument name="name" type="string" required="true">
		<cfargument name="label" type="string" required="true">
		<cfargument name="required" type="string" required="true">
		<cfargument name="defaultValue" type="string" required="false" default="">
		<cfargument name="hint" type="string" required="false" default="">
		<cfargument name="validation" type="string" required="false" default="">
		<cfargument name="regex" type="string" required="false" default="">
		<cfargument name="message" type="string" required="false" default="">
		<cfargument name="type" type="string" required="false" default="TextBox">
		<cfargument name="optionList" type="string" required="false" default="">
		<cfargument name="optionLabelList" type="string" required="false" default="">

		<cfset var sAttribute = variables.instance.extensionManager.getSubTypeBean().getExtendSetBean().getattributeBean()>

		<cfset sAttribute.setSiteID(arguments.siteID)>
		<cfset sAttribute.setExtendSetID(arguments.extendSetID)>
		<cfset sAttribute.setName(arguments.name)>
		<cfset sAttribute.setLabel(arguments.label)>
		<cfset sAttribute.setRequired(arguments.required)>
		<cfset sAttribute.setValidation(arguments.validation)>
		<cfset sAttribute.setHint(arguments.hint)>
		<cfset sAttribute.setRegex(arguments.regex)>
		<cfset sAttribute.setMessage(arguments.message)>
		<cfset sAttribute.setType(arguments.type)>
		<cfset sAttribute.setDefaultValue(arguments.defaultValue)>
		<cfset sAttribute.setOptionList(arguments.optionList)>
		<cfset sAttribute.setOptionLabelList(arguments.optionLabelList)>
		<cfset sAttribute.setOrderNo(arguments.orderno)>

		<cfset sAttribute.save()>
		
		<cfreturn sAttribute />
	</cffunction>

	<cffunction name="addExtension" returntype="any" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="Type" type="string" required="true">
		<cfargument name="subType" type="string" required="false" default="Default">
		<cfargument name="BaseKeyField" type="string" required="false" default="contentHistID">
		<cfargument name="BaseTable" type="string" required="false" default="tcontent">
		<cfargument name="DataTable" type="string" required="false" default="tclassextenddata">

		<cfset var sExtension	= variables.instance.extensionManager.getSubTypeByName( arguments.type,arguments.subType,arguments.siteID )>
		<cfset var qSets		= sExtension.getSetsQuery() />
		
		<cfif qSets.recordCount>
			<!--- already exists --->
			<cfreturn sExtension />
		</cfif>

		<cfset sExtension.setType(arguments.Type)>
		<cfset sExtension.setSubType(arguments.subType)>
		<cfset sExtension.setIsActive(1)>
		<cfset sExtension.setBaseKeyField(arguments.baseKeyField)>
		<cfset sExtension.setBaseTable(arguments.baseTable)>
		<cfset sExtension.setDataTable(arguments.dataTable)>
		<cfset sExtension.setSiteID(arguments.siteID)>
		
		<cfset sExtension.save()>

		<cfreturn sExtension />
	</cffunction>

	<cffunction name="addExtendSet" returntype="any" access="private" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfargument name="name" type="string" required="true">
		<cfargument name="subTypeID" required="true" type="string">
		<cfargument name="container" required="false" type="string" default="Basic">

		<cfset var sExtendSet = variables.instance.extensionManager.getSubTypeBean().getExtendSetBean()>
		<cfset var attName = "">

		

		<cfset sExtendSet.setSubTypeID(arguments.subTypeID)>
		<cfset sExtendSet.setName(arguments.name)>
		<cfset sExtendSet.setOrderNo(0)>
		<cfset sExtendSet.setIsActive(1)>
		<cfset sExtendSet.setSiteID(arguments.siteID)>
		<cfset sExtendSet.setContainer( arguments.container )>
		
		<cfset sExtendSet.save()>
		
		<cfreturn sExtendSet />
	</cffunction>
</cfcomponent>