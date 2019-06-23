# Change Time Stamp of files

use strict;
use warnings;
use File::Find;
use Cwd;
use File::Copy;
use Time::Local;

# inDir�t�H���_�ȉ��̃t�@�C���̍X�V�������擾���A
# outDir�t�H���_�ȉ��̃t�@�C���̍X�V�����ɐݒ肷��B

# �Ώۃt�H���_��
my $inDir = "C:\\Users\\sdkn1\\Desktop\\test"; 
my $outDir = "C:\\Users\\sdkn1\\Desktop\\test - �R�s�["; 

find(\&print_file, $inDir);

sub print_file {
    if( ! -f ) { return 0; } #�t�@�C���ȊO�͏���
    my $file = $_;
    my $inPath = $File::Find::name;
    my $outPath = "$outDir/$file";
    print "--- $file : $inPath -> $outPath\n";

    my $mtime = (stat($inPath))[9] ;
    my $atime = time;
    my $mt = localtime($mtime);
    my $at = localtime($atime);

    #print "$mt, $at\n";

    utime $atime, $mtime, $outPath or die "error: fail to update ctime $outPath\n";
}

