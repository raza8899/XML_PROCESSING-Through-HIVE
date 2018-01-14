show databases;
USE tmp;
--ADDING JAR FOR XML
ADD JAR /home/raza/Documents/hivexmlserde-1.0.5.3.jar;
show tables;
create table xmltab(bookname string ,price string,author string,copies_sold string) 
  ROW FORMAT SERDE 'com.ibm.spss.hive.serde2.xml.XmlSerDe'
--xpath returns  a Hive array of strings
   WITH SERDEPROPERTIES ("column.xpath.bookname"="/book/name/text()",     "column.xpath.price"="/book/price/text()","column.xpath.author"="/book/author/text()","column.xpath.copies_sold"="/book/copies/text()") 
  STORED AS INPUTFORMAT 'com.ibm.spss.hive.serde2.xml.XmlInputFormat'
  OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat'
   LOCATION '/XMLPROCESSEDDATA'
   TBLPROPERTIES ("xmlinput.start"="<book>","xmlinput.end"="</book>");

LOAD DATA LOCAL INPATH '/home/raza/Documents/technology.xml' INTO TABLE xmltab ;

SELECT * FROM xmltab;
