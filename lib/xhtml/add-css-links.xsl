<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<!-- ====================================================================== 
     add-css-links.xsl                                                   

     This stylesheet defines a single template for adding one or more CSS
     <link> element based on user-defined parameters.

     Version : 1.0
     Date    : $Date: 2003/04/20 03:39:15 $

     Copyright (c) 2003 Aaron Straup Cope
     http://www.aaronland.info/xsl/xhtml/add-css-links/

     Permission to use, copy, modify and distribute this stylesheet and its 
     accompanying documentation for any purpose and without fee is hereby 
     granted in perpetuity, provided that the above copyright notice and 
     this paragraph appear in all copies.  The copyright holders make no 
     representation about the suitability of the stylesheet for any purpose.

     It is provided "as is" without expressed or implied warranty.

     ====================================================================== -->

    <xsl:param name = "css_screen" />
    <xsl:param name = "css_tty" />
    <xsl:param name = "css_tv" />
    <xsl:param name = "css_projection" />
    <xsl:param name = "css_handheld" />
    <xsl:param name = "css_print" />
    <xsl:param name = "css_braille" />
    <xsl:param name = "css_aural" />
    <xsl:param name = "css_all" />
    <xsl:param name = "lang" />

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template name = "Add_CSS_Links">
    
        <xsl:if test = "$css_all">
         <link>
          <xsl:attribute name = "rel">stylesheet</xsl:attribute>
          <xsl:attribute name = "type">text/css</xsl:attribute>
          <xsl:attribute name = "href"><xsl:value-of select = "substring-before($css_all,' ')" /></xsl:attribute>
          <xsl:attribute name = "media">all</xsl:attribute>
          <xsl:attribute name = "title"><xsl:value-of select = "substring-after($css_all,' ')" /></xsl:attribute>
         </link>
        </xsl:if>

        <xsl:if test = "$css_tty">
         <link>
          <xsl:attribute name = "rel">stylesheet</xsl:attribute>
          <xsl:attribute name = "type">text/css</xsl:attribute>
          <xsl:attribute name = "href"><xsl:value-of select = "substring-before($css_tty,' ')" /></xsl:attribute>
          <xsl:attribute name = "media">tty</xsl:attribute>
          <xsl:attribute name = "title"><xsl:value-of select = "substring-after($css_tty,' ')" /></xsl:attribute>
         </link>
        </xsl:if>

        <xsl:if test = "$css_tv">
         <link>
          <xsl:attribute name = "rel">stylesheet</xsl:attribute>
          <xsl:attribute name = "type">text/css</xsl:attribute>
          <xsl:attribute name = "href"><xsl:value-of select = "substring-before($css_tv,' ')" /></xsl:attribute>
          <xsl:attribute name = "media">tv</xsl:attribute>
          <xsl:attribute name = "title"><xsl:value-of select = "substring-after($css_tv,' ')" /></xsl:attribute>
         </link>
        </xsl:if>

        <xsl:if test = "$css_projection">
         <link>
          <xsl:attribute name = "rel">stylesheet</xsl:attribute>
          <xsl:attribute name = "type">text/css</xsl:attribute>
          <xsl:attribute name = "href"><xsl:value-of select = "substring-before($css_projection,' ')" /></xsl:attribute>
          <xsl:attribute name = "media">projection</xsl:attribute>
          <xsl:attribute name = "title"><xsl:value-of select = "substring-after($css_projection,' ')" /></xsl:attribute>
         </link>
        </xsl:if>

        <xsl:if test = "$css_braille">
         <link>
          <xsl:attribute name = "rel">stylesheet</xsl:attribute>
          <xsl:attribute name = "type">text/css</xsl:attribute>
          <xsl:attribute name = "href"><xsl:value-of select = "substring-before($css_braille,' ')" /></xsl:attribute>
          <xsl:attribute name = "media">braille</xsl:attribute>
          <xsl:attribute name = "title"><xsl:value-of select = "substring-after($css_braille,' ')" /></xsl:attribute>
         </link>
        </xsl:if>

        <xsl:if test = "$css_aural">
         <link>
          <xsl:attribute name = "rel">stylesheet</xsl:attribute>
          <xsl:attribute name = "type">text/css</xsl:attribute>
          <xsl:attribute name = "href"><xsl:value-of select = "substring-before($css_aural,' ')" /></xsl:attribute>
          <xsl:attribute name = "media">aural</xsl:attribute>
          <xsl:attribute name = "title"><xsl:value-of select = "substring-after($css_aural,' ')" /></xsl:attribute>
         </link>
        </xsl:if>

        <xsl:if test = "$css_screen">
         <link>
          <xsl:attribute name = "rel">stylesheet</xsl:attribute>
          <xsl:attribute name = "type">text/css</xsl:attribute>
          <xsl:attribute name = "href"><xsl:value-of select = "substring-before($css_screen,' ')" /></xsl:attribute>
          <xsl:attribute name = "media">screen</xsl:attribute>
          <xsl:attribute name = "title"><xsl:value-of select = "substring-after($css_screen,' ')" /></xsl:attribute>
         </link>
        </xsl:if>

        <xsl:if test = "$css_print">
         <link>
          <xsl:attribute name = "rel">stylesheet</xsl:attribute>
          <xsl:attribute name = "type">text/css</xsl:attribute>
          <xsl:attribute name = "href"><xsl:value-of select = "substring-before($css_print,' ')" /></xsl:attribute>
          <xsl:attribute name = "media">print</xsl:attribute>
          <xsl:attribute name = "title"><xsl:value-of select = "substring-after($css_print,' ')" /></xsl:attribute>
         </link>
        </xsl:if>

        <xsl:if test = "$css_handheld">
         <link>
          <xsl:attribute name = "rel">stylesheet</xsl:attribute>
          <xsl:attribute name = "type">text/css</xsl:attribute>
          <xsl:attribute name = "href"><xsl:value-of select = "substring-before($css_handheld,' ')" /></xsl:attribute>
          <xsl:attribute name = "media">handheld</xsl:attribute>
          <xsl:attribute name = "title"><xsl:value-of select = "substring-after($css_handheld,' ')" /></xsl:attribute>
         </link>
        </xsl:if>
  </xsl:template>

<!-- ====================================================================== 
     FIN // $Id: add-css-links.xsl,v 1.2 2003/04/20 03:39:15 asc Exp $
     ====================================================================== -->

</xsl:stylesheet>
