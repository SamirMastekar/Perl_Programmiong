#!/usr/bin/perl -w
use strict;
use warnings;
use Time::Piece;

my $unitPath = "C:\\Users\\Htc\\Desktop\\delete";
#===========================================================
#File Description:
#	Automation Work
#===========================================================
#Algorithm Used:
#	1. Popup the UI of Script
#	2. Horizontal Collaborate of CP if any
#	3. On Compile Flag in init.def 	
#	4. Run "Build" command
#   5. Take Code coverage in devtest.txt file
#	6. Run AutoTest from devtest.txt with -p=4
#	7. Collect Fail and NotRun AutoTest in rerun.txt file
#	8. Rename folder src-->src_cp & dt--->dt_BigSet
#	9. Create src folder
#	10. Run "Build" command
#	11. Run AutoTest from rerun.txt.
#   12. Comapre folder dt folder of rerun with dt_BigSet
#	13. Send Result to user of CP
#	14. Again Rename the folder src_cp-->src & dt-->dt_plain
#	15. set ENV variable ""
#	16. Run AutoTest from rerun.txt on change package
#	17. Again compare folder dt with dt_plain
#	18. Rename the All compare result to Result_firstRun
#	19. Send the Result to user of CP
#==========================================================
#     Date 				Name 			Description
#  29-March-2020     Samir Mastekar     Initial
#==========================================================

#Hozonital Collaboration of CH
my $changePackage= "My CP";
ExecutableProcess($changePackage);

#Run Build
ExecutableProcess("Build All");

#Code Coverage
my $codeCoverage = "dt some command";
ExecutableProcess($codeCoverage);

#RunAutoTest
my $runAutoTest = "devtest runtest devetest.txt -local -p=4 -nodisplay";
ExecutableProcess($runAutoTest);

#Collect Fail & NotRun AutoTest
my $faliNotrunAutotest = "devtest collect fail and not run devtest";
ExecutableProcess($faliNotrunAutotest);

#Rename Folder
rename("$unitPath.\\src", "$unitPath.\\src_cp") or die(Logger("Unable to Rename the src folder"));
rename("$unitPath.\\dt", "$unitPath.\\dt_BigSet") or die(Logger("Unable to Rename the dt folder"));
mkdir("$unitPath.\\src") or die(Logger("Unable to create src folder"));

#Build Plain Unit
ExecutableProcess("Build");

#Run Fail & NotRun AutoTest on plain unit
my $runFailAutoTest ="devtest runtest rerun.txt -local -nodisplay";
ExecutableProcess($runFailAutoTest);

#Comapare the folder
my $compareFilpath="Comapare file path";
my $comapareCommand="$compareFilpath -changePackage=$unitPath\\dt_BigSet -plainpackage=$unitPath\\dt";
ExecutableProcess($comapareCommand);

#send the Result user
SendMail();

#Rename Folder
unlink("$unitPath.\\src") or die(Logger("Deleting plain src folder"));
rename("$unitPath.\\src_cp", "$unitPath.\\src") or die(Logger("Unable to Rename the src_cp to src folder"));
rename("$unitPath.\\dt", "$unitPath.\\dt_plain") or die(Logger("Unable to Rename the dt to dt_plain folder"));

#Set Env Variable
my $groupOffEnv = "Group off Variable"
ExecutableProcess($groupOffEnv)

#--------------------------------------------------------
sub ChangeInitFile
{


}
#---------------------------------------------------------
sub ReadFile
{
	my $fileContent = read_file(my $filename2);
	return $fileContent;
}
#---------------------------------------------------------
sub SendMail
{

}
#----------------------------------------------------------
sub ExecutableProcess
{	
	my ($cmd) = @_;
	Logger($cmd);
	#system($cmd);
	print($cmd."\n");
}
#----------------------------------------------------------
sub Logger
{
	my ($var) =@_;
	my $Log =localtime->strftime('%Y-%m-%d   -%H:%M:%S'). "   - ".$var;
	open(FH, '>>', 'C:\Temp\AutoTest.log');
	print(FH $Log."\n");
	close(FH);
}
