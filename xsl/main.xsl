<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
	xmlns:cei="http://www.monasterium.net/NS/cei"
	exclude-result-prefixes="cei">
<xsl:output method="html" encoding="utf-8" media-type="text/html"/>

<xsl:include href="general.xsl"/>
<xsl:include href="notes.xsl"/>
<xsl:include href="cei_MOM.xsl"/>

<xsl:template match="/">
  <html>
  <head>	
			<title><xsl:value-of select="/cei:cei/cei:teiHeader/cei:fileDesc/cei:sourceDesc/cei:bibl|cei:cei/cei:teiHeader/cei:fileDesc/cei:titleStmt"/></title>
			<link rel="stylesheet" type="text/css" href="cei.css"/>
			<!-- <link rel="stylesheet" type="text/css" href="http://pcghw51.geschichte.uni-muenchen.de/UrkDTD/css/cei.css"/>-->
  </head>
  
  <body>
  <a name="top" />
<!-- Die Urkunde -->
	<xsl:if test="//cei:text[@type='charter']">		<a name="h1"></a>
		<xsl:choose>
			<xsl:when test="//cei:group">
				<xsl:for-each select="//cei:group">
					<xsl:call-template name="Urkunden"/>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="Urkunden"/>
			</xsl:otherwise>
		</xsl:choose>
<!-- Indexeinträge --> 
      <hr/>
	  <a name="h2"></a>
      <h2>Indexeinträge</h2>

	<a name="Allgemein"></a>
	<h3>Sachen</h3>
	<ul class="Index">
		<xsl:for-each select="//cei:index">
		  <xsl:sort select="./@lemma"/>
		  <xsl:choose>
			  <xsl:when test="not(preceding::cei:index/@lemma=./@lemma)">
				    <li><xsl:value-of select="./@lemma" /></li>
			  </xsl:when>
			  <xsl:otherwise>
				  <xsl:choose>
					  <xsl:when test="./@sublemma">
						  <xsl:if test="not(preceding::cei:index/@sublemma=./@sublemma)">
								<li>-- <xsl:value-of select="./@sublemma" /></li>
							</xsl:if>
					  </xsl:when>
					  <xsl:otherwise>,</xsl:otherwise>
				 </xsl:choose>
			  </xsl:otherwise>
		 </xsl:choose>
		</xsl:for-each>
	</ul>

    <hr/>
    <p class="backlink"><a href="#top">Zum Seitenanfang</a></p>
	<hr/>
	
	<a name="Personen"></a>
	<h3>Personen</h3>
	<ul>
		<xsl:for-each select="//cei:persName|//cei:index[@indexName='Person']"> <!-- Wie kann ich hier auch gleichzeitig die Indexeinträge mit indexName="Person" abfangen?-->
		  <xsl:sort select="./@reg|./@lemma"/>
		  <li><xsl:value-of select="./@reg|./@lemma"/><xsl:text> </xsl:text>
		  </li>
		</xsl:for-each>
	</ul>

    <hr/>
    <p class="backlink"><a href="#top">Zum Seitenanfang</a></p>
	<hr/>
	
	<a name="Orte"></a>
	<h3>Orte</h3>
	<!--  unterscheiden nach Typ? -->
	<ul>
		<xsl:for-each select="//cei:placeName">
		  <xsl:sort select="."/>
		  <li>
		  <xsl:choose>
		  	<xsl:when test="ancestor::cei:tenor|ancestor::cei:back">
			<span class="foreign"><xsl:value-of select="."/></span><xsl:text> </xsl:text>
				  <xsl:if test="./@reg">
					(<xsl:value-of select="./@reg" />)
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/><xsl:text> </xsl:text>
				<xsl:if test="./@reg">
					(<xsl:value-of select="./@reg" />)
				</xsl:if>
			</xsl:otherwise>
		  </xsl:choose>
		  </li>
		</xsl:for-each>
	</ul>

      <hr/>
      <p class="backlink"><a href="#top">Zum Seitenanfang</a></p>
      <hr/>
</xsl:if>
  </body>
  </html>
</xsl:template>

<xsl:template name="Urkunden">
<!-- Die Urkundentexte -->
    <!-- Hier noch ein Inhaltsverzeichnis, das jede 10. Nummer als Sprungpunkt definiert, davor? -->
		<a><xsl:attribute name="name"><xsl:value-of select="@n"/></xsl:attribute></a>
		<h3><xsl:value-of select="cei:h1"/></h3>
		<xsl:for-each select=".//cei:text[@type='charter']">
			<hr/>
		   <p class="idno"><b><a>
			   <xsl:attribute name="name">
				   <xsl:value-of select=".//cei:idno"/>
			   </xsl:attribute>
			   <xsl:value-of select=".//cei:idno"/>
		   </a></b></p>
		   <xsl:apply-templates select=".//cei:chDesc"/>
		   <br/>
		   <xsl:apply-templates select=".//cei:tenor"/>
		   <div class="fussbereich">
		   <!-- Fußnoten -->
			<xsl:if test=".//cei:note">
				<hr/>
					<xsl:for-each select=".//cei:note">
						<xsl:apply-templates select="."/>
					</xsl:for-each>
			</xsl:if>
			<xsl:if test="cei:front/cei:sourceDesc">
				<hr/>
				<p class="Vorlagen">Vorlagen
					<ul>
						<xsl:if test="cei:front/cei:sourceDesc/cei:sourceDescVolltext/cei:bibl">
							<li>für den Volltext: <xsl:value-of select="cei:front/cei:sourceDesc/cei:sourceDescVolltext/cei:bibl"/></li>
						</xsl:if>
						<xsl:if test="cei:front/cei:sourceDesc/cei:sourceDescRegest/cei:bibl">
							<li>für das Regest: <xsl:value-of select="cei:front/cei:sourceDesc/cei:sourceDescRegest/cei:bibl"/></li>
						</xsl:if>
					</ul>
				</p>
			</xsl:if>
			</div>
		  <hr/>
		  <p class="backlink"><a href="#top">Zum Seitenanfang</a></p>
		  </xsl:for-each>
</xsl:template>

<xsl:template match="cei:chDesc">
	<div class="Regest">
	<xsl:apply-templates select="cei:abstract"/>
	<p class="Datierung">
		<xsl:apply-templates select="cei:date|cei:issued/cei:date|cei:dateRange|cei:issued/cei:dateRange"/>	<xsl:if test="./cei:issuePlace|./cei:issued/cei:placeName">
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
		<p>Überlieferung(en): </p>
		<xsl:apply-templates select="cei:witnessOrig"/>
		<xsl:apply-templates select="cei:witListPar"/>
		<xsl:apply-templates select="cei:diplomaticAnalysis"/>
		<xsl:apply-templates select="cei:lang_MOM" />
	</div>
</xsl:template>

</xsl:stylesheet>
