<?xml version="1.0" encoding="UTF-8" ?>
<!-- 
	Author: Sean Wheller [sean@inwords.co.za] 
	License: GNU-GPL 
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
	
	<!-- This file is a customization layer for FO only -->
	<!-- ======================= -->
	<!-- Imports -->
	<!--<xsl:import href="/usr/share/xml/docbook/stylesheet/nwalsh/fo/profile-docbook.xsl"/>-->
	<!--<xsl:import href="/usr/share/xml/docbook/stylesheet/nwalsh/current/fo/profile-docbook.xsl"/>-->
	<!--<xsl:import href="/home/sean/apps/oxygen/frameworks/docbook/xsl/fo/docbook.xsl"/>-->
	<xsl:import href="docbook/xsl/fo/docbook.xsl"/>
	
	<xsl:import href="PageNumberPrefixes.xsl"/> 
	<xsl:import href="fo.titlepages.xsl"/>
	<xsl:include href="common-cust.xsl"/>
	
	<!-- ======================= -->
	<!-- Parameters -->
	<!-- ======================= -->
	
	<xsl:param name="fop.extensions" select="1"/>
	
	<xsl:param name="body.font.master" select="'10'"/>
	
	
	<!-- THIS IS BUGGY
		Customize shade verbatim so that programlisting will 
		wrap nice and show \ character for line
		continuation 
	
	
	
	<xsl:param name="hyphenate.verbatim" select="1"/>
	<xsl:attribute-set name="monospace.verbatim.properties">
		<xsl:attribute name="wrap-option">wrap</xsl:attribute>
		<xsl:attribute name="hyphenation-character">\</xsl:attribute>
	</xsl:attribute-set>-->
	<xsl:param name="shade.verbatim" select="1"/>
	
	
	<!-- Page Margins -->
	<xsl:param name="page.height.portrait">22.86cm</xsl:param>
	<xsl:param name="page.width.portrait">19.05cm</xsl:param>
	
	<xsl:param name="page.margin.inner">2cm</xsl:param>
	<xsl:param name="page.margin.outer">2.5cm</xsl:param>
	
	<xsl:param name= "page.margin.top">1cm</xsl:param>
	<xsl:param name="region.before.extent">1cm</xsl:param>
	<xsl:param name="body.margin.top">1.5cm</xsl:param>
	
	<xsl:param name="page.margin.bottom">0.5cm</xsl:param>
	<xsl:param name="region.after.extent">1cm</xsl:param>
	<xsl:param name="body.margin.bottom">1.5cm</xsl:param>
	
	<xsl:param name="double.sided">1</xsl:param>
	
	
	<!-- Admon Graphics -->
	<xsl:param name="admon.graphics" select="1"/>
	<xsl:param name="admon.textlabel" select="0"/>
	<xsl:param name="admon.graphics.path" select="'images/admon/'"/>
	<xsl:param name="admon.graphics.extension" select="'.png'"/>
	
	<!-- Callout Graphics -->
	<xsl:param name="callout.unicode" select="0"/>
	<xsl:param name="callout.graphics" select="0"/>
	<xsl:param name="callout.graphics.path" select="'images/callouts/'"/>
	<xsl:param name="callout.graphics.extension" select="'.png'"/>
	

	
	<!-- Change TOC Title Alignment template -->
	<xsl:template name="table.of.contents.titlepage" priority="1">
		<fo:block
			font-family="Helvetica"
			font-weight="bold"
			font-size="30pt"
			space-before="1in"
			space-before.conditionality="retain"
			border-bottom="1pt solid black"
			text-align="right">
			<xsl:call-template name="gentext">
				<xsl:with-param name="key" select="'TableofContents'"/>
			</xsl:call-template>
		</fo:block>
	</xsl:template>
	
	<!-- Change TOC Title -->
	<xsl:param name="local.l10n.xml" select="document('')"/> 
	<l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"> 
		<l:l10n language="en"> 
			<l:gentext key="TableofContents" text="Contents"/>
		</l:l10n>
	</l:i18n>
	
	<!-- Change toc.line so chapter, preface, apendix, and glosary are bold -->
	<xsl:template name="toc.line">
		<xsl:variable name="id">
			<xsl:call-template name="object.id"/>
		</xsl:variable>
		
		<xsl:variable name="label">
			<xsl:apply-templates select="." mode="label.markup"/>
		</xsl:variable>
		
		<fo:block text-align-last="justify" font-family="Helvetica" font-size="9pt"
			end-indent="{$toc.indent.width}pt"
			last-line-end-indent="-{$toc.indent.width}pt">
			<xsl:choose>
				<xsl:when test="self::chapter | self::preface | self::appendix | self::glossary">
					<xsl:attribute name="space-before">1cm</xsl:attribute>
				</xsl:when>
			</xsl:choose>
			<fo:inline keep-with-next.within-line="always">
				<xsl:choose>
					<xsl:when test="self::preface | self::chapter | self::appendix | self::glossary">
						<xsl:attribute name="font-weight">bold</xsl:attribute>
					</xsl:when>
				</xsl:choose>
				<fo:basic-link internal-destination="{$id}">
					<xsl:if test="$label != '' and not(self::chapter or self::appendix)">
						<xsl:copy-of select="$label"/>
						<xsl:value-of select="$autotoc.label.separator"/>
					</xsl:if>
					<xsl:apply-templates select="." mode="title.markup"/>
				</fo:basic-link>
			</fo:inline>
			<fo:inline keep-together.within-line="always">
			  <xsl:text> </xsl:text>
			  <fo:leader leader-pattern="dots"
				     leader-pattern-width="3pt"
				     leader-alignment="reference-area"
				     keep-with-next.within-line="always"/>
			  <xsl:text> </xsl:text>
			  <fo:basic-link internal-destination="{$id}">
			    <!-- The following template returns page number prefix. 
				 This template is defined in PageNumberPrefixes.xsl -->
			    <xsl:apply-templates mode="page-number-prefix" select="."/>
			    <fo:page-number-citation ref-id="{$id}"/>
			  </fo:basic-link>
			</fo:inline>
		</fo:block>
	</xsl:template>
	
	<xsl:param name="generate.toc">
		appendix  nop
		article/appendix  nop
		article   toc,title
		book      toc,title,figure,table,example,equation
		chapter   nop
		part      nop
		preface   nop
		qandadiv  toc
		qandaset  toc
		reference toc,title
		sect1     toc
		sect2     toc
		sect3     toc
		sect4     toc
		sect5     toc
		section   toc
		set       toc,title
	</xsl:param>
	
	<!-- Change Lists Spacing -->
	<xsl:attribute-set name="list.item.spacing">
		<xsl:attribute name="space-before.optimum">0.5em</xsl:attribute>
		<xsl:attribute name="space-before.minimum">0.5em</xsl:attribute>
		<xsl:attribute name="space-before.maximum">0.5em</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="list.block.spacing">
		<xsl:attribute name="space-before.optimum">0.5em</xsl:attribute>
		<xsl:attribute name="space-before.minimum">0.5em</xsl:attribute>
		<xsl:attribute name="space-before.maximum">0.5em</xsl:attribute>
		<xsl:attribute name="space-after.optimum">0.5em</xsl:attribute>
		<xsl:attribute name="space-after.minimum">0.5em</xsl:attribute>
		<xsl:attribute name="space-after.maximum">0.5em</xsl:attribute>
	</xsl:attribute-set>
	
	<!-- Header/Footer control -->
	
	<!-- Lines on header and footer -->
	<xsl:param name="header.rule" select="1"/>
	<xsl:param name="footer.rule" select="0"/>
	
	<!-- Do not put rule on the first page of component -->
	<xsl:template name="head.sep.rule">
	  <xsl:param name="pageclass"/>
	  <xsl:param name="sequence"/>
	  <xsl:param name="gentext-key"/>

	  <xsl:if test="$header.rule != 0 and $sequence != 'first'">
	    <xsl:attribute name="border-bottom-width">0.5pt</xsl:attribute>
	    <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
	    <xsl:attribute name="border-bottom-color">black</xsl:attribute>
	  </xsl:if>
	</xsl:template>

	<!-- Header/Footer Font and Size Formatting-->
	<xsl:attribute-set name="header.content.properties">
		<xsl:attribute name="font-family">Helvetica</xsl:attribute>
		<xsl:attribute name="font-size">9pt</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="footer.content.properties">
		<xsl:attribute name="font-family">Helvetica</xsl:attribute>
		<xsl:attribute name="font-size">9pt</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:param name="header.column.widths">2 0 2</xsl:param>
	
	<xsl:template name="header.content">  
		<xsl:param name="pageclass" select="''"/>
		<xsl:param name="sequence" select="''"/>
		<xsl:param name="position" select="''"/>
		<xsl:param name="gentext-key" select="''"/>
		
		<xsl:variable name="candidate">
			<!-- sequence can be odd, even, first, blank -->
			<!-- position can be left, center, right -->
			<xsl:choose>
				
				<xsl:when test="$sequence = 'odd' and $position = 'left'">
				</xsl:when>
				
				<xsl:when test="$sequence = 'odd' and $position = 'center'">
				</xsl:when>
				
				<xsl:when test="$sequence = 'odd' and $position = 'right'">
					<xsl:apply-templates select="." mode="titleabbrev.markup"/>
				</xsl:when>
				
				<xsl:when test="$sequence = 'even' and $position = 'left'">  
					<xsl:value-of 
						select="ancestor-or-self::book/bookinfo/titleabbrev"/>
				</xsl:when>
				
				<xsl:when test="$sequence = 'even' and $position = 'center'">
				</xsl:when>
				
				<xsl:when test="$sequence = 'even' and $position = 'right'">
				</xsl:when>
				
				<xsl:when test="$sequence = 'first' and $position = 'left'">
				</xsl:when>
				
				<xsl:when test="$sequence = 'first' and $position = 'right'">  
				</xsl:when>
				
				<xsl:when test="$sequence = 'first' and $position = 'center'"> 
				</xsl:when>
				
				<xsl:when test="$sequence = 'blank' and $position = 'left'">
				</xsl:when>
				
				<xsl:when test="$sequence = 'blank' and $position = 'center'">
				</xsl:when>
				
				<xsl:when test="$sequence = 'blank' and $position = 'right'">
				</xsl:when>
				
			</xsl:choose>
		</xsl:variable>
		
		<!-- Does runtime parameter turn off blank page headers? -->
		<xsl:choose>
			<xsl:when test="$sequence='blank' and $headers.on.blank.pages=0">
				<!-- no output -->
			</xsl:when>
			<!-- titlepages have no headers -->
			<xsl:when test="$pageclass = 'titlepage'">  
				<!-- no output -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$candidate"/>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	<!-- Page Break use &lt?pagebreak?;&gt; to insert a page break -->
	<xsl:template match="processing-instruction('pagebreak')">
		<fo:block break-after="page"/>
	</xsl:template>

	<!-- Special layout of component titlepages - chapter/appendix -->
	<xsl:template name="labeled.component.title">
	  <xsl:param name="node" select="."/>
	  <xsl:variable name="id">
	    <xsl:call-template name="object.id">
	      <xsl:with-param name="object" select="$node"/>
	    </xsl:call-template>
	  </xsl:variable>
	  <fo:block xsl:use-attribute-sets="component.label.properties component.rule.properties">
	    <!-- Workaround FOP id problem -->
	    <xsl:if test="ancestor::chapter">
	      <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
	    </xsl:if>
	    <!-- Uncomment if you want label like chapter/appendix before number -->
	    <!--
	    <xsl:call-template name="gentext">
	      <xsl:with-param name="key" select="local-name(..)"/>
	    </xsl:call-template>
	    <xsl:text> </xsl:text>
	    -->
	    <xsl:apply-templates select="$node" mode="label.markup"/>
	  </fo:block>
	  <fo:block xsl:use-attribute-sets="component.title.properties">
	    <xsl:apply-templates select="$node" mode="title.markup"/>
	  </fo:block>
	</xsl:template>

	<!-- Special layout of unnumbered component titlepages - preface, glossary, ... -->
	<xsl:template name="unlabeled.component.title">
	  <xsl:param name="node" select="."/>
	  <xsl:variable name="id">
	    <xsl:call-template name="object.id">
	      <xsl:with-param name="object" select="$node"/>
	    </xsl:call-template>
	  </xsl:variable>
	  <fo:block xsl:use-attribute-sets="component.label.properties component.rule.properties">
	    <xsl:apply-templates select="$node" mode="title.markup"/>
	  </fo:block>
	</xsl:template>

	<!-- Properties of component title -->
	<xsl:attribute-set name="component.title.properties">
	  <xsl:attribute name="font-size">18pt</xsl:attribute>
	</xsl:attribute-set>

	<!-- Properties of component labels/numbers -->
	<xsl:attribute-set name="component.label.properties" use-attribute-sets="component.title.properties">
	  <xsl:attribute name="font-size">36pt</xsl:attribute>
	  <xsl:attribute name="text-align">right</xsl:attribute>
	</xsl:attribute-set>

	<!-- Properties of rule between component label and title -->
	<xsl:attribute-set name="component.rule.properties">
	  <xsl:attribute name="border-bottom-width">3pt</xsl:attribute>
	  <xsl:attribute name="border-bottom-color">black</xsl:attribute>
	  <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
	</xsl:attribute-set>

	
	<xsl:template name="initial.page.number">
		<xsl:param name="element" select="local-name(.)"/>
		<xsl:param name="master-reference" select="''"/>
		
		<!-- Select the first content that the stylesheet places
			after the TOC -->
		<xsl:variable name="first.book.content" 
			select="ancestor::book/*[
			not(self::title or
			self::subtitle or
			self::titleabbrev or
			self::bookinfo or
			self::info or
			self::dedication or
			self::toc or
			self::lot)][1]"/>
		<xsl:choose>
			<!-- double-sided output -->
			<xsl:when test="$double.sided != 0">
				<xsl:choose>
					<xsl:when test="$element = 'toc'">auto-odd</xsl:when>
					<xsl:when test="$element = 'book'">1</xsl:when>
					<xsl:when test="$element = 'appendix'">1</xsl:when>
					<xsl:when test="$element = 'glossary'">1</xsl:when>
					<!-- preface typically continues TOC roman numerals -->
					<!-- Change page.number.format if not -->
					<xsl:when test="$element = 'preface'">auto-odd</xsl:when>
					<xsl:when test="($element = 'dedication' or $element = 'article') 
						and not(preceding::chapter
						or preceding::preface
						or preceding::appendix
						or preceding::article
						or preceding::dedication
						or parent::part
						or parent::reference)">1</xsl:when>
					<xsl:when test="generate-id($first.book.content) =
						generate-id(.)">1</xsl:when>
					<xsl:otherwise>auto-odd</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			
			<!-- single-sided output -->
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$element = 'toc'">auto</xsl:when>
					<xsl:when test="$element = 'book'">1</xsl:when>
					<xsl:when test="$element = 'appendix'">1</xsl:when>
					<xsl:when test="$element = 'glossary'">1</xsl:when>
					<xsl:when test="$element = 'preface'">auto</xsl:when>
					<xsl:when test="($element = 'dedication' or $element = 'article') and
						not(preceding::chapter
						or preceding::preface
						or preceding::appendix
						or preceding::article
						or preceding::dedication
						or parent::part
						or parent::reference)">1</xsl:when>
					<xsl:when test="generate-id($first.book.content) =
						generate-id(.)">1</xsl:when>
					<xsl:otherwise>auto</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Correct xref chapter - page ref to inlcude prefix -->
	<xsl:template match="*" mode="pagenumber.markup">
		<xsl:apply-templates mode="page-number-prefix" select="."/><fo:page-number-citation ref-id="{@id}"/>
	</xsl:template>
</xsl:stylesheet>
