This directory contains DocBook XSL extension jars for the Saxon 6.5.3 and Xalan 2.5.1 processors. The names of the jars were changed so that by default they are not used by <oXygen/>. This is necessary because there are conflicts between the content of these two jar files. 

If you want to use a DocBook XSL extension function you have to rename the jar file for the XSLT processor that you will use by deleting the ".ext" extension and restart <oXygen/>. 

Please note that only one of the two jars can be used at one time.
