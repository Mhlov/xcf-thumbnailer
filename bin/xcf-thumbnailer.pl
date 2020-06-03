#!/usr/bin/perl
#==============================================================================
#
#Copyright (C) 2020 Melon (https://github.com/Mhlov)
#
# LICENSE
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#==============================================================================
#Tested on GIMP 2.10.8

use strict;
use warnings;
use utf8;

sub quote {
	foreach (@_) {
		s/"/\\"/g;
	}
}

sub main {
	return 1 if @_ != 3;

	my ($in, $out, $size) = @_;

	quote ($in, $out);

	my $code = join '', readline DATA;
	close DATA;

	$code .= qq/(mhl-save-thumbnail "$in" "$out" $size)(gimp-quit 1)/;

	exec gimp => qw/-c -i -d -b/, $code;
}

exit main(@ARGV);


__DATA__
(define (mhl-save-thumbnail infile outfile size)
  (define image	   (car (gimp-xcf-load 1 infile infile)))

  (define w (car (gimp-image-width  image)))
  (define h (car (gimp-image-height image)))
  (define new_w size)
  (define new_h size)

  (if (and (<= w size) (<= h size))
	(begin
	 (set! new_w w)
	 (set! new_h h))
	; else
	(if (> w h)
	  (set! new_h (round (/ size
							(/ w h))))
	  ; else
	  (set! new_w (round (/ size
							(/ h w))))
	)
  )

  (define drawable (car (gimp-image-merge-visible-layers image 1)))
  ;(define drawable (car (gimp-image-get-active-drawable image)))

  (gimp-layer-scale drawable
					new_w
					new_h
					TRUE)

  (file-png-save-defaults 1
						  image
						  drawable
						  outfile
						  outfile)
)

