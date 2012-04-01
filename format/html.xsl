<?xml version="1.0" encoding="UTF-8"?>

<!-- ====================================================================== 
     html.xsl

     Extends the XML Resume Library html.xsl stylesheet for transforming XML
     resume documents into HTML.

     Version : 0.5
     Date    : $Date: 2004/02/22 03:58:56 $

     Copyright (c) 2003-2004 Aaron Straup Cope.
     All Rights Reserved.

     http://www.aaronland.info/xsl/xmlresume/
     http://xmlresume.sourceforge.net/

     ====================================================================== 
  
     Copyright (c) 2000-2002 Sean Kelly
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

<xsl:stylesheet xmlns:r="http://xmlresume.sourceforge.net/resume/0.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  version="1.0" 
                exclude-result-prefixes="r">

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:output indent = "yes" />

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:include href = "../lib/resume/xsl/format/html.xsl" />
     <xsl:include href = "../lib/xhtml/add-css-links.xsl" />
     <xsl:include href = "../lib/extrefs.xsl" />
     <xsl:include href = "../lib/params.xsl" />

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:apply-templates select="r:resume/r:header/r:name"/>
          <xsl:text> - </xsl:text>
          <xsl:value-of select="$resume.word"/>
        </title>
	<meta>
	 <xsl:attribute name="http-equiv">content-type</xsl:attribute>
	 <xsl:attribute name="content">utf-8</xsl:attribute>
	</meta>
        <xsl:choose>
         <xsl:when test="$css.embed = 1">
          <style>
           <xsl:value-of select="document($css.href)"/>
          </style>
         </xsl:when>
         <xsl:otherwise>
          <xsl:call-template name = "Add_CSS_Links" />
         </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="r:resume/r:keywords" mode="header"/>
      </head>
      <body>
        <xsl:apply-templates select="r:resume"/>
      </body>
    </html>
  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template match="r:resume">
   <div class="resume">
    <xsl:apply-templates select="child::node()[name() != 'lastModified']"/>
    <xsl:call-template name = "Extrefs" />
    <xsl:apply-templates select = "r:lastModified" />
   </div>
  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template match="r:header" mode="standard">
    <div class="header">
      <h1 class="nameHeading">
        <xsl:apply-templates select="r:name"/>
      </h1>
      <xsl:if test = "$header.address.display"><xsl:apply-templates select="r:address"/></xsl:if>
      <xsl:apply-templates select="r:contact"/>
    </div>
  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template match="r:header" mode="centered">
    <div class="header" style="text-align: center">
      <h1 class="nameHeading">
        <xsl:apply-templates select="r:name"/>
      </h1>
      <xsl:if test = "$header.address.display"><xsl:apply-templates select="r:address"/></xsl:if>
      <xsl:apply-templates select="r:contact"/>
    </div>
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
    <br/>
   </xsl:if>
  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template match="r:link">
    <a class="linkA">
      <xsl:attribute name="href">
        <xsl:apply-templates select="@href"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
    <sup><xsl:call-template name = "ExtrefPos" /></sup>
    <xsl:text> </xsl:text>
  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template match="r:activities">
    <xsl:call-template name="Heading">
      <xsl:with-param name="Text" select = "$activities.word" />
    </xsl:call-template>
    <xsl:apply-templates select="r:activity"/>
  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template match="r:activity">
    <p class="activity">
     <span class="activityTitle">
      <xsl:apply-templates select="r:title"/>
     </span>
      <br/>
      <xsl:apply-templates select="r:date|r:period"/>
    </p>
    <xsl:apply-templates select="r:description">
      <xsl:with-param name="css.class">activityDescription</xsl:with-param>
    </xsl:apply-templates>
    <xsl:if test="r:projects/r:project">
      <div class="projects">
        <p>
          <xsl:value-of select="$projects.word"/>
        </p>
        <xsl:apply-templates select="r:projects"/>
      </div>
    </xsl:if>
  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:template match="r:membership">
      <li class="membership">
       <xsl:if test="r:title">
	<div class="membershipTitle">
         <xsl:call-template name="Title">
	  <xsl:with-param name="Title" select="r:title"/>
	 </xsl:call-template>
	</div>
       </xsl:if>
       <xsl:if test="r:organization">
        <xsl:apply-templates select="r:organization"/>
        <xsl:apply-templates select="r:location"/>
        <br/>
       </xsl:if>
       <xsl:if test="r:date|r:period">
        <xsl:apply-templates select="r:date|r:period"/>
        <br/>
       </xsl:if>
       <xsl:apply-templates select="r:description">
        <xsl:with-param name="css.class">membershipDescription</xsl:with-param>
       </xsl:apply-templates>
      </li>
     </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template name = "Extrefs">
    <xsl:call-template name="Heading">
      <xsl:with-param name="Text" select = "$extrefs.word" />
    </xsl:call-template>

    <ol class = "externalLinks">

    <xsl:for-each select = "//*[@href][count(.|key('extrefs', @href)[1]) = 1]">

     <li>
      <a>
       <xsl:attribute name = "href"><xsl:value-of select = "@href" /></xsl:attribute>
       <xsl:attribute name = "title"><xsl:value-of select = "." /></xsl:attribute>
       <xsl:value-of select = "@href" />
       </a>
     </li>
    </xsl:for-each>
    </ol>

  </xsl:template>

<!-- ====================================================================== 

     FIN // $Id: html.xsl,v 1.13 2004/02/22 03:58:56 asc Exp $
     ====================================================================== -->

</xsl:stylesheet>
