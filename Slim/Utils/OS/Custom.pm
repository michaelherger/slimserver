package Slim::Utils::OS::Custom;

use strict;
use base qw(Slim::Utils::OS::Linux);

sub initDetails {
	my $class = shift;

	$class->{osDetails} = $class->SUPER::initDetails();
	$class->{osDetails}->{osName} = "Encore OS";

	return $class->{osDetails};
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
			PreventStandby MusicMagic
			UPnP
		),
		$class->SUPER::skipPlugins(),
	);
}


# don't store potential firmware updates on this system
# but let the players download directly (if possible)
sub directFirmwareDownload { 1 };

1;


