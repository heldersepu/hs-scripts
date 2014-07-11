use File::Copy;
File::Find;

File::Find::find({wanted => \&wanted}, 'C:\Scripts');
print "\nTotal Files: " . $count;

exit;

sub wanted (

    my $count = 0;

    /\.txt$/ or return;
    my $filename = $_;
    print "$filename \n";
    my $newfile = "C:\\old\\" . "$_";

    copy($File::Find::name, $newfile) or die "Copy failed: $!";
    $count = $cout + 1

)
