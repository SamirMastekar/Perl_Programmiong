#!/usr/bin/perl 
use File::Slurp;



#Read the File with function
sub readFile{
	open(FH, $filename) or die("sorry, $filename is not readable");
	$filecontent = <FH>;
	close(FH);
	#return $fileContent;
}
$filename = "C:\\Users\\Htc\\Desktop\\delete\\test.txt";
#print readFile($filename);

#read file with Slurp Module
sub readFile2{
	$fileContent = read_file($filename2);
	return $fileContent
}

$filename2 = "C:\\Users\\Htc\\Desktop\\delete\\test.txt";
$fileContent = readFile2($filename2);
print $fileContent