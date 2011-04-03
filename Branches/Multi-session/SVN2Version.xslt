<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	            xmlns:mnf="urn:schemas-microsoft-com:asm.v1" 
	            xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
	<xsl:output method="text" encoding="ISO-8859-1"/>
	<xsl:output name="XML_FORMAT" method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:param name="STATUS_FILE" />
	<xsl:param name="MANIFEST_FILE" />
	<xsl:param name="MANIFEST_OUTPUT" />
	<xsl:param name="VERSION_SCRIPT" />
	
	<xsl:variable name="STATUS_URI" select="concat('file:/',replace(replace($STATUS_FILE,'\\','/'),'^/',''))"/>
	<xsl:variable name="MANIFEST_URI" select="concat('file:/',replace(replace($MANIFEST_FILE,'\\','/'),'^/',''))"/>
	<xsl:variable name="MANIFEST_OUTPUT_URI" select="concat('file:/',replace(replace($MANIFEST_OUTPUT,'\\','/'),'^/',''))"/>
	<xsl:variable name="VERSION_URI" select="concat('file:/',replace(replace($VERSION_SCRIPT,'\\','/'),'^/',''))"/>
	
	<xsl:template match="/info">
		<xsl:message select="$STATUS_URI" />
		<xsl:message select="$MANIFEST_URI" />
		<xsl:message select="$MANIFEST_OUTPUT_URI" />
		<xsl:message select="$VERSION_URI" />
	
		<xsl:variable name="DATE" select="entry/commit/date"/>
		<xsl:variable name="REVISION" select="entry/commit/@revision"/>
		<xsl:variable name="VERSION" select="replace(entry/url,'.*/','')"/>
		<xsl:variable name="VERSION2" select="if(substring($VERSION,1,1)='V') then substring($VERSION,2) else '0'"/>
		<xsl:variable name="VER_LIST" select="tokenize($VERSION2, '\.')"/>
		<xsl:variable name="END_VER" select="subsequence(('0','0',$REVISION), count($VER_LIST))"/>
		<xsl:variable name="FULL_VER" select="string-join(($VER_LIST,$END_VER),'.')"/>
		<xsl:for-each select="document($STATUS_URI)/status">
			<xsl:variable name="UNVERSIONED" select="count(target/entry/wc-status[@item='unversioned'])"/>
			<xsl:variable name="MODIFIED" select="count(target/entry/wc-status[@item='modified'])"/>
			<xsl:variable name="DELETED" select="count(target/entry/wc-status[@item='deleted'])"/>
			<xsl:variable name="OUTOFDATE" select="count(target/entry/wc-status[@revision ne $REVISION])"/>
			<xsl:variable name="MANAGED" select="not(($UNVERSIONED gt 0) or ($MODIFIED gt 0) or ($DELETED gt 0) or ($OUTOFDATE gt 0))" />
			<xsl:variable name="MANAGED_TEXT" select="if ($MANAGED) then 'true' else 'false'"/>
			<xsl:variable name="TRUST_VERSION" select="if ($MANAGED) then concat($VERSION, 'R', $REVISION) else substring(replace(current-dateTime() cast as xs:string,':|-|T',''),3,10)"/>
			<xsl:variable name="PROJECT" select="document($MANIFEST_URI)/mnf:assembly/mnf:assemblyIdentity/@name"/>

			<xsl:text>/* This file is autogenerated by SVN2Version procedure. */&#x0A;</xsl:text>
			<xsl:text>#define SVN_DATE (_T("</xsl:text>
			<xsl:value-of select="$DATE"/>
			<xsl:text>"))&#x0A;#define SVN_REVISION (</xsl:text>
			<xsl:value-of select="$REVISION"/>
			<xsl:text>)&#x0A;#define SVN_VERSION (_T("</xsl:text>
			<xsl:value-of select="$VERSION"/>
			<xsl:text>"))&#x0A;#define FULL_SVNVER (_T("</xsl:text>
			<xsl:value-of select="$FULL_VER"/>
			<xsl:text>"))&#x0A;#define SVN_MANAGED (</xsl:text>
			<xsl:value-of select="$MANAGED_TEXT"/>
			<xsl:text>)</xsl:text>
			<xsl:if test="not($MANAGED)">
				<xsl:value-of select="concat(' //-- ',$MODIFIED,' Modified, ',$DELETED,' Deleted', if($UNVERSIONED gt 0)then ', Unversionned' else '', if($OUTOFDATE gt 0)then ', Need an UPDATE' else '')"/>
			</xsl:if>

			<xsl:result-document href="{$MANIFEST_OUTPUT_URI}" format="XML_FORMAT">	
				<xsl:comment select="concat('This file is auto-generated based on ',$MANIFEST_FILE)"/>
				<xsl:text>&#x0A;</xsl:text>
				<xsl:for-each select="document($MANIFEST_URI)/*">
					<xsl:apply-templates mode="COPY_MANIFEST" select=".">
						<xsl:with-param name="VERSION" select="$FULL_VER" tunnel="yes"/>
					</xsl:apply-templates>
				</xsl:for-each>
			</xsl:result-document>

			<xsl:result-document href="{$VERSION_URI}" method="text">
				<xsl:value-of select="concat($TRUST_VERSION, '&#x0A;')"/>
			</xsl:result-document>
		</xsl:for-each>
		<xsl:text>&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="@version[.='0.0.0.0']" mode="COPY_MANIFEST">
		<xsl:param name="VERSION" tunnel="yes"/>
		<xsl:attribute name="version" select="$VERSION" />
	</xsl:template>

	<xsl:template match="@*|node()" mode="COPY_MANIFEST">
	  <xsl:copy>
		<xsl:apply-templates mode="COPY_MANIFEST" select="@*|node()"/>
	  </xsl:copy>
	</xsl:template>
</xsl:stylesheet>