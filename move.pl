use strict;
use warnings;
use File::Find;
use Cwd;
use File::Copy;

# �t�@�C���́u�X�V���v�����ƂɁA�K�؂ȃt�H���_�Ɉړ�����B

# �ړ���f�B���N�g��
my $hokandir = "Z:/HOKAN/Pictures/�j�D";

# �Ώۃf�B���N�g����(���΃p�X�ł�OK�ł�)
#my $dir = "Z:/HOKAN/Pictures/�j�D/fromHDD"; #getcwd; 
#my $dir = "Z:/HOKAN/AVCHD�r�f�I";
my $dir = getcwd;

# ����������ƁA�t�@�C�����̐擪�ɕt�����܂��B
my $pref = defined($ARGV[0]) ? $ARGV[0] : ":";

#�_�C�A���O
print "�K�v�ɉ�����modMdate.pl�Ńt�@�C���X�V�������C�����Ă�����s��������( hit return to go ahead! )";
my $x = <STDIN>;

print "RX100�̓��悪����ꍇ�́Arx�Ɠ��͂�������(victor�̓���ƍ��݂ł��܂���):";
my $type = <STDIN>;
chomp($type);
if($type eq "rx") { $pref = "MTS:D"; print "type=RX100\n";}
else { print "type=non RX100\n";}
print "������ɂ�enter�������Ă�������";
my $dummy = <STDIN>;

#-------------------------------------------------------
open(LOG,">>movelog.csv") or die "cannot open file\n";
print "log file: movelog.csv\n";
print "move to: $hokandir\n";
print "prefix: $pref\n";

find(\&print_file, $dir);

sub print_file {
    my $file = $_;
    my $path = $File::Find::name;

    my $modtime = (stat($path))[9] ;
    my ($sec, $min, $hour, $mday, $mon, $year) = localtime($modtime);
    $year = $year + 1900;
    $mon= $mon + 1;
    my $now = localtime;

    printf LOG "%s,%s,", $file, $path;
    print LOG "$year �N$mon��$mday��$hour��$min��$sec�b" , ","; 
    print LOG "$now,";

    my $folder1 = $year;
    my $folder2 = int(($mon+1) / 2)*2-1;    
    $folder2 = sprintf("%02d-%02d", $folder2, $folder2+1);    
    #print LOG "'$folder1/$folder2,";

    if( $file !~ /.(jpg|avi|mts|3gp|JPG|AVI|MTS|3GP|mp4|MP4)$/ ) { print LOG ",,skip\n"; return; }

    if(! -e "$hokandir/$folder1") { mkdir  "$hokandir/$folder1"; }
    if(! -e "$hokandir/$folder1/$folder2") { mkdir  "$hokandir/$folder1/$folder2"; }

    my ($t, $p) = split(/:/,$pref);
    $p = uc(substr($file,-3)) eq uc($t) ? $p : "";
    $file = "$p$file";

    if( -e "$hokandir/$folder1/$folder2/$file" ) { print LOG ",,same file name exists\n"; return; }

    move $path, "$hokandir/$folder1/$folder2/$file" or die ",,move error: $file\n";
    print LOG "$hokandir/$folder1/$folder2,$file,";
    print LOG "moved\n";
}

