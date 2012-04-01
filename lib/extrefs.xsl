<?xml version="1.0" encoding="utf-8"?>

<!-- ====================================================================== 
     extrefs.xsl

     Templates for adding handling external links in the stylesheets used to
     extends the XML Resume Library formatting stylesheets.

     Version : 0.2
     Date    : $Date: 2004/10/26 13:33:06 $

     Copyright (c) 2003-2004 Aaron Straup Cope.
     All Rights Reserved.

     http://www.aaronland.info/xsl/xmlresume/
     http://xmlresume.sourceforge.net/

     ====================================================================== 
     
     Redistribution and use in source and binary forms, with or without
     modification, are permitted provided that the following conditions are
     met:
     
     1. Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
     2. Redistributions in binary form must reproduce the above copyright
        notice, this list of conditions and the following disclaimer in the
        documentation and/or other materials provided with the
        distribution.
     
     THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
     ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
     IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
     PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS
     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
     BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
     WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
     OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
     IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

     ====================================================================== -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:include href = "./string/print-n-times.xsl" />

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:key name = "extrefs"  match = "//*[@href]"  use = "@href" />

<!-- ====================================================================== 

     ====================================================================== -->

     <!-- Having trouble doing an accurate count on keys... -->
     <xsl:variable name = "cc" select = "string-length(count(//*[@href]))" />

<!-- ====================================================================== 
				   
     ====================================================================== -->

  <xsl:template name = "ExtrefPos">
    <xsl:variable name = "href" select = "@href" />
    <xsl:for-each select = "//*[@href][count(.|key('extrefs', @href)[1]) = 1]">
      <xsl:if test = "$href = @href">
        <!--<xsl:variable name = "spacer">
        <xsl:call-template name = "Spacer" />
       </xsl:variable>
       <xsl:value-of select = "$spacer" />-->
       [<xsl:value-of select = "position()" />]
    </xsl:if>
    </xsl:for-each>
  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

 <xsl:template name = "Spacer">
      <xsl:variable name = "p" select = "string-length(position())" />

      <xsl:variable name = "spacer">
       <xsl:choose>
        <xsl:when test = "number($cc - $p) > 0">
         <xsl:call-template name = "PrintNTimes">
	  <xsl:with-param name = "string"><xsl:text> </xsl:text></xsl:with-param>
	  <xsl:with-param name = "count">
           <xsl:value-of select = "number($cc - $p)" />
          </xsl:with-param>
	 </xsl:call-template>
	</xsl:when>
        <xsl:otherwise />
       </xsl:choose>
      </xsl:variable>

      <xsl:value-of select = "$spacer" />
     </xsl:template>

<!-- ====================================================================== 

     FIN // $Id: extrefs.xsl,v 1.5 2004/10/26 13:33:06 asc Exp $
     ====================================================================== -->

</xsl:stylesheet>
