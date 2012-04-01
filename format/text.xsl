<?xml version="1.0" encoding="UTF-8"?>

<!-- ====================================================================== 
     text.xsl

     Extends the XML Resume Library text.xsl stylesheet for transforming XML
     resume documents into plain text.

     Version : 0.4
     Date    : $Date: 2004/02/22 03:58:56 $

     Copyright (c) 2003-2004 Aaron Straup Cope.
     All Rights Reserved.

     http://www.aaronland.info/xsl/xmlresume/
     http://xmlresume.sourceforge.net/

     ====================================================================== 

     Copyright (c) 2000-2002 by Vlad Korolev, Sean Kelly, 
      and Bruce Christensen
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

<xsl:stylesheet version="1.0"
    xmlns:r="http://xmlresume.sourceforge.net/resume/0.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:include href = "../lib/resume/xsl/format/text.xsl" />
  <xsl:include href = "../lib/extrefs.xsl" />
  <xsl:include href = "../lib/params.xsl" />

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template match="/">
   <xsl:apply-templates select="r:resume/child::node()[name() != 'lastModified']"/>
   <xsl:call-template name = "NewLine"/>
   <xsl:call-template name = "Extrefs" />
   <xsl:call-template name = "NewLine"/>
   <xsl:apply-templates select = "r:resume/r:lastModified" />
  </xsl:template>

 <xsl:template match="r:header" mode="centered">
    <xsl:call-template name="Center">
      <xsl:with-param name="Text">
        <xsl:apply-templates select="r:name"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="NewLine"/>

<!-- ====================================================================== 

     ====================================================================== -->

    <xsl:call-template name="CenterBlock">
      <xsl:with-param name="Text">
        <xsl:if test="r:address">
          <xsl:call-template name="NewLine"/>
          <xsl:if test = "$header.address.display"><xsl:apply-templates select="r:address"/></xsl:if>
        </xsl:if>
        <xsl:if test="r:contact">
          <xsl:call-template name="NewLine"/>
          <xsl:apply-templates select="r:contact"/>
        </xsl:if>
      </xsl:with-param>
    </xsl:call-template>

  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template match="r:header" mode="standard">
    <!-- Your name, address, and stuff. -->
    <xsl:call-template name="Center">
      <xsl:with-param name="Text">
        <xsl:apply-templates select="r:name"/>
        <xsl:text> - </xsl:text>
        <xsl:value-of select="$resume.word"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="NewLine"/>

    <xsl:call-template name="Heading">
      <xsl:with-param name="Text" select="$contact.word"/>
    </xsl:call-template>

    <xsl:apply-templates select="r:name"/><xsl:call-template name="NewLine"/>
    <xsl:if test = "$header.address.display"><xsl:apply-templates select="r:address"/></xsl:if>

    <xsl:call-template name="NewLine"/>

    <xsl:apply-templates select="r:contact"/>
  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template match="r:header/r:contact/r:phone">
   <xsl:if test = "$header.phone.display">
    <xsl:call-template name="PhoneLocation">
      <xsl:with-param name="Location" select="@location"/>
    </xsl:call-template>
    <xsl:text>: </xsl:text>
    <xsl:apply-templates/>
    <xsl:call-template name="NewLine"/>
   </xsl:if>
  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template match="r:activities">
    <xsl:call-template name="Heading">
      <xsl:with-param name="Text" select="$activities.word"/>
    </xsl:call-template>

    <xsl:call-template name="Indent">
      <xsl:with-param name="Text">
        <xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template match="r:activity">
    <xsl:apply-templates select="r:title"/>
    <xsl:call-template name="NewLine"/>
    <xsl:apply-templates select="r:date|r:period"/>

    <xsl:if test="r:description">
      <xsl:call-template name="NewLine"/>
      <xsl:apply-templates select="r:description"/>
    </xsl:if>

    <xsl:if test="r:projects">
      <xsl:call-template name="NewLine"/>
      <xsl:apply-templates select="r:projects"/>
    </xsl:if>

    <xsl:if test="following-sibling::*">
      <xsl:call-template name="NewLine"/>
      <xsl:call-template name="NewLine"/>
    </xsl:if>

  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template match="r:link">
   <xsl:value-of select="."/>
   <xsl:text> </xsl:text>
   <xsl:call-template name = "ExtrefPos" />
  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template name = "Extrefs">
    <xsl:call-template name="Heading">
      <xsl:with-param name="Text" select = "$extrefs.word" />
    </xsl:call-template>

    <xsl:for-each select = "//*[@href][count(.|key('extrefs', @href)[1]) = 1]">

      <xsl:variable name = "spacer">
       <xsl:call-template name = "Spacer" />
      </xsl:variable>

      <xsl:call-template name="Indent">
       <xsl:with-param name="Text"><xsl:value-of select = "$spacer" /><xsl:value-of select = "position()" /><xsl:text>.  </xsl:text><xsl:value-of select = "@href" /></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="NewLine"/>
    </xsl:for-each>
  </xsl:template>

<!-- ====================================================================== 

     FIN // $Id: text.xsl,v 1.11 2004/02/22 03:58:56 asc Exp $
     ====================================================================== -->

</xsl:stylesheet>
