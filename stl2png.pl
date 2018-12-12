#!/usr/bin/perl

# == STL2PNG.pl, written by Rene K. Mueller <spiritdude@gmail.com>
#
# License: MIT
#
# Description:
#    ./stl2png.pl cube.stl cube.png 256
#
# renders a nice preview of cube.stl, usable as thumbnail render for Nautilus file browser
#
# History:
# 2018/12/09: 0.0.1: first version based on https://cubehero.com/2013/04/20/how-to-convert-and-render-stl-files-to-images/

my($in,$out,$sz) = @ARGV;

$sz *= 1; $sz = 256 if($sz<=16);

my $tmp = "/tmp/stl2png-$$.pov";
my $inc = "/tmp/stl2png-$$.inc";

if(fork()==0) {
   close STDOUT;
   close STDERR;
   open(STDOUT,">",$inc);
   exec("stl2pov","-n","sample",$in);
}
wait;

# -- PovRay code based on https://cubehero.com/2013/04/20/how-to-convert-and-render-stl-files-to-images/ with a few changes
open(my $fh,">",$tmp);
print $fh "#include \"$inc\"
#include \"math.inc\"
#include \"finish.inc\"
#include \"transforms.inc\"
background {color rgb 1}
light_source {
  <-500,500,400>
  rgb 1
  shadowless
}
global_settings {
  assumed_gamma 2
}
#declare Min = min_extent(m_sample);
#declare Max = max_extent(m_sample);
#declare bottom_diag = sqrt(pow(Max.y - Min.y, 2) + pow(Max.x - Min.x, 2));
#debug concat(\"bottom_diag:\", str(bottom_diag, 5, 0))
#declare box_diag = sqrt(pow(bottom_diag, 2) + pow(Max.z - Min.z, 2));
#debug concat(\"box_diag:\", str(box_diag, 5, 0))
camera {
  location <0,box_diag*2,0>
  rotate <20,0,45>
  angle 30
  look_at <0,0,0>
  right x*$sz/$sz
}
sky_sphere {
  pigment {
  gradient y
  color_map {
    [0.0 rgb <1.0,1.0,1.0>] //153, 178.5, 255 //150, 240, 192
    [0.7 rgb <0.9,0.9,0.9>] // 0, 25.5, 204 //155, 240, 96
  }
  scale 2
  translate 1
  }
}
object {
  m_sample
  Center_Trans(m_sample, x+y+z)   
  texture {
    pigment {color <1,1,0.2>}
    finish {phong 0.9 diffuse 1}
  }
}
";
close $fh;

if(fork()==0) {
   close STDOUT;
   close STDERR;
   exec("povray","-d","-v","-i$tmp","+FN","+W$sz","+H$sz","-o$out","+Q9","+AM1","+A","+UA");
}
wait;
unlink $inc;
unlink $tmp;

if(!-e $out) {
   print STDERR "$0: conversion failed: $in -> $out\n";
   exit -1;
}

exit 0;
