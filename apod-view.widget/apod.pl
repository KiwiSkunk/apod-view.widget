#! /usr/bin/perl -w

# Thanks to http://www.haroldbakker.com/personal/apod.php#dl for the original perl
# apod.pl
#
# Original script by Harold Bakker
# http://www.haroldbakker.com/
#
# Modified by Ned W. Hummel, 6 Jan 2003, 12-01-2005
# Modified again by Harold Bakker, 12-01-2005
# Modified by Skunkworks Group 13 Jan 2016

my $maxwidth = 1680; # your screen width <--- modify to suit
my $maxheight = 1050; # your screen height <--- modify to suit
# End of variables to modify

# url for the images
my $baseurl = "http://apod.nasa.gov/apod";
# Grab the line that has the link to the big picture.
my @line = grep m/href=\"image/i, qx(curl -s $baseurl/astropix.html);

# need to check we have a jpg
# and load a backup image if we don't
if ($line[0]) {
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
} else {
	chdir "~/Library/Application\\ Support/\xC3\x9Cbersicht/widgets/apod-view.widget//";
	# resize the image
	use GD;
	use warnings;
	# create a new image
	$srcimage = GD::Image->newFromJpeg('apod-view.widget/default.jpg');
}

# ensure download is complete
sleep (0);
chdir "~/Library/Application\\ Support/\xC3\x9Cbersicht/widgets/apod-view.widget//";

# resize the image
use GD;
use warnings;

# create a new image
$srcimage = GD::Image->newFromJpeg('apod-view.widget/imgfull.jpg');
($srcW, $srcH) = $srcimage->getBounds();

my $wdiff = $maxwidth/$srcW;
my $hdiff = $maxheight/$srcH;
my $newW;
my $newH;
my $dstX = 0;
my $dstY = 0;
my $srcX = 0;
my $srcY = 0;

if ($wdiff > $hdiff) {
    $newW = $maxwidth;
    $aspect = $newW / $srcW;
    $dstY = int((($srcH - $maxheight) * $aspect) / 2);
    $newH = int($srcH * $aspect);
} else {
    $newH = $maxheight;
    $aspect = $newH / $srcH;
    $dstX = int((($srcW - $maxwidth) * $aspect) / 2);
    $newW = int($srcW * $aspect);
}


$newimage = new GD::Image($newW, $newH) or die "Failed to create image: $!";
$newimage->copyResized($srcimage, $dstX, $dstY, $srcX, $srcY, $newW, $newH, $srcW, $srcH);

# print it to the file
open(FH, '>apod-view.widget/imgfit.jpg') or die "Failed to create socket: $!";
print FH $newimage->jpeg() or die "Failed to create new image: $!";
close(FH);
