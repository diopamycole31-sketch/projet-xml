<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>
<xsl:param name="seuil" select="10"/>
<xsl:key name="par-classe" match="etudiant" use="@classe"/>
<xsl:template match="/">
<html>
<head>
<title>Etudiants par classe</title>
<link rel="stylesheet" type="text/css" href="style.css"/>
</head>
<body>
<h1>Promotion 2026-2027 - Licence 1</h1>
<xsl:for-each select="promotion/etudiant[generate-id() = generate-id(key('par-classe', @classe)[1])]">
<xsl:sort select="@classe"/>
<xsl:variable name="maClasse" select="@classe"/>
<xsl:variable name="eleves" select="key('par-classe', $maClasse)"/>
<h2>Classe <xsl:value-of select="$maClasse"/> - <xsl:value-of select="count($eleves)"/> étudiants</h2>
<table border="1">
<tr><th>Rang</th><th>Nom</th><th>Prénom</th><th>Email</th><th>Moyenne</th><th>Résultat</th></tr>
<xsl:for-each select="$eleves">
<xsl:sort select="sum(notes/note) div count(notes/note)" data-type="number" order="descending"/>
<xsl:variable name="moy" select="sum(notes/note) div count(notes/note)"/>
<tr>
<xsl:if test="position() = 1">
<xsl:attribute name="class">major</xsl:attribute>
</xsl:if>
<td><xsl:value-of select="position()"/></td>
<td><xsl:value-of select="nom"/></td>
<td><xsl:value-of select="prenom"/></td>
<td><a href="mailto:{email}"><xsl:value-of select="email"/></a></td>
<td><xsl:value-of select="format-number($moy, '0.00')"/></td>
<td><xsl:choose><xsl:when test="$moy >= $seuil"><span class="badge reussite">Admis</span></xsl:when><xsl:otherwise><span class="badge echec">À revoir</span></xsl:otherwise></xsl:choose></td>
</tr>
</xsl:for-each>
</table>
</xsl:for-each>
</body>
</html>
</xsl:template>
</xsl:stylesheet>