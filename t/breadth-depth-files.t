use v6;
use Test;

use lib 't/lib';
use PFTest;

use Path::Finder;

#--------------------------------------------------------------------------#

{
	my @tree = <
	  aaaa.txt
	  bbbb.txt
	  cccc/dddd.txt
	  cccc/eeee/ffff.txt
	  gggg.txt
	>;

	my @depth_pre = <
	  aaaa.txt
	  bbbb.txt
	  cccc/dddd.txt
	  cccc/eeee/ffff.txt
	  gggg.txt
	>;

	my @depth_post = <
	  aaaa.txt
	  bbbb.txt
	  cccc/dddd.txt
	  cccc/eeee/ffff.txt
	  gggg.txt
	>;

	my $td = make-tree(@tree);

	my $rule = Path::Finder.file;

	my @files = $rule.in($td, :order(PreOrder)).map: { unixify( $_, $td ) }
	is-deeply(@files, @depth_pre, "Depth first iteration (pre)" ) or diag @files.perl;

	my @files2 = $rule.in($td, :order(PostOrder)).map: { unixify( $_, $td ) } 
	is-deeply(@files2, @depth_post, "Depth first iteration (post)" ) or diag @files2.perl;

}

done-testing;

# This file is derived from Path-Iterator-Rule, Copyright (c) 2013 by David Golden.
