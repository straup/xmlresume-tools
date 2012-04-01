<?xml version="1.0" encoding="UTF-8"?>

<!-- ====================================================================== 
     fo.xsl

     Extends the XML Resume Library html.xsl stylesheet for transforming XML
     resume documents into XSL-FO, for formatting into PDF.

     Version : 0.4
     Date    : $Date: 2004/10/26 13:33:06 $

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

     <xsl:stylesheet version="1.0"
                     xmlns:r="http://xmlresume.sourceforge.net/resume/0.0"
                     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                     xmlns:fo="http://www.w3.org/1999/XSL/Format">

     <xsl:output method="xml" omit-xml-declaration="no" indent="yes"
                 encoding="UTF-8"/>

     <xsl:strip-space elements="*"/>

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:include href = "../lib/extrefs.xsl" />
     <xsl:include href = "../lib/params.xsl" />

     <xsl:include href = "../lib/resume/xsl/format/fo.xsl" />
     <xsl:include href = "../lib/resume/xsl/paper/letter.xsl" />

<!-- ====================================================================== 

     ====================================================================== -->

    <xsl:template match="/">
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master master-name="resume-page"
          margin-top="{$margin.top}"
          margin-left="{$margin.left}"
          margin-right="{$margin.right}"
          margin-bottom="0in"
          page-height="{$page.height}"
          page-width="{$page.width}">
          <!-- FIXME: should be error-if-overflow, but fop0.20.3 doesn't support it -->
          <fo:region-body overflow="hidden"
            margin-bottom="{$margin.bottom}"/>
          <!-- FIXME: should be error-if-overflow, but fop0.20.3 doesn't support it -->
          <fo:region-after overflow="hidden"
            extent="{$margin.bottom}"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      <fo:page-sequence master-reference="resume-page">
        <!-- Running footer with person's name and page number. -->
        <fo:static-content flow-name="xsl-region-after">
          <fo:block text-align="start" font-size="{$footer.font.size}"
            font-family="{$footer.font.family}">
            <xsl:apply-templates select="r:resume/r:header/r:name"/>
            <xsl:text> - </xsl:text>
            <xsl:value-of select="$resume.word"/>
            <xsl:text> - </xsl:text>
            <xsl:value-of select="$page.word"/>
            <xsl:text> </xsl:text>
            <fo:page-number/>
          </fo:block>
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body">
          <!-- Main text is indented from start side. -->
          <fo:block start-indent="{$body.indent}"
            font-family="{$body.font.family}"
            font-size="{$body.font.size}">
            <xsl:apply-templates select="r:resume/child::node()[name() != 'lastModified']"/>
	    <xsl:call-template name = "Extrefs" />
            <xsl:apply-templates select = "r:resume/r:lastModified" />
          </fo:block>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template match="r:header" mode="standard">
    <fo:block space-after="{$para.break.space}">
      <fo:block
          font-style="{$header.name.font.style}"
          font-weight="{$header.name.font.weight}"
          font-size="{$header.name.font.size}">
        <xsl:apply-templates select="r:name"/>
      </fo:block>
      <xsl:if test = "$header.address.display"><xsl:apply-templates select="r:address"/></xsl:if>
      <fo:block space-before="{$half.space}">
        <xsl:apply-templates select="r:contact"/>
      </fo:block>
    </fo:block>
  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template match="r:header" mode="centered">
    <fo:block
        space-after="{$para.break.space}"
        start-indent="{$header.margin-left}"
        end-indent="{$header.margin-right}">
      <fo:leader leader-length="100%" leader-pattern="{$header.line.pattern}"
        rule-thickness="{$header.line.thickness}"/>
      <fo:block
          font-style="{$header.name.font.style}"
          font-weight="{$header.name.font.weight}"
          font-size="{$header.name.font.size}">
        <xsl:apply-templates select="r:name"/>
      </fo:block>
      <xsl:if test = "$header.address.display"><xsl:apply-templates select="r:address"/></xsl:if>
      <fo:block space-before="{$half.space}">
        <xsl:apply-templates select="r:contact"/>
      </fo:block>
      <fo:leader leader-length="100%" leader-pattern="{$header.line.pattern}"
        rule-thickness="{$header.line.thickness}"/>
    </fo:block>
  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template match="r:header/r:contact/r:phone">
   <xsl:if test = "$header.phone.display">
    <xsl:call-template name="contact">
      <xsl:with-param name="label">
        <xsl:call-template name="PhoneLocation">
          <xsl:with-param name="Location" select="@location"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="field">
        <xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
   </xsl:if>
  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:template match="r:activities">
      <xsl:call-template name="heading">
       <xsl:with-param name="text" select="$activities.word"/>
      </xsl:call-template>
      <xsl:apply-templates/>
     </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

  <xsl:template match="r:activity">
    <fo:block>
      <fo:block space-after="{$half.space}" keep-with-next="always">
        <fo:block
            keep-with-next="always"
            font-style="{$jobtitle.font.style}"
            font-weight="{$jobtitle.font.weight}">
          <xsl:apply-templates select="r:title"/>
        </fo:block>
        <fo:block
            font-style="{$job-period.font.style}"
            font-weight="{$job-period.font.weight}">
          <xsl:apply-templates select="r:date|r:period"/>
        </fo:block>
      </fo:block>
      <xsl:if test="r:description">
        <fo:block
          provisional-distance-between-starts="0.5em">
          <xsl:apply-templates select="r:description"/>
        </fo:block>
      </xsl:if>
      <xsl:if test="r:projects/r:project">
        <fo:block>
          <fo:block
              keep-with-next="always"
              font-style="{$job-subheading.font.style}"
              font-weight="{$job-subheading.font.weight}">
            <xsl:value-of select="$projects.word"/>
          </fo:block>
          <xsl:apply-templates select="r:projects"/>
        </fo:block>
      </xsl:if>
      <xsl:if test="r:achievements/r:achievement">
        <fo:block>
          <fo:block
              keep-with-next="always"
              font-style="{$job-subheading.font.style}"
              font-weight="{$job-subheading.font.weight}">
            <xsl:value-of select="$achievements.word"/>
          </fo:block>
          <xsl:apply-templates select="r:achievements"/>
        </fo:block>
      </xsl:if>
    </fo:block>
  </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:template match = "r:link">
      <fo:inline font-family="{$url.font.family}">
       <xsl:value-of select="."/>
      </fo:inline>
      <xsl:text> </xsl:text>
      <xsl:call-template name = "ExtrefPos" />
     </xsl:template>

