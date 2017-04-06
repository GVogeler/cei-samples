<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cei="http://www.monasterium.net/NS/cei"
	exclude-result-prefixes="cei">
<xsl:output method="html" encoding="utf-8" media-type="text/html"/>

<!-- Allgemeine Elemente -->
<xsl:template match="cei:front">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="cei:body">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="cei:back">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="cei:h1">
	<h1><xsl:value-of select="."/></h1>
</xsl:template>

<xsl:template match="cei:h2">
	<h2><xsl:value-of select="."/></h2>
</xsl:template>

<xsl:template match="cei:p">
	<p><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="cei:quote">
	<xsl:choose>
	<xsl:when test="ancestor::cei:tenor">
			<span class="Vorurkunde" title="Text aus Vorurkunde übernommen"><xsl:apply-templates/></span>
	</xsl:when>
	<xsl:when test="./@type='Originaldatierung' or name()='quoteOriginaldatierung'"><p>Originaldatierung: <span class="foreign"><xsl:apply-templates/></span></p></xsl:when>
	<xsl:otherwise>
		<xsl:text>"</xsl:text><span class="zitiert"><xsl:apply-templates/></span><xsl:text>"</xsl:text>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="cei:gap">
	<xsl:if test="ancestor::cei:quote">
	<!-- eine echte Transkriptionslücke wäre noch gesondert zu definieren. -->
		<span title="Hier ist Text aus der Vorurkunde nicht übernommen worden."><xsl:text>*</xsl:text></span>
	</xsl:if>
</xsl:template>

<xsl:template match="cei:pict">
	<xsl:choose>
		<!-- Verweis auf Graphik als erstes überprüfen -->
		<xsl:when test="@URL">
			<img><xsl:attribute name="src"><xsl:value-of select="@URL"/></xsl:attribute><xsl:attribute name="alt"><xsl:value-of select="@type"/></xsl:attribute></img>
		</xsl:when>
		<xsl:otherwise>
		<!-- Sonst eine Zeichenreferenz -->
				<xsl:element name="span">
					<xsl:attribute name="class">zeichenreferenz</xsl:attribute>
					<xsl:attribute name="title"><xsl:value-of select="@type"/></xsl:attribute>
					<xsl:choose>
					<xsl:when test="@type='Chrismon' or @type='(C.)'">
						(C.)
					</xsl:when>
					<xsl:when test="@type='Monogramm' or @type='(M.)'">
						(M.)
					</xsl:when>
					<xsl:when test="@type='Signum recognitionis'">
						(S.R.)
					</xsl:when>
					<xsl:when test="@type='Signum speciale'">
						(S.S.)
					</xsl:when>
				</xsl:choose>
				</xsl:element>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>

<xsl:template match="cei:hi">
	<xsl:choose>
		<xsl:when test="./@rend='Elongata'">
			<span class="Elongata">
				<span class="paratext" title="Beginn Elongata">|3x|</span>
				<xsl:apply-templates />
				<span class="paratext" title="Ende Elongata">|3x|</span>
			</span>
		</xsl:when>
		<xsl:otherwise>
			<xsl:element name="span">
				<xsl:attribute name="class"><xsl:value-of select="./@rend"/></xsl:attribute>
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="cei:c">
	<span style="color:grey;"><xsl:attribute name="title"><xsl:value-of select="@type"/></xsl:attribute><xsl:apply-templates/></span>
</xsl:template>

<!--Listen -->
<xsl:template match="cei:list">
	<ul>
		<xsl:for-each select="./cei:item">
			<li><xsl:apply-templates/></li>
		</xsl:for-each>
	</ul>
</xsl:template>

<xsl:template match="cei:listBibl">
	<p class="listBibl"><xsl:value-of select="."/></p>
	<!-- Die bibliographische Liste wäre eigentlich anders darzustellen, z.B. gekennzeichnet, um welche Art von Liste es sich handelt, innere Verweise darstellend etc.-->
</xsl:template>

<xsl:template match="cei:back//cei:listBibl">
	<ul>
		<xsl:for-each select="cei:bibl">
		<li><xsl:value-of select="."/></li>
		</xsl:for-each>
	</ul>
</xsl:template>


<!--CEI-Spezifische Elemente -->
<!-- Zunächst die einzelnen Subelemente: -->

<xsl:template match="cei:chDesc">
	<div class="Regest">
	<xsl:apply-templates select="cei:abstract"/>
	<p class="Datierung">
		<xsl:apply-templates select="cei:date|cei:issued/cei:date|cei:dateRange|cei:issued/cei:dateRange"/>	<xsl:if test="./issuePlace|./issued/placeName">
		<xsl:choose>
				<xsl:when test="starts-with(./cei:issuePlace,',') or starts-with(./cei:issued/cei:placeName,',')"/>
				<xsl:otherwise>
						<xsl:text>, </xsl:text>
				</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="./cei:issuePlace|./cei:issued/cei:placeName"/>
		</xsl:if>
	</p>
	</div>
	<div class="Vorspann">
		<xsl:apply-templates select="cei:witList"/>
		<xsl:apply-templates select="cei:diplomaticAnalysis"/>
	</div>
</xsl:template>

<!--
<xsl:template match="sealDesc">
	<span style="color:#ff0000;">
		<xsl:apply-templates/>
	</span>
</xsl:template>
-->

<xsl:template match="cei:date">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template name="Ausstellungsort">
<!-- diese nur beannten templates kriege ich noch nicht einem bestimmten Knoten zugewiesen ... -->
	Aktuelles Element: <xsl:value-of select="name(.)"/>
		<xsl:choose>
		<xsl:when test="./cei:issuePlace">
			Ort: <xsl:value-of select="./cei:issuePlace"/>
		</xsl:when>
		<xsl:when test="./cei:issued/cei:placeName">
			 /Ort: <xsl:value-of select="./cei:issued/cei:placeName"/>
		</xsl:when>
	</xsl:choose>
