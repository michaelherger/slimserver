package Slim::Utils::OS::Custom;

use strict;
use base qw(Slim::Utils::OS::Linux);

sub initDetails {
	my $class = shift;

	$class->{osDetails} = $class->SUPER::initDetails();
	$class->{osDetails}->{name} = "My very own Unix based OS";

	return $class->{osDetails};
}

# we're doing the player type registration in here, as initDetails would be too early
sub postInitPrefs {
	my $class = shift;

        # disable support for video and photo scanning
        $::MEDIASUPPORT = 0;

        Slim::Networking::Slimproto->addPlayerClass(13, 'm6encore', {
		client => 'Slim::Player::M6Encore',
		display => 'Slim::Display::NoDisplay'
	});

	$class->SUPER::postInitPrefs();
}

sub dirsFor {
	my ($class, $dir) = @_;

	my @dirs = ();
	
	if ($dir =~ /^(?:prefs)$/) {

		push @dirs, $::prefsdir || "/etc/encoreserver/prefs";

	} elsif ($dir eq 'log') {

		push @dirs, $::logdir || "/usr/encore/server/Logs";

	} elsif ($dir eq 'cache') {

		# XXX: cachedir pref is going to cause a problem here, we need to ignore it
		push @dirs, $::cachedir || "/etc/encoreserver/cache";

	} else {

		push @dirs, $class->SUPER::dirsFor($dir);

	}

	return wantarray() ? @dirs : $dirs[0];
}

sub skipPlugins {
	my $class = shift;
	
	return (
		qw(
			ACLFileTest ImageBrowser SN
			PreventStandby iTunes MusicMagic
		),
		$class->SUPER::skipPlugins(),
	);
}


# don't store potential firmware updates on this system
# but let the players download directly (if possible)
sub directFirmwareDownload { 1 };

1;