<!-- ====================================================================== 

     ====================================================================== -->

     <xsl:template name = "Extrefs">

    <xsl:call-template name="heading">
      <xsl:with-param name="text" select = "$extrefs.word" />
    </xsl:call-template>

      <fo:list-block>

        <!-- warning : hacks be ahead, matey
             I can't get FOP to DWIM when it comes
             to indenting the list *and* lining
             up the link number and the link itself.
             Which accounts for the crusft to follow -->

    <xsl:for-each select = "//*[@href][count(.|key('extrefs', @href)[1]) = 1]">
      <xsl:variable name = "p" select = "string-length(position())" />

        <fo:list-item>
          <fo:list-item-label>
            <fo:block  />
          </fo:list-item-label>
          <fo:list-item-body>
            <fo:block>
       <xsl:choose>
        <xsl:when test = "number($cc - $p) > 0">
         <xsl:call-template name = "PrintNTimes">
           <xsl:with-param name = "string"><xsl:text>&#160;&#160;</xsl:text></xsl:with-param>
	  <xsl:with-param name = "count">
           <xsl:value-of select = "number($cc - $p)" />
          </xsl:with-param>
	 </xsl:call-template>
	</xsl:when>
        <xsl:otherwise />
       </xsl:choose>
             <xsl:value-of select = "position()" format = "1" />
             <xsl:text>.  </xsl:text>
             <fo:inline font-family="{$url.font.family}">
             <xsl:value-of select = "@href" />
            </fo:inline>
           </fo:block>
         </fo:list-item-body>
       </fo:list-item>

        </xsl:for-each>

      </fo:list-block>

     </xsl:template>

<!-- ====================================================================== 
     FIN // $Id: fo.xsl,v 1.13 2004/10/26 13:33:06 asc Exp $
     ====================================================================== -->

</xsl:stylesheet>
