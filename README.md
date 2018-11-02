Note pdfmanager , this task could be solved with

* pdfgrep
* pdftotext
* jshon

Unix tools had to be used.	



** Examples

jshon -n {} -n {} -s "/foo/foo/" -i "Path"  -s "java" -i tag -i "PdfFileName"

      {
       "PdfFileName": {
         "Path": "\/foo\/foo\/",
  	 "tag": "java"
	 }
}

pdfgrep example
pdfgrep -H --color always -n -i <pattern> <pdffile>

* findfile.sh

** find $HOME -name \*.pdf (find all files)
** find $HOME -name \*.pdf 2>dev/null ( error msg redirect to null file)
** igonore (exclude form path)
ref https://stackoverflow.com/questions/4210042/how-to-exclude-a-directory-in-find-command

** create ignoredir.txt file it is store all exclude path
** ignoredir.txt file do put "/" in ending folder path string

** Name, Location,Tags, Priroity


** pdftotext

convert page 25

pdftotext -f 25 -l 25 <pdffile>

pdftotext -f 29 -l 29 -layout javabook.pdf -
"-" here used pdffile not save to any textfile it is print to stdout
-layout is used print like a pdfpage
 




ref
https://manpages.debian.org/jessie/jshon/jshon.1.en.html
https://manpages.debian.org/jessie/jshon/jshon.1.en.html
https://pdfgrep.org/doc.html
