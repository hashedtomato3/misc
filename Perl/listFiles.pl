use strict;
use warnings;
use File::Find;
use Cwd;
use File::Copy;
use Image::ExifTool;
use Time::Local;

#�w��t�H���_�ȉ��̃t�@�C���̍X�V�����Ȃǂ̃��X�g���o�͂���B

# �Ώۃf�B���N�g����(���΃p�X�ł�OK�ł�)
#my $dir = "G:/BACKUP_PC/Toshiyuki.tmp.delete/Pictures/�j�D/fromHDD";
my $dir = "Z:/HOKAN/Pictures/�j�D"; #getcwd; 

open(LOG,">listFiles.csv") or die "cannot open file\n";
find(\&print_file, $dir);

print LOG "File,Path,ModDate,ExifCDate\n";
sub print_file {
    my $file = $_;
    my $path = $File::Find::name;
    print $path,"\n";
    my $modtime = (stat($path))[9] ;
    my $mod = localtime($modtime);

    printf LOG "%s,%s,%s", $file, $path, $mod;

#    my $exifTool = new Image::ExifTool;
#    my $info = $exifTool->ImageInfo($path, 'CreateDate');
#    my $create_date = $info->{'CreateDate'};
#    $create_date = "" unless defined($create_date);
#   print LOG ",$create_date"; 

    print LOG "\n";
}

