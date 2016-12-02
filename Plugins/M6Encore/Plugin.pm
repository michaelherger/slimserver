package Plugins::M6Encore::Plugin;

use strict;

use base qw(Slim::Plugin::Base);

# we're going to override the stock DigitalInput plugin with our own version
sub postinitPlugin {
	my $class = shift;

	require Plugins::M6Encore::DigitalInput;
	Slim::Plugin::DigitalInput::Plugin->initPlugin();
	
	Slim::Networking::Slimproto->addPlayerClass(13, 'm6encore', {
		client => 'Plugins::M6Encore::Player',
		display => 'Slim::Display::NoDisplay'
	});
}

1;