<plugin>
<name>Google Sitemaps</name>
<package>MeldGoogleSitemaps</package>
<directoryFormat>packageOnly</directoryFormat>
<version>2.2.0</version>
<autoDeploy>true</autoDeploy>
<siteid>default</siteid>
<provider>Meld Solutions Inc.</provider>
<providerURL>http://www.meldsolutions.com</providerURL>
<category>Utility</category>
<settings>
</settings>
<scripts></scripts>
<eventHandlers>
	<eventHandler event="onApplicationLoad" component="events.eventHandler" persist="false"/>
</eventHandlers>
<displayobjects location="global">
</displayobjects>
<extensions>
	<extension type="Page" subtype="Default">
		<attributeset name="Google Sitemaps">
			<attribute name="exclude"
				label="Exclude From Sitemap"
				hint="Exclude this page from the sitemap"
				type="SelectBox"
				defaultValue="inherit"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="inherit^no^yes"
				optionLabelList="Inherit^No^Yes" />
			<attribute name="changefrequency"
				label="Change Frequency"
				hint="The change frequency for the page"
				type="SelectBox"
				defaultValue="monthly"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="daily^weekly^monthly^yearly"
				optionLabelList="Daily^Weekly^Monthly^Yearly" />
			<attribute name="priority"
				label="Priority"
				hint="The relative importance of the page to the site"
				type="SelectBox"
				defaultValue="inherit"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0"
				optionLabelList="0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0" />
		</attributeset>
	</extension>
	<extension type="File" subtype="Default">
		<attributeset name="Google Sitemaps">
			<attribute name="exclude"
				label="Exclude From Sitemap"
				hint="Exclude this page from the sitemap"
				type="SelectBox"
				defaultValue="inherit"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="inherit^no^yes"
				optionLabelList="Inherit^No^Yes" />
			<attribute name="changefrequency"
				label="Change Frequency"
				hint="The change frequency for the page"
				type="SelectBox"
				defaultValue="monthly"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="daily^weekly^monthly^yearly"
				optionLabelList="Daily^Weekly^Monthly^Yearly" />
			<attribute name="priority"
				label="Priority"
				hint="The relative importance of the page to the site"
				type="SelectBox"
				defaultValue="inherit"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0"
				optionLabelList="0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0" />
		</attributeset>
	</extension>
	<extension type="Calendar" subtype="Default">
		<attributeset name="Google Sitemaps">
			<attribute name="exclude"
				label="Exclude From Sitemap"
				hint="Exclude this page from the sitemap"
				type="SelectBox"
				defaultValue="inherit"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="inherit^no^yes"
				optionLabelList="Inherit^No^Yes" />
			<attribute name="changefrequency"
				label="Change Frequency"
				hint="The change frequency for the page"
				type="SelectBox"
				defaultValue="monthly"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="daily^weekly^monthly^yearly"
				optionLabelList="Daily^Weekly^Monthly^Yearly" />
			<attribute name="priority"
				label="Priority"
				hint="The relative importance of the page to the site"
				type="SelectBox"
				defaultValue="inherit"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0"
				optionLabelList="0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0" />
		</attributeset>
	</extension>
	<extension type="Gallery" subtype="Default">
		<attributeset name="Google Sitemaps">
			<attribute name="exclude"
				label="Exclude From Sitemap"
				hint="Exclude this page from the sitemap"
				type="SelectBox"
				defaultValue="inherit"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="inherit^no^yes"
				optionLabelList="Inherit^No^Yes" />
			<attribute name="changefrequency"
				label="Change Frequency"
				hint="The change frequency for the page"
				type="SelectBox"
				defaultValue="monthly"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="daily^weekly^monthly^yearly"
				optionLabelList="Daily^Weekly^Monthly^Yearly" />
			<attribute name="priority"
				label="Priority"
				hint="The relative importance of the page to the site"
				type="SelectBox"
				defaultValue="inherit"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0"
				optionLabelList="0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0" />
		</attributeset>
	</extension>
	<extension type="Portal" subtype="Default">
		<attributeset name="Google Sitemaps">
			<attribute name="exclude"
				label="Exclude From Sitemap"
				hint="Exclude this page from the sitemap"
				type="SelectBox"
				defaultValue="inherit"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="inherit^no^yes"
				optionLabelList="Inherit^No^Yes" />
			<attribute name="changefrequency"
				label="Change Frequency"
				hint="The change frequency for the page"
				type="SelectBox"
				defaultValue="monthly"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="daily^weekly^monthly^yearly"
				optionLabelList="Daily^Weekly^Monthly^Yearly" />
			<attribute name="priority"
				label="Priority"
				hint="The relative importance of the page to the site"
				type="SelectBox"
				defaultValue="inherit"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0"
				optionLabelList="0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0" />
		</attributeset>
	</extension>
	<extension type="Folder" subtype="Default">
		<attributeset name="Google Sitemaps">
			<attribute name="exclude"
				label="Exclude From Sitemap"
				hint="Exclude this page from the sitemap"
				type="SelectBox"
				defaultValue="inherit"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="inherit^no^yes"
				optionLabelList="Inherit^No^Yes" />
			<attribute name="changefrequency"
				label="Change Frequency"
				hint="The change frequency for the page"
				type="SelectBox"
				defaultValue="monthly"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="daily^weekly^monthly^yearly"
				optionLabelList="Daily^Weekly^Monthly^Yearly" />
			<attribute name="priority"
				label="Priority"
				hint="The relative importance of the page to the site"
				type="SelectBox"
				defaultValue="inherit"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0"
				optionLabelList="0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0" />
		</attributeset>
	</extension>
	<extension type="Custom" subtype="MeldGoogleSitemaps">
		<attributeset name="MeldGoogleSitemaps">
			<attribute name="Location"
				label="Sitemap Location"
				type="TextBox"
				defaultValue="site" />
			<attribute name="Frequency"
				label="Frequency"
				type="TextBox"
				defaultValue="weekly" />
			<attribute name="Enabled"
				label="Enabled"
				type="TextBox"
				validation="Numeric"
				defaultValue="0" />
			<attribute name="Email"
				label="Email"
				type="TextBox" />
			<attribute name="DateLastCreate"
				label="DateLastCreate"
				type="TextBox"
				validation="Date" />
			<attribute name="TimeOfDay"
				label="TimeOfDay"
				type="TextBox"
				validation="Date" />
		</attributeset>
	</extension>
</extensions>
</plugin>
