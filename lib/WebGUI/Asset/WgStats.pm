package WebGUI::Asset::WgStats;


use strict;
use Tie::IxHash;
use base ( 'WebGUI::AssetAspect::Installable', 'WebGUI::Asset' );
use WebGUI::Utility;
use WebGUI::AssetCollateral::WgStats;
use WebGUI::AssetCollateral::WgAssetStats;
use JSON;

#-------------------------------------------------------------------
sub definition {
    my $class      = shift;
    my $session    = shift;
    my $definition = shift;
    tie my %properties, 'Tie::IxHash', (
    );
    push @{$definition}, {
        assetName         => 'WebGUI Stats',
        autoGenerateForms => 1,
        tableName         => 'WgStats',
        className         => 'WebGUI::Asset::WgStats',
        properties        => \%properties,
        };
    return $class->SUPER::definition( $session, $definition );
} 

#-------------------------------------------------------------------
sub install {
      my $class     = shift;
      my $session   = shift;
      WebGUI::AssetCollateral::WgStats->crud_createTable($session);
      WebGUI::AssetCollateral::WgAssetStats->crud_createTable($session);
      $class->next::method( $session );
}

#-------------------------------------------------------------------
sub uninstall {
      my $class     = shift;
      my $session   = shift;
      WebGUI::AssetCollateral::WgStats->crud_dropTable($session);
      WebGUI::AssetCollateral::WgAssetStats->crud_dropTable($session);
      $class->next::method( $session );
}


#-------------------------------------------------------------------
sub view {
    my $self = shift;
    return "Nothing to see here just yet. Still collecting initial data.";
}

#-------------------------------------------------------------------
sub www_receiveStats {
    my $self = shift;
    my $session = $self->session;
    my $stats = JSON->new->decode($session->form->get('stats'));
    my $assetTypes = $stats->{assetTypes};
    my $submission =  WebGUI::AssetCollateral::WgStats->create($session, $stats);
    foreach my $assetType (@{$assetTypes}) {
        WebGUI::AssetCollateral::WgAssetStats->create($session, {
            submissionId    => $submission->getId,
            quantity        => $assetType->{quantity},
            className       => $assetType->{className},
        });
    }
}


1;

#vim:ft=perl
