<?xml version="1.0" encoding="UTF-8" ?>
<!-- 
	Author: Sean Wheller [sean@inwords.co.za] 
	License: GNU-GPL 
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <!-- This file is a common customization layer -->
    <!-- ======================= -->
    
    <!-- ======================= -->
    <!-- Parameters -->
    <!-- ======================= -->
    <!-- Numbering -->
	<xsl:param name="chapter.autolabel" select="1"/>
	<xsl:param name="section.autolabel" select="1"/>
	<xsl:param name="section.label.includes.component.label" select="1"/>
	<xsl:param name="appendix.autolabel" select="'A'"/>
	
	
    <!-- Extensions -->
     <xsl:param name="use.extensions" select="1"/>
    <xsl:param name="saxon.extensions" select="1"/>
    <xsl:param name="tablecolumns.extension" select="1"/>
    <xsl:param name="callouts.extensions" select="1"/> 
    
    <!-- General Formatting-->
    <xsl:param name="draft.mode" select="'no'"/>
    <xsl:param name="hyphenate">false</xsl:param>
    <xsl:param name="alignment">left</xsl:param>
    
    <!-- Cross References -->
    <xsl:param name="insert.xref.page.number" select="'yes'"/>
    <xsl:param name="xref.with.number.and.title" select="1"/>
    
    <!-- Indexes -->
    <xsl:param name="generate.index" select="0"/>
    
    <!-- Glossaries -->
    <xsl:param name="glossterm.auto.link" select="1"/>
    <xsl:param name="firstterm.only.link" select="1"/>
	<xsl:param name="glossary.collection" select="'../common/glossary.xml'"/>
    <xsl:param name="glossentry.show.acronym" select="'primary'"/>
    
    
    
    <!-- ======================= -->
    <!-- Templates -->
    <!-- ======================= -->
  <!-- Section level heading styles -->
  <xsl:attribute-set name="section.title.level1.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.2"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  	<!--<xsl:attribute name="padding-top">20pt</xsl:attribute>
  	 <xsl:attribute name="padding-bottom">6pt</xsl:attribute> -->
  </xsl:attribute-set>
    <xsl:attribute-set name="section.title.level1.properties">
      
    </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level2.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.2"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level3.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.2"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level4.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.2"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level5.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.2"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
	
    <!-- Inline Formatting -->
    <xsl:template match="guibutton">
        <xsl:call-template name="inline.boldseq"/>
    </xsl:template>
    <xsl:template match="filename">
        <xsl:call-template name="inline.boldmonoseq"/>
    </xsl:template>
    <xsl:template match="interface">
      <xsl:call-template name="inline.boldseq"/>
    </xsl:template>
    <xsl:template match="option">
      <xsl:call-template name="inline.boldseq"/>
    </xsl:template>
    <xsl:template match="guilabel">
      <xsl:call-template name="inline.boldseq"/>
    </xsl:template>
    <xsl:template match="keycap">
      <xsl:call-template name="inline.boldseq"/>
    </xsl:template>
    <xsl:template match="application">
      <xsl:call-template name="inline.boldseq"/>
    </xsl:template>
    
</xsl:stylesheet>
