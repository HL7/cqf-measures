<?xml version="1.0" encoding="UTF-8"?>
<!--
  - Convert packagelist list of packages into XML so they can be used in the generation of default Jira file
  -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/json">
    <package-list>
      <xsl:variable name="list" select="substring-before(substring-after(substring-after(., '&quot;list&quot;'), '['), ']')"/>
      <xsl:call-template name="processPackage">
        <xsl:with-param name="list" select="$list"/>
      </xsl:call-template>
    </package-list>
	</xsl:template>
	<xsl:template name="processPackage">
    <xsl:param name="list"/>
    <xsl:variable name="package" select="substring-before(substring-after($list, '{'), '}')"/>
    <xsl:if test="$package!=''">
      <xsl:variable name="version" select="substring-before(substring-after(substring-after(substring-after($package, '&quot;version&quot;'), ':'), '&quot;'), '&quot;')"/>
      <xsl:variable name="path" select="substring-before(substring-after(substring-after(substring-after($package, '&quot;path&quot;'), ':'), '&quot;'), '&quot;')"/>
      <xsl:variable name="status" select="substring-before(substring-after(substring-after(substring-after($package, '&quot;status&quot;'), ':'), '&quot;'), '&quot;')"/>
      <package version="{$version}" path="{$path}" status="{$status}"/>
      <xsl:call-template name="processPackage">
        <xsl:with-param name="list" select="substring-after($list, '}')"/>
      </xsl:call-template>
    </xsl:if>
	</xsl:template>
</xsl:stylesheet>
