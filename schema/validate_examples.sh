#!/bin/sh
#-------------------------------------------------------------------------------
#
# Authors: Stephan Meissl <stephan.meissl@eox.at>
#
#-------------------------------------------------------------------------------
# Copyright (C) 2016 EOX IT Services GmbH
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies of this Software or works derived from this Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#-------------------------------------------------------------------------------

# Use local xml catalog to import missing schema files:
export XML_CATALOG_FILES="catalog.xml"

echo "Validating EO-WCS examples against wcsEOAll.xsd"
find wcseo/examples/ -name "*[^S][^O][^A][^P].xml" -exec xmllint --noout --schema http://schemas.opengis.net/wcs/wcseo/1.1/wcsEOAll.xsd {} \;

echo "\nValidating EO-WCS examples against wcsEOSchematron.sch"
xsltproc schematron_xslt1/iso_dsdl_include.xsl wcseo/wcsEOSchematron.sch | xsltproc schematron_xslt1/iso_abstract_expand.xsl - | xsltproc schematron_xslt1/iso_svrl_for_xslt1.xsl - | xsltproc - \
    wcseo/examples/wcseo_requestGetCapabilities.xml \
    wcseo/examples/wcseo_responseGetCapabilities.xml \
    wcseo/examples/wcseo_requestDescribeEOCoverageSet.xml \
    wcseo/examples/wcseo_responseDescribeEOCoverageSet_minimal.xml \
    wcseo/examples/wcseo_responseDescribeEOCoverageSet.xml \
    wcseo/examples/wcseo_requestGetCoverage.xml \
    wcseo/examples/wcseo_responseGetCoverage.xml \
    wcseo/examples/wcseo_responseGetCoverage_StitchedMosaic.xml \
    wcseo/examples/wcseo_requestGetEOCoverageSet.xml \
    wcseo/examples/wcseo_responseGetEOCoverageSet.xml
