# apod-view.widget
Übersicht APOD desktop picture
Updated 8 Jan 2017

What's new

Better centering of the cropped image.
NASA moved the image location so the script has been updated to fix this.

This widget requires the GD library and Perl to be installed. 
It accesses the https://apod.nasa.gov/apod website and grabs the current picture of the day.
This is downloaded and resized and placed in as your wallpaper. If it is a video it uses a default image instead.
I used Homebrew: http://kylase.github.io/CircosAPI/os-x-installation-guide/ to install Perl and the GD packages. This requires you to know and use Terminal.

Configuration

Two lines in the apod.pl script will need changing to suit your screen dimensions.
The refresh rate is set in the index.coffee script. It is set to refresh twice a day. 

Disclaimer

I have no idea what I'm doing. Use this at your own risk. I wrote it for myself. 
Change it as you wish but please share the improvements with me:
github@skunkworks.net.nz
