<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [

<!ENTITY lowercase "'abcdefghijklmnopqrstuvwxyz'">
<!ENTITY uppercase "'ABCDEFGHIJKLMNOPQRSTUVWXYZ'">

<!ENTITY primary   'normalize-space(concat(primary/@sortas, primary[not(@sortas)]))'>
<!ENTITY secondary 'normalize-space(concat(secondary/@sortas, secondary[not(@sortas)]))'>
<!ENTITY tertiary  'normalize-space(concat(tertiary/@sortas, tertiary[not(@sortas)]))'>
<!ENTITY scope 'count(ancestor::node()|$scope) = count(ancestor::node())'>
<!ENTITY sep '" "'>
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
	<!-- Customizing the toc.line template to place page-number-prefix
       in the TOC -->
	<xsl:template name="toc.line">
		<xsl:variable name="id">
			<xsl:call-template name="object.id"/>
		</xsl:variable>
		<xsl:variable name="label">
			<xsl:apply-templates select="." mode="label.markup">
				<xsl:with-param name="purpose" select="'toc'"/>
			</xsl:apply-templates>
		</xsl:variable>
		<fo:block text-align-last="justify" end-indent="{$toc.indent.width}pt"
			last-line-end-indent="-{$toc.indent.width}pt">
			<fo:inline keep-with-next.within-line="always">
				<fo:basic-link internal-destination="{$id}">
					<xsl:if test="$label != ''">
						<xsl:copy-of select="$label"/>
						<xsl:value-of select="$autotoc.label.separator"/>
					</xsl:if>
					<xsl:apply-templates select="." mode="title.markup"/>
				</fo:basic-link>
			</fo:inline>
			<fo:inline keep-together.within-line="always">
				<xsl:text> </xsl:text>
				<fo:leader leader-pattern="dots" leader-pattern-width="3pt"
					leader-alignment="reference-area" keep-with-next.within-line="always"/>
				<xsl:text> </xsl:text>
				<fo:basic-link internal-destination="{$id}">
					<xsl:apply-templates mode="page-number-prefix" select="."/>
					<fo:page-number-citation ref-id="{$id}"/>
				</fo:basic-link>
			</fo:inline>
		</fo:block>
	</xsl:template>
	<xsl:template match="indexterm" mode="reference">
		<xsl:param name="scope" select="."/>
		<xsl:param name="separator" select="', '"/>
		<xsl:if test="$passivetex.extensions = '0'">
			<xsl:value-of select="$separator"/>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="@zone and string(@zone)">
				<xsl:call-template name="reference">
					<xsl:with-param name="zones" select="normalize-space(@zone)"/>
					<xsl:with-param name="scope" select="$scope"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="id">
					<xsl:call-template name="object.id"/>
				</xsl:variable>
				<fo:basic-link internal-destination="{$id}">
					<xsl:apply-templates mode="page-number-prefix" select="."/>
					<fo:page-number-citation ref-id="{$id}"/>
				</fo:basic-link>
				<xsl:if test="key('endofrange', @id)[&scope;]">
					<xsl:apply-templates select="key('endofrange', @id)[&scope;][last()]" mode="reference">
						<xsl:with-param name="scope" select="$scope"/>
						<xsl:with-param name="separator" select="'-'"/>
					</xsl:apply-templates>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="reference">
		<xsl:param name="scope" select="."/>
		<xsl:param name="zones"/>
		<xsl:choose>
			<xsl:when test="contains($zones, ' ')">
				<xsl:variable name="zone" select="substring-before($zones, ' ')"/>
				<xsl:variable name="target" select="key('id', $zone)[&scope;]"/>
				<xsl:variable name="id">
					<xsl:call-template name="object.id">
						<xsl:with-param name="object" select="$target[1]"/>
					</xsl:call-template>
				</xsl:variable>
				<fo:basic-link internal-destination="{$id}">
					<xsl:apply-templates mode="page-number-prefix" select="$target[1]"/>
					<fo:page-number-citation ref-id="{$id}"/>
				</fo:basic-link>
				<xsl:if test="$passivetex.extensions = '0'">
					<xsl:text>, </xsl:text>
				</xsl:if>
				<xsl:call-template name="reference">
					<xsl:with-param name="zones" select="substring-after($zones, ' ')"/>
					<xsl:with-param name="scope" select="$scope"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="zone" select="$zones"/>
				<xsl:variable name="target" select="key('id', $zone)[&scope;]"/>
				<xsl:variable name="id">
					<xsl:call-template name="object.id">
						<xsl:with-param name="object" select="$target[1]"/>
					</xsl:call-template>
				</xsl:variable>
				<fo:basic-link internal-destination="{$id}">
					<xsl:apply-templates mode="page-number-prefix" select="$target[1]"/>
					<fo:page-number-citation ref-id="{$id}"/>
				</fo:basic-link>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="indexterm" mode="reference-markup">
		<xsl:param name="scope" select="."/>
		<xsl:choose>
			<xsl:when test="@zone and string(@zone)">
				<xsl:call-template name="reference-markup">
					<xsl:with-param name="zones" select="normalize-space(@zone)"/>
					<xsl:with-param name="scope" select="$scope"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="id">
					<xsl:call-template name="object.id"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="@startref and @class='endofrange'">
						<xsl:text>&lt;phrase role="pageno"&gt;</xsl:text>
						<xsl:text>&lt;link linkend="</xsl:text>
						<xsl:value-of select="@startref"/>
						<xsl:text>"&gt;</xsl:text>
						<fo:basic-link internal-destination="{@startref}">
							<xsl:apply-templates mode="page-number-prefix" select="."/>
							<fo:page-number-citation ref-id="{@startref}"/>
							<xsl:text>-</xsl:text>
							<fo:page-number-citation ref-id="{$id}"/>
						</fo:basic-link>
						<xsl:text>&lt;/link&gt;</xsl:text>
						<xsl:text>&lt;/phrase&gt;&#10;</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>&lt;phrase role="pageno"&gt;</xsl:text>
						<xsl:if test="@id">
							<xsl:text>&lt;link linkend="</xsl:text>
							<xsl:value-of select="$id"/>
							<xsl:text>"&gt;</xsl:text>
						</xsl:if>
						<fo:basic-link internal-destination="{$id}">
							<xsl:apply-templates mode="page-number-prefix" select="."/>
							<fo:page-number-citation ref-id="{$id}"/>
						</fo:basic-link>
						<xsl:if test="@id">
							<xsl:text>&lt;/link&gt;</xsl:text>
						</xsl:if>
						<xsl:text>&lt;/phrase&gt;&#10;</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="reference-markup">
		<xsl:param name="scope" select="."/>
		<xsl:param name="zones"/>
		<xsl:choose>
			<xsl:when test="contains($zones, ' ')">
				<xsl:variable name="zone" select="substring-before($zones, ' ')"/>
				<xsl:variable name="target" select="key('id', $zone)[&scope;]"/>
				<xsl:variable name="id">
					<xsl:call-template name="object.id">
						<xsl:with-param name="object" select="$target[1]"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:text>&lt;phrase fole="pageno"&gt;</xsl:text>
				<xsl:if test="$target[1]/@id">
					<xsl:text>&lt;link linkend="</xsl:text>
					<xsl:value-of select="$id"/>
					<xsl:text>"&gt;</xsl:text>
				</xsl:if>
				<fo:basic-link internal-destination="{$id}">
					<xsl:apply-templates mode="page-number-prefix" select="$target[1]"/>
					<fo:page-number-citation ref-id="{$id}"/>
				</fo:basic-link>
				<xsl:if test="$target[1]/@id">
					<xsl:text>&lt;/link&gt;</xsl:text>
				</xsl:if>
				<xsl:text>&lt;/phrase&gt;&#10;</xsl:text>
				<xsl:call-template name="reference">
					<xsl:with-param name="zones" select="substring-after($zones, ' ')"/>
					<xsl:with-param name="scope" select="$scope"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="zone" select="$zones"/>
				<xsl:variable name="target" select="key('id', $zone)[&scope;]"/>
				<xsl:variable name="id">
					<xsl:call-template name="object.id">
						<xsl:with-param name="object" select="$target[1]"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:text>&lt;phrase role="pageno"&gt;</xsl:text>
				<xsl:if test="$target[1]/@id">
					<xsl:text>&lt;link linkend="</xsl:text>
					<xsl:value-of select="$id"/>
					<xsl:text>"&gt;</xsl:text>
				</xsl:if>
				<fo:basic-link internal-destination="{$id}">
					<xsl:apply-templates mode="page-number-prefix" select="$target[1]"/>
					<fo:page-number-citation ref-id="{$id}"/>
				</fo:basic-link>
				<xsl:if test="$target[1]/@id">
					<xsl:text>&lt;/link&gt;</xsl:text>
				</xsl:if>
				<xsl:text>&lt;/phrase&gt;&#10;</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="footer.content">
		<xsl:param name="pageclass" select="''"/>
		<xsl:param name="sequence" select="''"/>
		<xsl:param name="position" select="''"/>
		<xsl:param name="gentext-key" select="''"/>
		<!--
  <fo:block>
    <xsl:value-of select="$pageclass"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$sequence"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$position"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$gentext-key"/>
  </fo:block>
-->
		<fo:block>
			<!-- sequence can be odd, even, first, blank -->
			<!-- position can be left, center, right -->
			<xsl:choose>
				<xsl:when test="$pageclass='titlepage'">
					<!-- nop: other titlepage sequences have no footer -->
				</xsl:when>
				<xsl:when test="$pageclass='lot' and $position = 'first'">
					<xsl:apply-templates mode="page-number-prefix" select="."/>
					<fo:page-number/>
				</xsl:when>
				<xsl:when test="$sequence='blank'">
					<xsl:choose>
						<xsl:when test="$double.sided != 0 and $position = 'left'">
							<xsl:apply-templates mode="page-number-prefix" select="."/>
							<fo:page-number/>
						</xsl:when>
						<xsl:when test="$double.sided = 0 and $position = 'center'">
							<xsl:apply-templates mode="page-number-prefix" select="."/>
							<fo:page-number/>
						</xsl:when>
						<xsl:otherwise>
							<!-- nop -->
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when
					test="starts-with($gentext-key,'refentry')
                      and $sequence='first' and $position='right'">
					<xsl:apply-templates mode="page-number-prefix" select="."/>
					<fo:page-number/>
				</xsl:when>
				<xsl:when test="$double.sided != 0 and $sequence = 'even' and $position='left'">
					<xsl:apply-templates mode="page-number-prefix" select="."/>
					<fo:page-number/>
				</xsl:when>
				<xsl:when test="$double.sided != 0 and $sequence = 'odd' and $position='right'">
					<xsl:apply-templates mode="page-number-prefix" select="."/>
					<fo:page-number/>
				</xsl:when>
				<xsl:otherwise>
					<!-- nop -->
				</xsl:otherwise>
			</xsl:choose>
		</fo:block>
	</xsl:template>
	<xsl:template match="chapter">
		<xsl:variable name="id">
			<xsl:call-template name="object.id"/>
		</xsl:variable>
		<xsl:variable name="master-reference">
			<xsl:call-template name="select.pagemaster"/>
		</xsl:variable>
		<fo:page-sequence id="{$id}" hyphenate="{$hyphenate}" master-reference="{$master-reference}">
			<xsl:attribute name="language">
				<xsl:call-template name="l10n.language"/>
			</xsl:attribute>
			<xsl:attribute name="format">
				<xsl:call-template name="page.number.format"/>
			</xsl:attribute>
			<xsl:choose>
				<xsl:when
					test="not(preceding::chapter
                          or preceding::appendix
                          or preceding::article
                          or preceding::dedication
                          or parent::part
                          or parent::reference)">
					<!-- if there is a preceding component or we're in a part, the -->
					<!-- page numbering will already be adjusted -->
					<xsl:attribute name="initial-page-number">1</xsl:attribute>
				</xsl:when>
				<xsl:when test="$double.sided != 0">
					<xsl:attribute name="initial-page-number">1</xsl:attribute>
				</xsl:when>
			</xsl:choose>
			<xsl:apply-templates select="." mode="running.head.mode">
				<xsl:with-param name="master-reference" select="$master-reference"/>
			</xsl:apply-templates>
			<xsl:apply-templates select="." mode="running.foot.mode">
				<xsl:with-param name="master-reference" select="$master-reference"/>
			</xsl:apply-templates>
			<fo:flow flow-name="xsl-region-body">
				<xsl:call-template name="chapter.titlepage"/>
				<xsl:variable name="toc.params">
					<xsl:call-template name="find.path.params">
						<xsl:with-param name="table" select="normalize-space($generate.toc)"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:if test="contains($toc.params, 'toc')">
					<xsl:call-template name="component.toc"/>
				</xsl:if>
				<xsl:apply-templates/>
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
	<xsl:template match="book/index|part/index">
		<xsl:variable name="id">
			<xsl:call-template name="object.id"/>
		</xsl:variable>
		<xsl:if test="$generate.index != 0">
			<xsl:variable name="master-reference">
				<xsl:call-template name="select.pagemaster">
					<xsl:with-param name="pageclass">
						<xsl:if test="$make.index.markup != 0">body</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<fo:page-sequence id="{$id}" hyphenate="{$hyphenate}" master-reference="{$master-reference}">
				<xsl:attribute name="language">
					<xsl:call-template name="l10n.language"/>
				</xsl:attribute>
				<xsl:attribute name="format">
					<xsl:call-template name="page.number.format"/>
				</xsl:attribute>
				<xsl:attribute name="initial-page-number">1</xsl:attribute>
				<xsl:apply-templates select="." mode="running.head.mode">
					<xsl:with-param name="master-reference" select="$master-reference"/>
				</xsl:apply-templates>
				<xsl:apply-templates select="." mode="running.foot.mode">
					<xsl:with-param name="master-reference" select="$master-reference"/>
				</xsl:apply-templates>
				<fo:flow flow-name="xsl-region-body">
					<xsl:call-template name="index.titlepage"/>
					<xsl:apply-templates/>
					<xsl:if test="count(indexentry) = 0 and count(indexdiv) = 0">
						<xsl:choose>
							<xsl:when test="$make.index.markup != 0">
								<fo:block wrap-option="no-wrap" white-space-collapse="false"
									xsl:use-attribute-sets="monospace.verbatim.properties"
									linefeed-treatment="preserve">
									<xsl:call-template name="generate-index-markup">
										<xsl:with-param name="scope" select="(ancestor::book|/)[last()]"/>
									</xsl:call-template>
								</fo:block>
							</xsl:when>
							<xsl:when test="indexentry|indexdiv/indexentry">
								<xsl:apply-templates/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="generate-index">
									<xsl:with-param name="scope" select="(ancestor::book|/)[last()]"/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</fo:flow>
			</fo:page-sequence>
		</xsl:if>
	</xsl:template>
	<xsl:template match="chapter|chapter//*" mode="page-number-prefix">
		<xsl:number count="chapter" from="book" level="any"/>
		<xsl:text>&#x2013;</xsl:text>
	</xsl:template>
	<xsl:template match="appendix|appendix//*" mode="page-number-prefix">
		<xsl:number count="appendix" from="book" level="single" format="A"/>
		<xsl:text>&#x2013;</xsl:text>
	</xsl:template>
	<xsl:template match="glossary|glossary//*" mode="page-number-prefix">
		<xsl:variable name="glossname">
			<xsl:call-template name="gentext">
				<xsl:with-param name="key" select="'glossary'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="substring($glossname,1,1)"/>
		<xsl:text>&#x2013;</xsl:text>
	</xsl:template>
	<xsl:template match="index|index//*" mode="page-number-prefix">
		<xsl:call-template name="gentext">
			<xsl:with-param name="key" select="'index'"/>
		</xsl:call-template>
		<xsl:text>&#x2013;</xsl:text>
	</xsl:template>
	<xsl:template match="reference|reference//*" mode="page-number-prefix">
		<xsl:apply-templates select="preceding::chapter[1]" mode="page-number-prefix"/>
	</xsl:template>
	<xsl:template match="refentry|refentry//*" mode="page-number-prefix">
		<xsl:apply-templates select="preceding::chapter[1]" mode="page-number-prefix"/>
	</xsl:template>
	<xsl:template match="*" mode="page-number-prefix"/>
</xsl:stylesheet>
