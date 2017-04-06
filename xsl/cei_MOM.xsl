<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cei="http://www.monasterium.net/NS/cei"
	exclude-result-prefixes="cei">
	
<xsl:output method="html" encoding="utf-8" media-type="text/html"/>
 <!-- Elemente, die nur in cei-MOM vorkommen -->
<xsl:template match="cei:pTenor">
	<p><xsl:apply-templates/></p>
</xsl:template>

 <xsl:template match="cei:lang_MOM">
 	<p class="Sprache">Sprache: <xsl:value-of select="." /></p>
</xsl:template>

 <xsl:template match="cei:quoteOriginaldatierung">
	<p>Originaldatierung: <span class="foreign"><xsl:apply-templates/></span></p> 
 </xsl:template>
 
 <xsl:template match="cei:listBiblEdition">
	<p>Edition(en): </p>
	<ul>
		<xsl:for-each select="cei:bibl">
		<li><xsl:value-of select="."/></li>
		</xsl:for-each>
	</ul>
</xsl:template>

<xsl:template match="cei:listBiblRegest">
	<p>Regesten: </p>
	<ul>
		<xsl:for-each select="cei:bibl">
		<li><xsl:value-of select="."/></li>
		</xsl:for-each>
	</ul>
</xsl:template>

<xsl:template match="cei:listBiblFaksimile">
	<p>Abbildungen: </p>
	<ul>
		<xsl:for-each select="cei:bibl">
		<li><xsl:value-of select="."/></li>
		</xsl:for-each>
	</ul>
</xsl:template>

<xsl:template match="cei:listBiblErw">
	<p>Erwähnt: </p>
	<ul>
		<xsl:for-each select="cei:bibl">
		<li><xsl:value-of select="."/></li>
		</xsl:for-each>
	</ul>
</xsl:template>

<xsl:template match="cei:witnessOrig">
		<p class="Archivangaben">Original: 
			<xsl:apply-templates select="cei:archIdentifier|cei:msIdentifier"/>
			<xsl:if test="cei:sigil|@n">
				<xsl:text> (</xsl:text><xsl:value-of select="cei:sigil|@n"/><xsl:text>)</xsl:text>
			</xsl:if>
			<xsl:if test="cei:auth">
				<p>Beglaubigung: <xsl:apply-templates select="cei:auth"/></p>
			</xsl:if>
			<xsl:if test="cei:nota">
				<p>Vermerke: <xsl:apply-templates select="cei:nota"/></p>
			</xsl:if>
			<xsl:apply-templates select="cei:physicalDesc"/>
			</p>
</xsl:template>

<xsl:template match="cei:sealMaterial">
	Siegelstoff: <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="cei:witListPar">
	<xsl:if test="cei:witness">
		<p>Kopial: </p>
			<ul>
				<xsl:for-each select="cei:witness">
					<li class="witness">
					<xsl:value-of select="cei:traditioForm/text()"/><xsl:text> </xsl:text>
					<xsl:apply-templates select="cei:archIdentifier|cei:msIdentifier"/>
					<xsl:if test="cei:sigil|@n">
						<xsl:text> (</xsl:text><xsl:value-of select="cei:sigil|@n"/><xsl:text>)</xsl:text>
					</xsl:if>
					<p>
					<xsl:for-each select="cei:figure">
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="cei:graphic/@url">
								<a><xsl:attribute name="href"><xsl:value-of select="cei:graphic/@url"/></xsl:attribute>Scan<xsl:if test="cei:figDesc">
									<xsl:text> </xsl:text><xsl:value-of select="cei:figDesc"/>
								</xsl:if>
								</a>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="cei:figDesc"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					</p>
					<xsl:if test="cei:auth">
						<p>Beglaubigung: <xsl:apply-templates select="cei:auth"/></p>
					</xsl:if>
					<xsl:if test="cei:nota">
						<p>Vermerke: <xsl:apply-templates select="cei:nota"/></p>
					</xsl:if>
					<xsl:apply-templates select="cei:physicalDesc"/>
					</li>
				</xsl:for-each>
			</ul>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
