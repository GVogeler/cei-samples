<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cei="http://www.monasterium.net/NS/cei"
	exclude-result-prefixes="cei">
	
<xsl:output method="html" encoding="utf-8" media-type="text/html"/>
<!-- Fußnoten-->

<!-- Das funktioniert noch nicht so richtig:
1. Unterscheidung textkritsche und Sachanmerkungen über?
2. Fußnoten getrennt vom eigentlichen Text, wie?
-->
<xsl:template match="cei:note">
	<p class="footnote">
		<a>
			<xsl:attribute name="name">
				<xsl:text>FN</xsl:text>	
				<xsl:value-of select="ancestor::cei:text[@type='charter']//cei:idno"/>
				<xsl:text>_</xsl:text>
				<xsl:value-of select="@n"/>
			</xsl:attribute>
		</a>
		<sup class="fussnotenzeichen">
		<a>
			<xsl:attribute name="href">
				<xsl:text>#FN</xsl:text>
				<xsl:value-of select="ancestor::cei:text[@type='charter']//cei:idno"/>
				<xsl:text>_</xsl:text>
				<xsl:value-of select="@n"/>
				<xsl:text>q</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="@n"/>
		</a>
		</sup>
		<span class="Fussnotentext">
			<xsl:apply-templates/>
		</span>
	</p>
</xsl:template>	  

<!-- Fußnotenreferenzen auf Text, der außerhalb des eigentlichen Textes steht ... -->
<xsl:template match="cei:ref">
		<a>
			<xsl:attribute name="name">
				<xsl:text>FN</xsl:text>	
				<xsl:value-of select="ancestor::cei:text[@type='charter']//cei:idno"/>
				<xsl:text>_</xsl:text>
				<xsl:value-of select="."/>
				<xsl:text>q</xsl:text>
			</xsl:attribute>
		</a>
		<sup>
		<a>
			<xsl:attribute name="href">
				<xsl:text>#FN</xsl:text>
				<xsl:value-of select="ancestor::cei:text[@type='charter']//cei:idno"/>
				<xsl:text>_</xsl:text>
				<xsl:value-of select="."/>
			</xsl:attribute>
			<xsl:value-of select="."/>
		</a>
	</sup>
</xsl:template>


</xsl:stylesheet>

