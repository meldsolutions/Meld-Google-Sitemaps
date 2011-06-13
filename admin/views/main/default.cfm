<cfsilent>
	<!--- headers --->
	<cfoutput>
	</cfoutput>
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
<div id="meld-body">
	<!-- CONTENT HERE -->
<h3>About Meld Google Sitemaps</h3>
<p>Meld Google Sitemaps adds automated Google sitemap generation to your Mura CMS website.</p>

<h4>Functionality</h4>
<p>Meld Google Sitemaps automatically generates a Google sitemap.xml file by using the configuration information found under the &quot;Extended Attributes&quot; tab for a Mura page.
These settings are:</p>
<ul>
  <li><strong>Exclude From Sitemap</strong>
    <ul>
      <li><em>Inherit: </em>will travel up the parent pages until it finds a page that indicates whether to include or exclude the page</li>
      <li><em>Yes</em>: will exclude this page from the sitemap</li>
      <li><em>No:</em> will not exclude the page from the sitemap</li>
    </ul>
  </li>
  <li><strong>Change Frequency</strong>
    <ul>
      <li>A sitemap-specific setting, indicating how often the page content gets updated</li>
    </ul>
  </li>
  <li><strong>Priority</strong>
    <ul>
      <li>A sitemap-specific setting, telling the search engine how important this page is <em>relative to </em>other pages on your site</li>
    </ul>
  </li>
</ul>
<p>To enable sitemap generation for a site, click on the <em>Settings</em> menu item, then <em>Edit Settings.</em></p>
<ul>
  <li><strong>Sitemap Enabled</strong> 
    <ul>
      <li>The sitemap will be generated on a scheduled basis</li>
    </ul>
  </li>
  <li><strong>Location</strong></li>
  <ul>
    <li><em>Web Root:</em> The sitemap will be located in the base of the web site (do not use if you have multiple sites setup in Mura)</li>
    <li><em>Site Folder: </em>The sitemap will be located in the site folder, i.e. /default/sitemap.xml</li>
  </ul>
  <li><strong>Frequency</strong>
    <ul>
      <li>How often the sitemap will be automatically generated</li>
    </ul>
  </li>
  <li><strong>Time of Day</strong>
    <ul>
      <li>The time of day the sitemap will be generated</li>
    </ul>
  </li>
  <li><strong>Email</strong>
    <ul>
      <li>If you want to be notified of when a sitemap is generated, enter an Email address here (and ensure your Mura Email settings are configured properly)</li>
    </ul>
  </li>
</ul>
<h4>How It Works </h4>
<p>Meld Google Sitemaps creates a scheduled task that will move through your Mura CMS pages and add pages to the sitemap.xml file according to the settings set in the
<em>Extended Attributes</em> tab. </p>
<p>Note that it is a good idea (though not strictly necessary) to register your Google sitemap with search engines. To do this with Google, for instance, visit Google's
<a href="http://www.google.com/webmasters/tools/" target="_blank">Webmaster/Site owner tools</a>.</p>
<p>&nbsp;</p>


</div>	
<!--- end content --->
</cfoutput> 