package Slim::Player::M6Encore;

use strict;
use vars qw(@ISA);

BEGIN {
	require Slim::Player::Transporter;
	push @ISA, qw(Slim::Player::Transporter);
}

sub model {
	return 'm6encore';
}

sub modelName { 'M6 Encore' }

1;

__END__
