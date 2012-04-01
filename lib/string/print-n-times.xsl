<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:doc="http://xsltsl.org/xsl/documentation/1.0"
                exclude-result-prefixes="doc"
                version="1.0">

<!-- ====================================================================== 
     print-n-times.xsl                                                   

     This stylesheet defines a single template for printing a string (n) times. 
     An optional separator string may also be defined which, if present, will
     be printed (n -1) times.

     Version : 1.0
     Date    : $Date: 2003/04/17 12:35:17 $

     Copyright (c) 2003 Aaron Straup Cope
     http://aaronland.info/xsl/string/print-n-times

     Permission to use, copy, modify and distribute this stylesheet and its 
     accompanying documentation for any purpose and without fee is hereby 
     granted in perpetuity, provided that the above copyright notice and 
     this paragraph appear in all copies.  The copyright holders make no 
     representation about the suitability of the stylesheet for any purpose.

     It is provided "as is" without expressed or implied warranty.

     ====================================================================== 
     Changes
     
     1.0    April 17 2003

            - Initial release

     ====================================================================== -->

 <xsl:output method="xml"/>

  <doc:reference xmlns="">
    <referenceinfo>
      <releaseinfo role="meta">
	&#36;Id&#36;
      </releaseinfo>
      <author>
	<surname>Cope</surname>
        <othername>Straup</othername>
	<firstname>Aaron</firstname>
      </author>
      <copyright>
	<year>2003</year>
	<holder>Aaron Straup Cope</holder>
      </copyright>
    </referenceinfo>

    <title>Print (n) Times</title>

    <partintro>
      <section>
	<title>Introduction</title>

	<para>This stylesheet defines a single template for printing a string (n) times. 
     An optional separator string may also be defined which, if present, will
        be printed (n -1) times.</para>

      </section>
    </partintro>

  </doc:reference>

<!-- ====================================================================== 
     template: PrintNTimes
     ====================================================================== -->

  <doc:template name="PrintNTimes" xmlns="">
   <refpurpose>To print a string, and an optional separator, (n) times.</refpurpose>

   <refdescription>
    <para>Prints a string, and an optional separator, (n) times.</para>
   </refdescription>

   <refparameter>
    <variablelist>
     <varlistentry>
      <term>string</term>
      <listitem>
       <para>The string to be printed</para>
      </listitem>
     </varlistentry>
     <varlistentry>
      <term>count</term>
      <listitem>
       <para>The total number of times to print $string</para>
      </listitem>
     </varlistentry>
     <varlistentry>
      <term>spacer</term>
      <listitem>
       <para>The string to serve as a separator. Will only be used if its string length returns a non-zero value.</para>
      </listitem>
     </varlistentry>
    </variablelist>
   </refparameter>

   <refreturn>
    <para>Returns string.</para>
   </refreturn>
  </doc:template>

 <xsl:template name = "PrintNTimes">
  <xsl:param name = "string" />
  <xsl:param name = "count" />
  <xsl:param name = "spacer" />
  <xsl:param name = "_cur" select = "1" />
  <xsl:value-of select = "$string" />
  <xsl:if test = "number($_cur) + 1 &lt;= number($count)">
   <xsl:if test = "string-length($spacer)">
    <xsl:value-of select = "$spacer" />
   </xsl:if>
   <xsl:call-template name = "PrintNTimes">
    <xsl:with-param name = "string" select = "$string" />
    <xsl:with-param name = "count" select = "$count" />
    <xsl:with-param name = "spacer" select = "$spacer" />
    <xsl:with-param name = "_cur" select = "number($_cur) +1" />
   </xsl:call-template>
  </xsl:if>
 </xsl:template>

<!-- ====================================================================== 
     FIN
     ====================================================================== -->

</xsl:stylesheet>
