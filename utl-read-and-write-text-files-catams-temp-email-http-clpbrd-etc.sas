%let pgm=utl-read-and-write-text-files-catams-temp-email-http-clpbrd-etc;

Read and write text files catams temp email http clpbrd socket pipe ftp bitbucket printto etc

github
https://tinyurl.com/bdfwt4x3
https://github.com/rogerjdeangelis/utl-read-and-write-text-files-catams-temp-email-http-clpbrd-etc

 Some of these may work in Windows but not Unix and vice versa;
 May need to look at older versions of SAS docs to find this info;

  1  Write null file which is a "black hole" or bit bucket
  2  Read null file which is a "black hole" or bit bucket
  3  Write temp file
  4  Read temp file
  5  Read output of a program from a pipe
  6  Send output directly to default printer
  7  Write to catalog members of various types satams/dmkeys...
  8  Read catalog members of various types
  9  Red clipbrd
 10  Write clipbrd
 11  Email file
 12  Read  FTP sites
 13  Write to FTP site
 14  Access tcp sockets - too specific for a general working example ...
 15  Sasxbamw a file at a web site
 16  Get internet file
 17  Post nternet file
 18  Proc printto
 19  Test for empty file

/*                              _
  _____  ____ _ _ __ ___  _ __ | | ___  ___
 / _ \ \/ / _` | `_ ` _ \| `_ \| |/ _ \/ __|
|  __/>  < (_| | | | | | | |_) | |  __/\__ \
 \___/_/\_\__,_|_| |_| |_| .__/|_|\___||___/
                         |_|
*/

  * some of these may work in Windows but not Unix and vice versa;
  * may need to look at older bersions of SAS to find this info;

   Windows - http://support.sas.com/onlinedoc/913/getDoc/en/hostwin.hlp/win-func-filename.htm
   UNIX    - http://support.sas.com/onlinedoc/913/getDoc/en/hostunx.hlp/a000195127.htm

   * null file which is a "black hole" or bit bucket;
   filename rubbish dummy ;
   data _null_ ;
     file rubbish ;
     set sashelp.class ;
     put _all_ ;
   run ;

   * null file which is a "black hole" or bit bucket;
   filename rubbish "/dev/null" ;
   data _null_ ;
     infile rubbish ;
     set sashelp.class ;
     input;
     put _infile_;
   run ;

   * write temp file;
   filename wrk temp ;
   data _null_ ;
     file wrk ;
     put 'test' ;
   run ;

   * read temp file;
   data _null_ ;
     infile wrk ;
     input ;
     put _infile_ ;
   run ;

   * read output of a program from a pipe ;
   filename cmd pipe 'ls -l *.log' ;
   data _null_ ;
     infile cmd ;
     input ;
     put _infile_ ;
   run ;

   * Send output directly to default printer ;
   filename p printer ;
   data _null_ ;
     file p ;
     set sashelp.class ;
     put _all_ ;
   run ;

   * write to catalog members of various types ;
   filename cat catalog 'work.test.my.catams' ;
   data _null_ ;
     file cat ;
     set sashelp.class ;
     put name;
   run ;

   * read catalog members of various types ;
   data _null_ ;
     infile cat ;
     input;
     put _infile_ ;
   run ;

   * red clipbrd;
   * write clipbrd;
   filename clip clipbrd ;
   data _null_ ;
     infile clip ;
     input ;
     put _infile_;
   run ;

   * email file;
   filename report email 'regusers@ACHME.com' subject='test mail' attach='c:\test.txt' ;
   file report ;
     put 'Hi. Here is my test email' ;
   run ;

   * read  FTP sites ;
   filename host ftp 'readme.txt' host='ftp.sas.com' cd='/techsup/download' user='anonymous' debug ;
   data _null_ ;
     infile host ;
     input ;
     put _infile_ ;
   run ;

   * write to FTP site ;
   filename x url 'http://www.sas.com' ;
   data _null_ ;
     infile x ;
     input ;
     put _infile_ ;
   run ;

   * access tcp sockets - too specific for a general working example ... ;
   filename local socket ':5000' server reconn=3;

   * sasxbamw a file at a web site ;
   filename foo sasxbamw 'http://www.mycompany.com/production/files/rawFile.txt' user='regusers' pass='xxxxxx';

   filename resp TEMP;


   * get internet file;
   filename resp TEMP;
   proc http
      url="http://httpbin.org/get"
      out=resp;
   run;

   * post nternet file
   filename resp TEMP;
   filename headout TEMP;
   filename input TEMP;
   data _null_;
      file input;
      put "this is some sample text";
   run;

   proc http
      url="http://httpbin.org/post"
      in=input
      out=resp
      headerout=headout;
   run;

   * proc printto log= print=

    * test for empty file;
   data _null_ ;
    infile "/home/regusers/local/utl/inp/t000430_empty.txt" end = empty ;
    call symputx("empty",put(empty,1.)); /* 1 if empty */
   run;
   %put %sysfunc(ifc(&empty,file is empty,file is not empty));;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