</xsl:template>


<xsl:template match="cei:abstract">
	<p><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="cei:witList">
	<div class="Vorspann" style="margin-top:6px;">
	<xsl:if test="./text()">
		<p><xsl:value-of select="./text()"/></p>
	</xsl:if>
	<xsl:if test="cei:witness">
		<p>Überlieferung(en): </p>
			<ul>
				<xsl:for-each select="cei:witness">
					<li style="margin-top:3px;margin-bottom:3px;">
					<xsl:value-of select="cei:traditioForm/text()"/><xsl:text> </xsl:text>
					<xsl:apply-templates select="cei:archIdentifier|cei:msIdentifier"/>
					<xsl:if test="cei:sigil">
						<xsl:text> (</xsl:text><xsl:value-of select="cei:sigil"/><xsl:text>)</xsl:text>
					</xsl:if>
					<p>
					<xsl:for-each select="cei:figure">
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="cei:graphic/@url">
								<a><xsl:attribute name="href"><xsl:value-of select="cei:graphic/@url"/></xsl:attribute>Scan<xsl:if test="figDesc">
									<xsl:text> </xsl:text><xsl:value-of select="cei:figDesc"/>
								</xsl:if>
								</a>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="figDesc"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					</p>
					<xsl:if test="cei:auth">
						<p>Beglaubigung: <xsl:apply-templates select="cei:auth"/></p>
					</xsl:if>
					<xsl:if test="cei:nota">
						<p class="Vermerke">Vermerke: <xsl:apply-templates select="cei:nota"/></p>
					</xsl:if>
					<xsl:apply-templates select="cei:physicalDesc"/>
					</li>
				</xsl:for-each>
			</ul>
	</xsl:if>
	</div>
</xsl:template>

<xsl:template match="cei:physicalDesc">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="cei:dimensions">
	<p class="masse">Maße: <xsl:apply-templates	/></p>
</xsl:template>

<xsl:template match="cei:auth">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="cei:nota">
	<xsl:if test="./@place">
		<xsl:value-of select="./@place" />: 
	</xsl:if>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="cei:archIdentifier|cei:msIdentifier">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="cei:diplomaticAnalysis">
	<div class="diplomatischerKommentar"><xsl:apply-templates/></div>
</xsl:template>

<xsl:template match="cei:tenor">
	<div class="tenor">
		<xsl:apply-templates/>
	</div>
	<div class="footnote">
		<xsl:for-each select=".//cei:note">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</div>
</xsl:template>

<xsl:template match="cei:traditioForm">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="cei:witness">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="cei:availability">
	<p class="Verfuegbarkeit">Hinweis zu Benutzung:<xsl:value-of select="."/></p>
</xsl:template>

<!-- Die weiteren Bestandteile des Vorspanns harren noch der schöneren Gestaltung -->
<xsl:template match="cei:legend">
		<span class="legend">
			<xsl:value-of select="."/>
		</span>
</xsl:template>

<xsl:template name="Einleitungstext">
    <p>Die Urkunden sind den vorläufigen Regeln der <a href="http://www.cei.lmu.de" class="extern">Charters Encoding Initiative</a> entsprechend gegliedert. Für die Inhalte ist jedoch alleine der Autor verantwortlich.</p>
</xsl:template>

<xsl:template match="cei:material">
	<xsl:choose>
		<xsl:when test="ancestor::cei:sealDesc">Siegelstoff: <xsl:value-of select="."/></xsl:when>
		<xsl:otherwise><p class="Beschreibstoff">Beschreibstoff: <xsl:value-of select="."/></p></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--Allgemeine Templates-->

<xsl:template match="cei:sup">
	<sup><xsl:value-of select="."/></sup>
</xsl:template>

<xsl:template match="cei:lb">
	<br/>
</xsl:template>

<xsl:template match="cei:abstract/text()|cei:witness/text()|cei:witnessOrig/text()|cei:diplomaticAnalysis/text()|cei:witList/text()|cei:tenor/text()|cei:item/text()|cei:h1/text()|cei:h2/text()|cei:p/text()|cei:witList/text()|cei:hi/text()|cei:c/text()|cei:quote/text()|cei:note/text()">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="cei:recipient">
	<span class="Empfaenger"><xsl:value-of select="."/></span>
</xsl:template>

<xsl:template match="cei:issuer">
	<span class="Aussteller"><xsl:value-of select="."/></span>
</xsl:template>


<xsl:template match="cei:foreign">
	<!-- ich brauche hier einen Wechsel ...-->
	<xsl:if test="@lang='lat'">
		<span class="foreign">
			<xsl:value-of select="."/>
		</span>
	</xsl:if>
</xsl:template>

<xsl:template match="cei:bibl">
	<span class="bibl"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="cei:expan">
	<span class="abbr"><xsl:attribute name="title"><xsl:value-of select="./@abbr"/></xsl:attribute><xsl:value-of select="."/></span>
</xsl:template>

<xsl:template match="cei:abbr">
	<span class="abbr"><xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute><xsl:value-of select="./@expan"/></span>
</xsl:template>

<xsl:template match="cei:persName|cei:placeName">
	<span><xsl:attribute name="class"><xsl:value-of select="name()"/></xsl:attribute><xsl:attribute name="title"><xsl:value-of select="./@reg"/></xsl:attribute><xsl:value-of select="."/></span>
</xsl:template>

<xsl:template match="cei:index">
	<span class="index"><xsl:attribute name="title"><xsl:value-of select="./cei:lemma"/></xsl:attribute><xsl:value-of select="."/></span>
</xsl:template>

</xsl:stylesheet>
