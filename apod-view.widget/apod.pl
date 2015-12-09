#! /usr/bin/perl -w

# Thanks to http://www.haroldbakker.com/personal/apod.php#dl for the original perl
# apod.pl
#
# Original script by Harold Bakker
# http://www.haroldbakker.com/
#
# Modified by Ned W. Hummel, 6 Jan 2003, 12-01-2005
# Modified again by Harold Bakker, 12-01-2005
# Modified by Skunkworks Group 1-12-2015

my $baseurl = "http://apod.nasa.gov/apod";
# Grab the line that has the link to the big picture.
my @line = grep m/href=\"image/i, qx(curl -s $baseurl/astropix.html);

# Grab the actual link to the image.
$_ = $line[0];
/"image\/([^\/]+)\/([^\/]+)\.([^\.]+)"/;
my $link = "$1/$2\.$3";
my $picture = $baseurl."/image/".$link;
qx(curl -s -o ~/Library/Application\\ Support/\xC3\x9Cbersicht/widgets/apod-view.widget/imgfull.jpg $picture);

# ensure download is complete
sleep (5);
chdir "~/Library/Application\\ Support/\xC3\x9Cbersicht/widgets/apod-view.widget//";

# resize the image
use GD;
use warnings;

# create a new image
$srcimage = GD::Image->newFromJpeg('apod-view.widget/imgfull.jpg');
($srcW, $srcH) = $srcimage->getBounds();
# temp manual setting $srcW, $srcH
#my $srcW = 2770;
#my $srcH = 1674;

my $maxwidth = 1680; # your screen width <--- modify to suit
my $maxheight = 1050; # your screen height <--- modify to suit
my $wdiff = $srcW - $maxwidth;
my $hdiff = $srcH - $maxheight;
my $newW;
my $newH;

if ($wdiff > $hdiff) {
    $newW = $maxwidth;
    $aspect = ($newW/$srcW);
    $newH = int($srcH * $aspect);
} else {
    $newH = $maxheight;
    $aspect = ($newH/$srcH);
    $newW = int($srcW * $aspect);
}

$newimage = new GD::Image($newW, $newH) or die "Failed to create image: $!";
$newimage->copyResized($srcimage, 0,0,0,0, $newW, $newH, $srcW, $srcH);

# print it to the file
open(FH, '>apod-view.widget/imgfit.jpg') or die "Failed to create socket: $!";
print FH $newimage->jpeg() or die "Failed to create new image: $!";
close(FH);
