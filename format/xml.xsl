<?xml version="1.0" encoding="utf-8"?>

<!-- ====================================================================== 
     xml.xsl

     Provides the ability to regenerate a source Resume XML document while
     excluding certain elements (references or personal address, for instance.)

     Version : 0.2
     Date    : $Date: 2004/02/22 05:19:38 $

     Copyright (c) 2003-2004 Aaron Straup Cope.
     All Rights Reserved.

     http://www.aaronland.info/xsl/xmlresume/
     http://xmlresume.sourceforge.net/

     ====================================================================== 
  
     Copyright (c) 2003-2004 Aaron Straup Cope.
     All rights reserved.
     
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
  
<xsl:stylesheet xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
                xmlns:r   = "http://xmlresume.sourceforge.net/resume/0.0" 
                exclude-result-prefixes = "r"
                version="1.0">

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:output method = "xml" />
     <xsl:output indent = "yes" />
     <xsl:output encoding = "UTF-8" />
     <xsl:output doctype-public = "-//Sean Kelly//DTD Resume 1.5.1//EN" />
     <xsl:output doctype-system = "http://xmlresume.sourceforge.net/dtd/resume.dtd" />

<!-- ====================================================================== 

     Note: This stylesheet doesn't try to accomodate documents with
     customized DOCTYPES or ENTITY declarations; it just gets too
     hairy too fast in any kind of abstract, generalized context. It
     is 'possible' and if you're in to this kind of thing, you should
     consult:

     http://www.dpawson.co.uk/xsl/sect2/N2281.html#d2791e181
     ====================================================================== -->

     <xsl:strip-space elements="*"/>

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:include href = "../lib/resume/xsl/params.xsl" />
     <xsl:include href = "../lib/params.xsl" />

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:template match="/">
      <xsl:apply-templates />
     </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:template match = "*">
      <xsl:copy>
       <xsl:apply-templates />
      </xsl:copy>
     </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:template match = "r:link">
      <r:link>
       <xsl:attribute name = "href">
        <xsl:value-of select = "@href" />
       </xsl:attribute>
       <xsl:value-of select = "." />
      </r:link>
     </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:template match = "r:birth">
      <xsl:if test = "$header.birth.display">
       <xsl:copy>
        <xsl:apply-templates />
       </xsl:copy>
      </xsl:if> 
     </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:template match = "r:header/r:address">
      <xsl:if test = "$header.address.display">
       <xsl:copy>
        <xsl:apply-templates />
       </xsl:copy>
      </xsl:if> 
     </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:template match = "r:header/r:contact/r:phone">
      <xsl:if test = "$header.phone.display">
       <xsl:copy>
        <xsl:apply-templates />
       </xsl:copy>
      </xsl:if>
     </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:template match = "r:referees">
      <xsl:choose>
       <xsl:when test = "$referees.display">
        <xsl:copy>
         <xsl:apply-templates />
        </xsl:copy>
       </xsl:when>
       <xsl:otherwise>
        <r:referees>
         <xsl:comment>Available upon request.</xsl:comment>
	</r:referees>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:template>

<!-- ====================================================================== 
     FIN // $Id: xml.xsl,v 1.6 2004/02/22 05:19:38 asc Exp $
     ====================================================================== -->

</xsl:stylesheet>
